import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
Popup {
    id: root
    width: parent.width * 0.8
    height: parent.height * 0.7
    anchors.centerIn: parent
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    padding: 20

    background: Rectangle {
        color: "#FFFFFF"
        radius: 10
        border.color: "#2ecc71"
        border.width: 2
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 15

        Label {
            text: "Справка"
            font.bold: true
            font.pixelSize: 22
            Layout.alignment: Qt.AlignHCenter
            color: "#2c3e50"
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            TextArea {
                text:
                    "<h3>Добро пожаловать в систему управления!</h3>" +
                    "<p>Это справочная информация по работе с приложением:</p>" +
                    "<ul>" +
                    "<li><b>Показатели</b> - просмотр аналитики</li>" +
                    "<li><b>Склады</b> - управление складскими помещениями</li>" +
                    "<li><b>Товары</b> - управление номенклатурой</li>" +
                    "<li><b>Документы</b> - работа с накладными</li>" +
                    "</ul>" +
                    "<p>Для получения дополнительной помощи обращайтесь:</p>" +
                    "<p>Email: support@example.com<br>Телефон: +7 (495) 123-45-67</p>"
                textFormat: Text.RichText
                wrapMode: Text.WordWrap
                readOnly: true
            }
        }

        Button {
            text: "Закрыть"
            Layout.alignment: Qt.AlignRight
            onClicked: root.close()

            background: Rectangle {
                color: "#2ecc71"
                radius: 5
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
