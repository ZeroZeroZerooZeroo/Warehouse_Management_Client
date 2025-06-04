import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels 1.0
import "../components"

Page {
    id: root
    property int warehouseId: -1
    property string warehouseName: ""

    signal backToWarehouses()

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
    property string searchText: ""
    property var currentItem: null


    ListModel {
        id: inventoryModel
        Component.onCompleted: loadSampleData()

        function loadSampleData() {
            append({
                id: 1,
                sku: "PRD001",
                name: "Ноутбук HP EliteBook",
                quantity: 15,
                reserved: 3,
                unit: "шт.",
                location: "Секция A-01",
                batch: "B20230501",
                minStock: 5,
                maxStock: 50,
                purchasePrice: 850.00,
                sellingPrice: 1200.00,
                selected: false
            });
            append({
                id: 2,
                sku: "PRD002",
                name: "Монитор Dell 24\"",
                quantity: 8,
                reserved: 0,
                unit: "шт.",
                location: "Секция B-02",
                batch: "B20230415",
                minStock: 3,
                maxStock: 20,
                purchasePrice: 350.00,
                sellingPrice: 499.99,
                selected: false
            });
            append({
                id: 3,
                sku: "PRD003",
                name: "Клавиатура Logitech",
                quantity: 25,
                reserved: 5,
                unit: "шт.",
                location: "Секция C-05",
                batch: "B20230610",
                minStock: 10,
                maxStock: 100,
                purchasePrice: 45.00,
                sellingPrice: 79.99,
                selected: false
            });
            filterInventory();
        }
    }

    ListModel {
        id: filteredInventoryModel
    }


    Component {
        id: inventoryItemDialog
        Dialog {
            id: dialog
            property bool isNew: false
            modal: true
            width: Math.min(600, parent.width * 0.9)
            title: isNew ? "Добавить товар" : "Редактировать товар"
            standardButtons: Dialog.Ok | Dialog.Cancel

            GridLayout {
                columns: 2
                width: parent.width
                columnSpacing: 10
                rowSpacing: 10

                Label { text: "SKU:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: skuField
                    text: currentItem ? currentItem.sku : ""
                    Layout.fillWidth: true
                }

                Label { text: "Наименование:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: nameField
                    text: currentItem ? currentItem.name : ""
                    Layout.fillWidth: true
                }

                Label { text: "Количество:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: quantityField
                    text: currentItem ? currentItem.quantity : ""
                    validator: DoubleValidator { bottom: 0 }
                    Layout.fillWidth: true
                }

                Label { text: "Зарезервировано:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: reservedField
                    text: currentItem ? currentItem.reserved : ""
                    validator: DoubleValidator { bottom: 0 }
                    Layout.fillWidth: true
                }

                Label { text: "Ед. измерения:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: unitField
                    text: currentItem ? currentItem.unit : ""
                    Layout.fillWidth: true
                }

                Label { text: "Место хранения:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: locationField
                    text: currentItem ? currentItem.location : ""
                    Layout.fillWidth: true
                }

                Label { text: "Партия:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: batchField
                    text: currentItem ? currentItem.batch : ""
                    Layout.fillWidth: true
                }

                Label { text: "Мин. запас:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: minStockField
                    text: currentItem ? currentItem.minStock : ""
                    validator: IntValidator { bottom: 0 }
                    Layout.fillWidth: true
                }

                Label { text: "Макс. запас:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: maxStockField
                    text: currentItem ? currentItem.maxStock : ""
                    validator: IntValidator { bottom: 0 }
                    Layout.fillWidth: true
                }
            }

            onAccepted: {
                if (isNew) {
                    inventoryModel.append({
                        id: inventoryModel.count + 1,
                        sku: skuField.text,
                        name: nameField.text,
                        quantity: parseFloat(quantityField.text),
                        reserved: parseFloat(reservedField.text),
                        unit: unitField.text,
                        location: locationField.text,
                        batch: batchField.text,
                        minStock: parseInt(minStockField.text),
                        maxStock: parseInt(maxStockField.text),
                        purchasePrice: 0,
                        sellingPrice: 0,
                        selected: false
                    });
                } else {
                    currentItem.sku = skuField.text;
                    currentItem.name = nameField.text;
                    currentItem.quantity = parseFloat(quantityField.text);
                    currentItem.reserved = parseFloat(reservedField.text);
                    currentItem.unit = unitField.text;
                    currentItem.location = locationField.text;
                    currentItem.batch = batchField.text;
                    currentItem.minStock = parseInt(minStockField.text);
                    currentItem.maxStock = parseInt(maxStockField.text);
                }
                filterInventory();
            }
        }
    }


    function filterInventory() {
        filteredInventoryModel.clear();
        var search = searchField.text.toLowerCase();

        for (var i = 0; i < inventoryModel.count; i++) {
            var item = inventoryModel.get(i);
            var match = search.length === 0;

            if (!match) {
                match = item.sku.toLowerCase().includes(search) ||
                        item.name.toLowerCase().includes(search) ||
                        item.location.toLowerCase().includes(search) ||
                        item.batch.toLowerCase().includes(search);
            }

            if (match) {
                filteredInventoryModel.append(item);
            }
        }
    }


    function deleteSelectedItems() {
        var idsToDelete = [];


        for (var i = 0; i < filteredInventoryModel.count; i++) {
            if (filteredInventoryModel.get(i).selected) {
                idsToDelete.push(filteredInventoryModel.get(i).id);
            }
        }


        for (var j = inventoryModel.count - 1; j >= 0; j--) {
            if (idsToDelete.includes(inventoryModel.get(j).id)) {
                inventoryModel.remove(j);
            }
        }

        filterInventory();
    }

    background: Rectangle { color: "#ECF0F1" }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0


        Rectangle {
            Layout.fillWidth: true
            height: 60
            color: "#D6DBDF"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Button {
                    text: "Назад"
                    icon.source: "qrc:/images/back.png"
                    onClicked: backToWarehouses()
                }

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    placeholderText: "Поиск по товарам..."
                    onTextChanged: filterInventory()
                }

                Button {
                    text: "Очистить"
                    onClicked: searchField.text = ""
                }
            }
        }


        Rectangle {
            Layout.fillWidth: true
            height: 50
            color: "#D6DBDF"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 10

                Button {
                    text: "Добавить товар"
                    icon.source: "qrc:/images/add.png"
                    onClicked: {
                        currentItem = null;
                        inventoryItemDialog.createObject(root, {isNew: true}).open();
                    }
                }

                Button {
                    text: "Редактировать"
                    icon.source: "qrc:/images/edit.png"
                    enabled: tableView.currentRow >= 0
                    onClicked: {
                        currentItem = filteredInventoryModel.get(tableView.currentRow);
                        inventoryItemDialog.createObject(root, {isNew: false}).open();
                    }
                }

                Button {
                    text: "Удалить выбранные"
                    icon.source: "qrc:/images/delete.png"
                    enabled: {
                        for (var i = 0; i < filteredInventoryModel.count; i++) {
                            if (filteredInventoryModel.get(i).selected) return true;
                        }
                        return false;
                    }
                    onClicked: deleteSelectedItems()
                }

                Button {
                    text: "Инвентаризация"
                    icon.source: "qrc:/images/inventory.png"
                }

                Button {
                    text: "Печать остатков"
                    icon.source: "qrc:/images/print.png"
                }
            }
        }


        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: tableView
                model: filteredInventoryModel
                boundsBehavior: Flickable.StopAtBounds
                interactive: true


                property var columnWidths: [50, 100, 250, 80, 80, 80, 150, 120, 100, 100, 100, 100]
                width: {
                    var total = 0;
                    for (var i = 0; i < columnWidths.length; i++) {
                        total += columnWidths[i];
                    }
                    return Math.max(total, parent.width);
                }


                header: Row {
                    width: tableView.width
                    spacing: 0


                    Repeater {
                        model: ["", "SKU", "Наименование", "Кол-во", "Резерв", "Ед.", "Место", "Партия", "Мин", "Макс", "Цена зак.", "Цена прод."]

                        Rectangle {
                            width: tableView.columnWidths[index]
                            height: 40
                            color: "#3498db"
                            border.color: "#2980b9"

                            Label {
                                anchors.fill: parent
                                padding: 5
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: index === 0 ? Text.AlignHCenter : Text.AlignLeft
                                color: "white"
                                font.bold: true
                                text: modelData
                                elide: Text.ElideRight
                            }
                        }
                    }
                }


                delegate: Rectangle {
                    width: tableView.width
                    height: 40
                    color: index % 2 === 0 ? "#FFFFFF" : "#F2F4F4"

                    Row {
                        anchors.fill: parent
                        spacing: 0


                        Rectangle {
                            width: tableView.columnWidths[0]
                            height: parent.height
                            color: "transparent"

                            CheckBox {
                                anchors.centerIn: parent
                                checked: model.selected
                                onCheckedChanged: model.selected = checked
                            }
                        }


                        TextCell { width: tableView.columnWidths[1]; text: model.sku }
                        TextCell {
                            width: tableView.columnWidths[2];
                            text: model.name
                            elide: Text.ElideRight
                        }
                        TextCell {
                            width: tableView.columnWidths[3];
                            text: model.quantity
                            color: model.quantity < model.minStock ? "#e74c3c" : "black"
                        }
                        TextCell {
                            width: tableView.columnWidths[4];
                            text: model.reserved
                            color: model.reserved > 0 ? "#3498db" : "black"
                        }
                        TextCell { width: tableView.columnWidths[5]; text: model.unit }
                        TextCell { width: tableView.columnWidths[6]; text: model.location }
                        TextCell { width: tableView.columnWidths[7]; text: model.batch }
                        TextCell { width: tableView.columnWidths[8]; text: model.minStock }
                        TextCell { width: tableView.columnWidths[9]; text: model.maxStock }
                        TextCell { width: tableView.columnWidths[10]; text: "₽" + (model.purchasePrice || 0).toFixed(2) }
                        TextCell { width: tableView.columnWidths[11]; text: "₽" + (model.sellingPrice || 0).toFixed(2) }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: tableView.currentIndex = index
                    }
                }

                highlight: Rectangle {
                    color: "#D6EAF8"
                    radius: 2
                }
            }
        }


        Rectangle {
            Layout.fillWidth: true
            height: 30
            color: "#2C3E50"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                spacing: 20

                Label {
                    color: "white"
                    text: `Склад: ${warehouseName}`
                }

                Label {
                    color: "white"
                    text: `Товаров: ${filteredInventoryModel.count}`
                }

                Label {
                    color: "white"
                    text: {
                        var selected = 0;
                        for (var i = 0; i < filteredInventoryModel.count; i++) {
                            if (filteredInventoryModel.get(i).selected) selected++;
                        }
                        return `Выбрано: ${selected}`;
                    }
                }
            }
        }
    }


    component TextCell: Label {
        width: parent.width
        height: parent.height
        padding: 5
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        elide: Text.ElideRight
    }

    Component.onCompleted: {
        filterInventory();
        warehouseName = "Основной склад";
    }
}
