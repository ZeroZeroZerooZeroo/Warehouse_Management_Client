import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

Page {
    id: root
    signal loginSuccess()
    signal goToRegistration()
    signal goToForgotPassword()

    background: Rectangle {
        color: "#ECF0F1"
    }
    property var loginResponse: null
    property bool isLoginSuccess: false
    property string errorMessage: ""


    Connections {
        id: apiConnections
        target: usersApi

        function onUsersLoginPOSTSignal(userMap) {
            console.log("Успешный ответ сервера:", JSON.stringify(userMap))
            console.log("user_id:", userMap.user_id)
            if (userMap.user_id>0&&userMap.username ===loginField.text) {
                root.loginResponse = userMap;
                root.isLoginSuccess = true;
                root.errorMessage = "";

                loginSuccess({
                    user_id: userMap.user_id,

                    username: userMap.username,
                    email: userMap.email,
                    role: userMap.role,
                    is_active: userMap.is_active,
                    created_at: userMap.created_at,
                    last_login: userMap.last_login,
                    inn: userMap.inn,
                    organization: userMap.organization,
                    role_id: userMap.role_id

                });

            } else {
                errorMessage = "Ошибка: пользователь не найден";
            }
        }

        function onUsersLoginPOSTSignalError(error_str) {
            errorMessage = "Ошибка сервера: " + error_str;
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: 400

        Logo {
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: "Вход"
            font.pixelSize: 24
            color: "#2C3E50"
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            visible: errorMessage !== ""
            text: errorMessage
            color: "red"
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: loginField
            placeholderText: "Введите логин"
            Layout.fillWidth: true
            background: Rectangle {
                radius: 5
                border.color: "#3498DB"
                border.width: 1
            }
        }

        TextField {
            id: passwordField
            placeholderText: "Введите пароль"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            background: Rectangle {
                radius: 5
                border.color: "#3498DB"
                border.width: 1
            }
        }

        Button {
            text: "Войти"
            Layout.fillWidth: true
            onClicked: {
                if (loginField.text === "" || passwordField.text === "") {
                    errorMessage = "Логин и пароль не могут быть пустыми";
                    return;
                }

                errorMessage = "";
                isLoginSuccess = false;

                usersApi.qmlUsersLoginPOST(loginField.text, passwordField.text);
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                color: "#1ABC9C"
                radius: 5
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "Забыли пароль?"
                flat: true
                Layout.fillWidth: true
                onClicked: root.goToForgotPassword()

                contentItem: Text {
                    text: parent.text
                    color: "#3498DB"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Button {
                text: "Регистрация"
                flat: true
                Layout.fillWidth: true
                onClicked: root.goToRegistration()

                contentItem: Text {
                    text: parent.text
                    color: "#3498DB"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
