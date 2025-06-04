import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"
Page {
    id: root
    signal backToLogin()
    signal registrationSuccess()

    background: Rectangle {
        color: "#ECF0F1"
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: 400

        Logo {
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: "Регистрация"
            font.pixelSize: 24
            color: "#2C3E50"
            Layout.alignment: Qt.AlignHCenter
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

        TextField {
            id: repeatPasswordField
            placeholderText: "Повторите пароль"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            background: Rectangle {
                radius: 5
                border.color: "#3498DB"
                border.width: 1
            }
        }

        TextField {
            id: emailField
            placeholderText: "Введите почту"
            Layout.fillWidth: true
            background: Rectangle {
                radius: 5
                border.color: "#3498DB"
                border.width: 1
            }
        }

        Button {
            text: "Зарегистрироваться"
            Layout.fillWidth: true
            onClicked: root.registrationSuccess()

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

        Button {
            text: "Назад"
            Layout.fillWidth: true
            onClicked: root.backToLogin()

            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                color: "#2C3E50"
                radius: 5
            }
        }
    }
}
