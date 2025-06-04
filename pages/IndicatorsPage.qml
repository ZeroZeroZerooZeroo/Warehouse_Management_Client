import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.15
import "../components"

Page {
    id: root
    signal logout()
    signal goToIndicators()
    signal goToPurchases()
    signal goToSales()
    signal goToWarehouses()
    signal goToProducts()
    signal goToCounterparties()
    signal goToMoney()
    signal goToForecasting()
    signal goToNotifications()
    signal goToHelp()
    signal goToProfile()
    signal goToMain()
    signal goToDocuments()

  
    onGoToNotifications: notificationPopup.open()

   
    Popup {
        id: notificationPopup
        width: parent.width * 0.8
        height: parent.height * 0.7
        anchors.centerIn: parent
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        padding: 0

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
                    model: notificationModel
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
                onClicked: notificationPopup.close()

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


    ListModel {
        id: notificationModel
        ListElement {
            title: "Новая поставка";
            message: "Заказ №4512 прибыл на склад";
            time: "10:30"
        }
        ListElement {
            title: "Обновление системы";
            message: "Доступно обновление версии 2.4";
            time: "09:15"
        }
        ListElement {
            title: "Просроченный платеж";
            message: "Счет №7841 просрочен на 3 дня";
            time: "Вчера"
        }
        ListElement {
            title: "Новый заказ";
            message: "Получен новый заказ от ООО 'Ромашка'";
            time: "Вчера"
        }
    }

    background: Rectangle {
        color: "#ECF0F1"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Header {
            id: header
            Layout.fillWidth: true
            userInfo: "Иван\npochta@example.com"
            onClicked: {
                switch(pageName) {
                    case "Главная": root.goToMain(); break;
                    case "Показатели": root.goToIndicators(); break;
                    case "Закупки": root.goToPurchases(); break;
                    case "Продажи": root.goToSales(); break;
                    case "Склады": root.goToWarehouses(); break;
                    case "Товары": root.goToProducts(); break;
                    case "Контрагенты": root.goToCounterparties(); break;
                    case "Деньги": root.goToMoney(); break;
                    case "Прогнозирование": root.goToForecasting(); break;
                    case "Уведомления": root.goToNotifications(); break;
                    case "Справка": root.goToHelp(); break;
                    case "Профиль": root.goToProfile(); break;
                    case "Документы": root.goToDocuments(); break;
                }
            }
        }

  
        Rectangle {
            id: headermini
            Layout.fillWidth: true
            height: 20
            color: "#2C3E50"

            Row {
                anchors.fill: parent
                anchors.leftMargin: 10
                spacing: 0

                HeaderButton {
                    height: parent.height
                    text: "Показатели"
                    iconSource: "qrc:/images/stats.png"
                }

                HeaderButton {
                    height: parent.height
                    text: "Документы"
                    iconSource: "qrc:/images/purchase.png"
                    onClicked: { root.goToDocuments();}
                }
            }
        }

    
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            
            ColumnLayout {
                id: leftPanel
                width: 200
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: 10
                    topMargin: 60 
                }
                spacing: 15

                Label {
                    text: "Показатели"
                    font.bold: true
                    font.pixelSize: 18
                    Layout.alignment: Qt.AlignHCenter
                }

                ColumnLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter

                    ButtonGroup {
                        id: periodGroup
                    }

                    RadioButton {
                        text: "Неделя"
                        checked: true
                        ButtonGroup.group: periodGroup
                    }

                    RadioButton {
                        text: "Месяц"
                        ButtonGroup.group: periodGroup
                    }

                    RadioButton {
                        text: "Год"
                        ButtonGroup.group: periodGroup
                    }
                }

               
                ColumnLayout {
                    spacing: 5
                    Layout.alignment: Qt.AlignHCenter

                    Label {
                        text: "Деньги"
                        font.bold: true
                        font.pixelSize: 16
                    }

                    Label {
                        text: "12 345 ₽"
                        font.pixelSize: 20
                        color: "green"
                    }
                }
            }

  
            Rectangle {
                id: firstGraph
                width: parent.width - leftPanel.width - 30  
                height: (parent.height - 100) / 2
                anchors {
                    left: leftPanel.right
                    top: parent.top
                    topMargin: 60
                    leftMargin: 10
                    rightMargin: 10  
                }
                color: "white"
                border.color: "#DDD"
                radius: 5

                ChartView {
                    id: chartView1
                    anchors.fill: parent
                    anchors.margins: 5
                    antialiasing: true
                    legend.visible: false
                    backgroundColor: "transparent"

                    LineSeries {
                        name: "Series 1"
                        color: "blue"
                        width: 2

                        XYPoint { x: 0; y: 0 }
                        XYPoint { x: 1; y: 2 }
                        XYPoint { x: 2; y: 3 }
                        XYPoint { x: 3; y: 1 }
                        XYPoint { x: 4; y: 4 }
                        XYPoint { x: 5; y: 2 }
                    }

                    ValueAxis {
                        id: axisX1
                        min: 0
                        max: 5
                        tickCount: 6
                        labelFormat: "%.0f"
                    }

                    ValueAxis {
                        id: axisY1
                        min: 0
                        max: 4
                        tickCount: 5
                        labelFormat: "%.0f"
                    }
                }
            }

       
            Rectangle {
                id: secondGraph
                width: firstGraph.width  
                height: firstGraph.height
                anchors {
                    left: leftPanel.right  
                    top: firstGraph.bottom
                    topMargin: 10
                    leftMargin: 10
                    rightMargin: 10  
                }
                color: "white"
                border.color: "#DDD"
                radius: 5

                ChartView {
                    id: chartView2
                    anchors.fill: parent
                    anchors.margins: 5
                    antialiasing: true
                    legend.visible: false
                    backgroundColor: "transparent"

                    LineSeries {
                        name: "Series 2"
                        color: "green"
                        width: 2

                        XYPoint { x: 0; y: 1 }
                        XYPoint { x: 1; y: 3 }
                        XYPoint { x: 2; y: 2 }
                        XYPoint { x: 3; y: 4 }
                        XYPoint { x: 4; y: 1 }
                        XYPoint { x: 5; y: 3 }
                    }

                    ValueAxis {
                        id: axisX2
                        min: 0
                        max: 5
                        tickCount: 6
                        labelFormat: "%.0f"
                    }

                    ValueAxis {
                        id: axisY2
                        min: 0
                        max: 4
                        tickCount: 5
                        labelFormat: "%.0f"
                    }
                }
            }
        }
    }
}
