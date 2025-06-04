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
            height: 40
            color: "#2C3E50"

            RowLayout {
                anchors.fill: parent
                spacing: 5
                anchors.leftMargin: 10

                HeaderButton {
                    text: "Показатели"
                    iconSource: "qrc:/images/stats.png"
                    onClicked: root.goToIndicators()
                }

                HeaderButton {
                    text: "Документы"
                    iconSource: "qrc:/images/purchase.png"
                }
            }
        }


        Rectangle {
            Layout.fillWidth: true
            height: 60
            color: "#D6DBDF"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                spacing: 10

                CheckBox {
                    id: selectAllCheckBox
                    text: "Все"
                    onCheckedChanged: {
                        for (var i = 0; i < filteredDocumentModel.count; i++) {
                            var docNumber = filteredDocumentModel.get(i).number
                            updateSourceModelSelection(docNumber, checked)
                        }
                        filterDocuments()
                    }
                }

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    placeholderText: "Поиск по документам..."
                    onTextChanged: filterDocumentsTimer.restart()
                }

                Button {
                    text: "Очистить"
                    onClicked: {
                        searchField.text = ""
                        filterDocuments()
                    }
                }
            }
        }


        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: documentListView
                anchors.fill: parent
                model: filteredDocumentModel
                clip: true

                delegate: Rectangle {
                    width: parent ? parent.width : documentListView.width
                    height: 40
                    color: index % 2 === 0 ? "#FFFFFF" : "#F2F4F4"

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        spacing: 10

                        CheckBox {
                            checked: model.selected
                            onCheckedChanged: {
                                filteredDocumentModel.setProperty(index, "selected", checked)
                                updateSourceModelSelection(model.number, checked)
                            }
                        }

                        Label {
                            text: model.number
                            Layout.preferredWidth: 100
                            elide: Text.ElideRight
                        }

                        Label {
                            text: model.date
                            Layout.preferredWidth: 100
                            elide: Text.ElideRight
                        }

                        Label {
                            text: model.type
                            Layout.preferredWidth: 150
                            elide: Text.ElideRight
                        }

                        Label {
                            text: model.counterparty
                            Layout.preferredWidth: 200
                            elide: Text.ElideRight
                        }

                        Label {
                            text: model.amount
                            Layout.preferredWidth: 100
                            horizontalAlignment: Text.AlignRight
                            elide: Text.ElideRight
                        }

                        Label {
                            text: model.status
                            Layout.preferredWidth: 100
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }


    Timer {
        id: filterDocumentsTimer
        interval: 300
        onTriggered: filterDocuments()
    }


    ListModel {
        id: filteredDocumentModel
    }


    ListModel {
        id: sourceDocumentModel
        Component.onCompleted: initializeModel()

        function initializeModel() {
            append({selected: false, number: "Д-0001", date: "01.01.2023", type: "Поступление", counterparty: "ООО Поставщик", amount: "12 345.00", status: "Проведен"})
            append({selected: false, number: "Д-0002", date: "02.01.2023", type: "Реализация", counterparty: "ИП Покупатель", amount: "8 765.00", status: "Проведен"})
            append({selected: false, number: "Д-0003", date: "03.01.2023", type: "Возврат", counterparty: "ООО Поставщик", amount: "1 234.00", status: "Черновик"})
            append({selected: false, number: "Д-0004", date: "04.01.2023", type: "Поступление", counterparty: "ООО Ромашка", amount: "23 456.00", status: "Проведен"})
            append({selected: false, number: "Д-0005", date: "05.01.2023", type: "Реализация", counterparty: "ИП Иванов", amount: "15 678.00", status: "Черновик"})
            filterDocuments()
        }
    }

    Component.onCompleted: {

        if (sourceDocumentModel.count === 0) {
            sourceDocumentModel.initializeModel()
        }
    }


    function filterDocuments() {
        var searchText = searchField.text.toLowerCase()
        filteredDocumentModel.clear()


        console.log("Filtering documents. Search text:", searchText, "Total documents:", sourceDocumentModel.count)

        for (var i = 0; i < sourceDocumentModel.count; i++) {
            var item = sourceDocumentModel.get(i)
            var match = searchText.length === 0

            if (!match) {

                var props = ["number", "date", "type", "counterparty", "amount", "status"]
                for (var j = 0; j < props.length; j++) {
                    var prop = props[j]
                    var value = item[prop] ? item[prop].toString().toLowerCase() : ""
                    if (value.includes(searchText)) {
                        match = true
                        break
                    }
                }
            }

            if (match) {

                filteredDocumentModel.append({
                    selected: item.selected,
                    number: item.number,
                    date: item.date,
                    type: item.type,
                    counterparty: item.counterparty,
                    amount: item.amount,
                    status: item.status
                })
                console.log("Document added:", item.number)
            }
        }
        console.log("Filtered documents count:", filteredDocumentModel.count)
    }


    function updateSourceModelSelection(number, selected) {
        for (var i = 0; i < sourceDocumentModel.count; i++) {
            if (sourceDocumentModel.get(i).number === number) {
                sourceDocumentModel.setProperty(i, "selected", selected)
                break
            }
        }
    }
}
