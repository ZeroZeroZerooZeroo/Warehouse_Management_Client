import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
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


    background: Rectangle {
        color: "#ECF0F1"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

  
        Rectangle {
            id: header
            Layout.fillWidth: true
            height: 60
            color: "#2C3E50"

            RowLayout {
                anchors.fill: parent
                spacing: 5

                HeaderButton {
                    text: "Главная"
                    iconSource: "qrc:/images/home.png"
                    onClicked: root.goToMain()
                }

                HeaderButton {
                    text: "Показатели"
                    iconSource: "qrc:/images/stats.png"
                    onClicked: root.goToIndicators()
                }

                HeaderButton {
                    text: "Закупки"
                    iconSource: "qrc:/images/purchase.png"
                    onClicked: root.goToPurchases()
                }

                HeaderButton {
                    text: "Продажи"
                    iconSource: "qrc:/images/sales.png"
                    onClicked: root.goToSales()
                }

                HeaderButton {
                    text: "Склады"
                    iconSource: "qrc:/images/warehouse.png"
                    onClicked: root.goToWarehouses()
                }

                HeaderButton {
                    text: "Товары"
                    iconSource: "qrc:/images/products.png"
                    onClicked: root.goToProducts()
                }

                HeaderButton {
                    text: "Контрагенты"
                    iconSource: "qrc:/images/partners.png"
                    onClicked: root.goToCounterparties()
                }

                HeaderButton {
                    text: "Деньги"
                    iconSource: "qrc:/images/money.png"
                    onClicked: root.goToMoney()
                }

                HeaderButton {
                    text: "Прогнозирование"
                    iconSource: "qrc:/images/forecast.png"
                    onClicked: root.goToForecasting()
                }

                HeaderButton {
                    text: "Уведомления"
                    iconSource: "qrc:/images/notifications.png"
                    onClicked: root.goToNotifications()
                }

                HeaderButton {
                    text: "Справка"
                    iconSource: "qrc:/images/help.png"
                    onClicked: root.goToHelp()
                }

                Item {
                    Layout.fillWidth: true
                }

                Label {
                    text: "Иван\npochta@example.com"
                    color: "white"
                    font.pixelSize: 12
                }

                HeaderButton {
                    text: "Профиль"
                    iconSource: "qrc:/images/profile.png"
                    onClicked: root.goToProfile()
                }
            }
        }








        Button {
            text: "Показать справку"
            onClicked: popup.open()
        }

        Popup {
            id: popup
            width: 300
            height: 200
            modal: true

            Column {
                anchors.centerIn: parent
                spacing: 10
                Label {
                    text: "Дополнительная информация"
                    font.bold: true
                }
                Label {
                    text: "Версия: 1.0\nТехподдержка: support@example.com"
                }
            }
        }
    }
}
