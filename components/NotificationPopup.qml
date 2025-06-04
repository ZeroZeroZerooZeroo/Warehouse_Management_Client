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
    padding: 0

    property ListModel notificationModel: ListModel {
        ListElement { title: "Новая поставка"; message: "Заказ №4512 прибыл на склад"; time: "10:30" }
        ListElement { title: "Обновление системы"; message: "Доступно обновление версии 2.4"; time: "09:15" }
        ListElement { title: "Просроченный платеж"; message: "Счет №7841 просрочен на 3 дня"; time: "Вчера" }
        ListElement { title: "Новый заказ"; message: "Получен новый заказ от ООО 'Ромашка'"; time: "Вчера" }
    }

    background: Rectangle {
        color: "#FFFFFF"
        radius: 10
        border.color: "#3498db"
        border.width: 2
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 15

        Label {
            text: "Уведомления"
            font.bold: true
            font.pixelSize: 22
            Layout.alignment: Qt.AlignHCenter
            color: "#2c3e50"
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: notificationList
                width: parent.width
                model: root.notificationModel
                spacing: 5
                delegate: Rectangle {
                    width: notificationList.width
                    height: 70
                    color: index % 2 === 0 ? "#f8f9fa" : "#ffffff"
                    radius: 5

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10

                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: title
                                font.bold: true
                                font.pixelSize: 16
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Label {
                                text: time
                                color: "#7f8c8d"
                                font.pixelSize: 12
                            }
                        }

                        Label {
                            text: message
                            Layout.fillWidth: true
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                            elide: Text.ElideRight
                            color: "#34495e"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: console.log("Уведомление выбрано:", title)
                    }
                }
            }
        }

        Button {
            text: "Закрыть"
            Layout.alignment: Qt.AlignRight
            onClicked: root.close()

            background: Rectangle {
                color: "#3498db"
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
