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
    signal goToDocuments()

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
                        text: "Прогнозирование спроса"
                        font.pixelSize: 24
                        color: "#2C3E50"
                    }

                    Row {
                        spacing: 10
                        Label {
                            text: "Выберите товар:"
                            font.pixelSize: 16
                            verticalAlignment: Text.AlignVCenter
                            height: 40
                        }

                        ComboBox {
                            id: productComboBox
                            width: 300
                            height: 40
                            model: ListModel {
                                id: productsModel
                                ListElement { name: "Ноутбук ASUS X543"; product_id: 1 }
                                ListElement { name: "Смартфон Samsung A52"; product_id: 2 }
                                ListElement { name: "Монитор LG 24MP400"; product_id: 3 }
                                ListElement { name: "Принтер HP LaserJet"; product_id: 4 }
                            }
                            textRole: "name"
                        }
                    }

                    Row {
                        spacing: 10
                        Button {
                            text: "День"
                            width: 100
                            height: 40
                            background: Rectangle {
                                color: "#3498DB"
                                radius: 5
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: loadSalesHistory("day")
                        }
                        Button {
                            text: "Неделя"
                            width: 100
                            height: 40
                            background: Rectangle {
                                color: "#3498DB"
                                radius: 5
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: loadSalesHistory("week")
                        }
                        Button {
                            text: "Месяц"
                            width: 100
                            height: 40
                            background: Rectangle {
                                color: "#3498DB"
                                radius: 5
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: loadSalesHistory("month")
                        }

                        Button {
                            text: "Прогнозировать"
                            width: 150
                            height: 40
                            background: Rectangle {
                                color: "#27AE60"
                                radius: 5
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: generateForecast()
                        }
                    }

                    Label {
                        text: "История продаж"
                        font.pixelSize: 18
                        color: "#2C3E50"
                    }

                    Rectangle {
                        width: parent.width
                        height: 200
                        color: "white"
                        radius: 5

                        ListView {
                            id: salesHistoryView
                            anchors.fill: parent
                            anchors.margins: 10
                            model: salesHistoryModel
                            clip: true
                            delegate: Row {
                                spacing: 20
                                Label { text: date }
                                Label { text: "Количество: " + quantity + " шт." }
                                Label { text: "Цена: " + price + " руб." }
                                Label { text: "Прибыль: " + profit + " руб." }
                            }
                        }
                    }

                    Label {
                        text: "История прогнозирования"
                        font.pixelSize: 18
                        color: "#2C3E50"
                    }

                    Rectangle {
                        width: parent.width
                        height: 200
                        color: "white"
                        radius: 5

                        ListView {
                            id: forecastsHistoryView
                            anchors.fill: parent
                            anchors.margins: 10
                            model: forecastsHistoryModel
                            clip: true
                            delegate: Column {
                                spacing: 5
                                Label { text: "Дата прогноза: " + forecastDate }
                                Label { text: "Период: " + periodStart + " - " + periodEnd }
                                Label { text: "Товар: " + productName }
                                Label { text: "Прогнозируемое количество: " + predictedQuantity + " шт." }
                            }
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: salesHistoryModel
    }

    ListModel {
        id: forecastsHistoryModel
    }

    function loadSalesHistory(period) {
        salesHistoryModel.clear();
        var productId = productsModel.get(productComboBox.currentIndex).product_id;
        var productName = productsModel.get(productComboBox.currentIndex).name;

        if (productId === 1) {
            if (period === "day") {
                salesHistoryModel.append({ date: "2023-05-20", quantity: 5, price: 125000, profit: 25000 });
                salesHistoryModel.append({ date: "2023-05-20", quantity: 3, price: 125000, profit: 15000 });
            } else if (period === "week") {
                salesHistoryModel.append({ date: "2023-05-18", quantity: 2, price: 125000, profit: 10000 });
                salesHistoryModel.append({ date: "2023-05-17", quantity: 4, price: 125000, profit: 20000 });
                salesHistoryModel.append({ date: "2023-05-16", quantity: 1, price: 125000, profit: 5000 });
            } else if (period === "month") {
                salesHistoryModel.append({ date: "2023-05-10", quantity: 7, price: 125000, profit: 35000 });
                salesHistoryModel.append({ date: "2023-05-05", quantity: 3, price: 125000, profit: 15000 });
                salesHistoryModel.append({ date: "2023-05-01", quantity: 4, price: 125000, profit: 20000 });
            }
        } else if (productId === 2) {
            if (period === "day") {
                salesHistoryModel.append({ date: "2023-05-20", quantity: 8, price: 24990, profit: 7996 });
                salesHistoryModel.append({ date: "2023-05-20", quantity: 5, price: 24990, profit: 4995 });
            } else if (period === "week") {
                salesHistoryModel.append({ date: "2023-05-19", quantity: 6, price: 24990, profit: 5997 });
                salesHistoryModel.append({ date: "2023-05-18", quantity: 4, price: 24990, profit: 3998 });
                salesHistoryModel.append({ date: "2023-05-17", quantity: 7, price: 24990, profit: 6997 });
            } else if (period === "month") {
                salesHistoryModel.append({ date: "2023-05-15", quantity: 12, price: 24990, profit: 11996 });
                salesHistoryModel.append({ date: "2023-05-10", quantity: 9, price: 24990, profit: 8997 });
                salesHistoryModel.append({ date: "2023-05-05", quantity: 15, price: 24990, profit: 14995 });
            }
        }
    }

    function generateForecast() {
        var productId = productsModel.get(productComboBox.currentIndex).product_id;
        var productName = productsModel.get(productComboBox.currentIndex).name;

        var forecastId = forecastsHistoryModel.count + 1;
        var today = new Date();
        var startDate = new Date();
        var endDate = new Date();
        endDate.setDate(today.getDate() + 7);

        var predictedQuantity = 0;
        for (var i = 0; i < salesHistoryModel.count; i++) {
            predictedQuantity += salesHistoryModel.get(i).quantity;
        }
        predictedQuantity = Math.round(predictedQuantity / salesHistoryModel.count * 1.2);

        forecastsHistoryModel.append({
            forecastId: forecastId,
            forecastDate: today.toISOString().split('T')[0],
            periodStart: startDate.toISOString().split('T')[0],
            periodEnd: endDate.toISOString().split('T')[0],
            productName: productName,
            predictedQuantity: predictedQuantity
        });
    }

    Component.onCompleted: {
        forecastsHistoryModel.append({
            forecastId: 1,
            forecastDate: "2023-05-15",
            periodStart: "2023-05-16",
            periodEnd: "2023-05-23",
            productName: "Ноутбук ASUS X543",
            predictedQuantity: 15
        });

        forecastsHistoryModel.append({
            forecastId: 2,
            forecastDate: "2023-05-10",
            periodStart: "2023-05-11",
            periodEnd: "2023-05-18",
            productName: "Смартфон Samsung A52",
            predictedQuantity: 25
        });
    }
}
