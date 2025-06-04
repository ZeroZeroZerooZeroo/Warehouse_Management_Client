import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: header

    signal clicked(string pageName)

    property string userInfo: "Иван\npochta@example.com"

    Layout.fillWidth: true
    height: 60
    color: "#2C3E50"


    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        RowLayout {
            anchors.fill: parent
            spacing: 5

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
                    text: header.userInfo
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

    }
}
