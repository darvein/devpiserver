#!/usr/bin/env bats

VENV=/home/testuser/env
DEVPI_SERVER="http://localhost:3141"
USPW="testuser"
WHEEL_FILE="https://www.dropbox.com/s/l1hm31eu5a8i644/flugel_test-0.2-py2-none-any.whl"

push_wheel(){
    useradd testuser

    su -c "virtualenv ${VENV}" $USPW
    su -c "${VENV}/bin/pip install devpi-client" $USPW
    su -c "${VENV}/bin/devpi use ${DEVPI_SERVER}" $USPW

    su -c "${VENV}/bin/devpi user -c ${USPW} password=${USPW}" $USPW
    su -c "${VENV}/bin/devpi login ${USPW} --password=${USPW}" $USPW
    su -c "${VENV}/bin/devpi index -c dev bases=root/pypi" $USPW
    su -c "${VENV}/bin/devpi use ${USPW}/dev" $USPW

    su -c "wget ${WHEEL_FILE} -O ${VENV}/package.whl" $USPW
    su -c "${VENV}/bin/devpi upload ${VENV}/package.whl" $USPW

    su -c "${VENV}/bin/pip search --index ${DEVPI_SERVER}/${USPW}/dev/ flugel_test | tee ${VENV}/output" $USPW

    return 1
}

clean(){
    rm -rf /home/${USPW}
    userdel testuser

    su -c "echo yes | ${VENV}/bin/devpi user --delete ${USPW} password=${USPW}" $USPW
    su -c "echo yes | ${VENV}/bin/devpi index --delete dev" $USPW

    return 1
}

@test "Test for pushing wheel python package" {
    run push_wheel

    PKG_FOUND=$(cat ${VENV}/output)
    PKG_ORIGINAL="/testuser/dev/flugel-test (0.2)  - The flugel_test module"

    # Validate if wheel package can be find in the the server
    [ $PKG_FOUND == $PKG_ORIGINAL ]

    run clean
}
