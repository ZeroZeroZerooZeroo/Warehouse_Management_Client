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

    onGoToNotifications: notificationPopup.open()
    onGoToHelp: helpPopup.open()


    NotificationPopup {
      id: notificationPopup
    }

    HelpPopup {
      id: helpPopup
    }


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

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#ECF0F1"

            ScrollView {
                anchors.fill: parent
                anchors.margins: 20

                Column {
                    width: parent.width
                    spacing: 20

                    Label {
                        text: "Добро пожаловать в систему управления складом!"
                        font.pixelSize: 24
                        color: "#2C3E50"
                    }

                    Label {
                        text: "Уведомления:"
                        font.pixelSize: 18
                        color: "#2C3E50"
                    }

                    Rectangle {
                        width: 1500
                        height: 100
                        color: "white"
                        radius: 5

                        Label {
                            anchors.centerIn: parent
                            text: "Новых уведомлений нет"
                            color: "#7F8C8D"
                        }
                    }

                    Label {
                        text: "Информация о системе:"
                        font.pixelSize: 18
                        color: "#2C3E50"
                    }

                    Rectangle {
                        width: 1500
                        height: 200
                        color: "white"
                        radius: 5

                        Column {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 5

                            Label {
                                text: "Версия системы: 1.0.0"
                                color: "#34495E"
                            }

                            Label {
                                text: "Дата последнего обновления: 20.05.2023"
                                color: "#34495E"
                            }

                            Label {
                                text: "Количество товаров на складе: 500"
                                color: "#34495E"
                            }

                            Label {
                                text: "Последние действия:"
                                color: "#34495E"
                            }

                            Label {
                                text: "- Уведомление\"'"
                                color: "#34495E"
                            }

                            Label {
                                text: "- Оформлена продажа №22"
                                color: "#34495E"
                            }
                        }
                    }
                }
            }
        }
    }
}
