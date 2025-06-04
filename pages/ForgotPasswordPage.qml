import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"
Page {
    id: root
    signal backToLogin()

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
            text: "Восстановление пароля"
            font.pixelSize: 24
            color: "#2C3E50"
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: "Введите email, указанный при регистрации. Мы отправим вам инструкции по восстановлению пароля."
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            color: "#34495E"
        }

        TextField {
            id: emailField
            placeholderText: "Введите email"
            Layout.fillWidth: true
            background: Rectangle {
                radius: 5
                border.color: "#3498DB"
                border.width: 1
            }
        }

        Button {
            text: "Отправить"
            Layout.fillWidth: true
            onClicked: root.backToLogin()

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
