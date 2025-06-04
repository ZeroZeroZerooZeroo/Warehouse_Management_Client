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

    property bool showArchived: false
    property int currentDocType: -1
    property string searchText: ""

    background: Rectangle {
        color: "#ECF0F1"
    }

    ListModel {
        id: docTypesModel

        function loadSampleData() {
            append({type_id: 1, name: "Поступление", prefix: "П", direction: "in"})
            append({type_id: 2, name: "Реализация", prefix: "Р", direction: "out"})
            append({type_id: 3, name: "Возврат", prefix: "В", direction: "in"})
            append({type_id: 4, name: "Перемещение", prefix: "М", direction: "internal"})
            append({type_id: 5, name: "Списание", prefix: "С", direction: "out"})
        }
        Component.onCompleted: loadSampleData()
    }

    ListModel {
        id: docStatusModel

        function loadSampleData() {
            append({status_id: 1, name: "Черновик"})
            append({status_id: 2, name: "Проведен"})
            append({status_id: 3, name: "Отменен"})
            append({status_id: 4, name: "Архив"})
        }
        Component.onCompleted: loadSampleData()
    }

    ListModel {
        id: sourceDocumentModel

        function initializeModel() {
            clear()
            append({
                document_id: 1,
                document_number: "П-0001",
                created_date: "2023-01-01T10:00:00",
                updated_at: "2023-01-01T12:30:00",
                status: "Проведен",
                comments: "Поставка от ООО Поставщик",
                customer_id: 1,
                supplier_id: 1,
                type_id: 1,
                document_status_id: 2,
                total_amount: 125000.00,
                warehouse_id: 1
            })
            append({
                document_id: 2,
                document_number: "Р-0002",
                created_date: "2023-01-02T14:15:00",
                updated_at: "2023-01-02T14:45:00",
                status: "Проведен",
                comments: "Продажа ИП Покупатель",
                customer_id: 2,
                supplier_id: 0,
                type_id: 2,
                document_status_id: 2,
                total_amount: 87650.00,
                warehouse_id: 1
            })
            append({
                document_id: 3,
                document_number: "В-0003",
                created_date: "2023-01-03T09:20:00",
                updated_at: "2023-01-03T11:10:00",
                status: "Черновик",
                comments: "Возврат от ООО Покупатель",
                customer_id: 3,
                supplier_id: 0,
                type_id: 3,
                document_status_id: 1,
                total_amount: 23400.00,
                warehouse_id: 1
            })
            append({
                document_id: 4,
                document_number: "М-0004",
                created_date: "2023-01-04T16:40:00",
                updated_at: "2023-01-04T16:40:00",
                status: "Проведен",
                comments: "Перемещение на склад 2",
                customer_id: 0,
                supplier_id: 0,
                type_id: 4,
                document_status_id: 2,
                total_amount: 0,
                warehouse_id: 1
            })
            append({
                document_id: 5,
                document_number: "С-0005",
                created_date: "2023-01-05T11:30:00",
                updated_at: "2023-01-05T11:30:00",
                status: "Черновик",
                comments: "Списание испорченного товара",
                customer_id: 0,
                supplier_id: 0,
                type_id: 5,
                document_status_id: 1,
                total_amount: 0,
                warehouse_id: 1
            })
            filterDocuments()
        }
        Component.onCompleted: initializeModel()
    }

    ListModel {
        id: filteredDocumentModel
    }

    Component {
        id: documentDialog
        Dialog {
            id: dialog
            property var currentItem: null
            property bool isNew: false

            modal: true
            width: Math.min(800, parent.width * 0.9)
            height: Math.min(700, parent.height * 0.9)
            title: isNew ? "Добавить документ" : "Редактировать документ"
            standardButtons: Dialog.Ok | Dialog.Cancel

            header: Rectangle {
                color: "#3498db"
                height: 40
                width: parent.width

                Label {
                    text: dialog.title
                    color: "white"
                    font.bold: true
                    font.pixelSize: 16
                    anchors.centerIn: parent
                }
            }

            ScrollView {
                width: parent.width
                height: parent.height - 50
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                GridLayout {
                    columns: 2
                    width: parent.width
                    columnSpacing: 10
                    rowSpacing: 10

                    Label { text: "Номер документа:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: docNumberField
                        text: currentItem ? currentItem.document_number : ""
                        Layout.fillWidth: true
                    }

                    Label { text: "Тип документа:"; Layout.alignment: Qt.AlignRight }
                    ComboBox {
                        id: docTypeField
                        model: docTypesModel
                        textRole: "name"
                        Layout.fillWidth: true
                        currentIndex: {
                            if (currentItem && currentItem.type_id) {
                                for (var i = 0; i < docTypesModel.count; i++) {
                                    if (docTypesModel.get(i).type_id === currentItem.type_id) {
                                        return i;
                                    }
                                }
                            }
                            return -1;
                        }
                    }

                    Label { text: "Статус документа:"; Layout.alignment: Qt.AlignRight }
                    ComboBox {
                        id: docStatusField
                        model: docStatusModel
                        textRole: "name"
                        Layout.fillWidth: true
                        currentIndex: {
                            if (currentItem && currentItem.document_status_id) {
                                for (var i = 0; i < docStatusModel.count; i++) {
                                    if (docStatusModel.get(i).status_id === currentItem.document_status_id) {
                                        return i;
                                    }
                                }
                            }
                            return 0;
                        }
                    }

                    Label { text: "Дата создания:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: createdDateField
                        text: currentItem ? Qt.formatDateTime(new Date(currentItem.created_date), "dd.MM.yyyy HH:mm") : ""
                        Layout.fillWidth: true
                        readOnly: true
                    }

                    Label { text: "Дата обновления:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: updatedDateField
                        text: currentItem ? Qt.formatDateTime(new Date(currentItem.updated_at), "dd.MM.yyyy HH:mm") : ""
                        Layout.fillWidth: true
                        readOnly: true
                    }

                    Label { text: "Склад:"; Layout.alignment: Qt.AlignRight }
                    ComboBox {
                        id: warehouseField
                        model: ListModel {
                            ListElement { text: "Основной склад"; warehouseId: 1 }
                            ListElement { text: "Склад 2"; warehouseId: 2 }
                            ListElement { text: "Склад 3"; warehouseId: 3 }
                        }
                        textRole: "text"
                        Layout.fillWidth: true
                        currentIndex: {
                            if (currentItem && currentItem.warehouse_id) {
                                for (var i = 0; i < warehouseField.model.count; i++) {
                                    if (warehouseField.model.get(i).warehouseId === currentItem.warehouse_id) {
                                        return i;
                                    }
                                }
                            }
                            return 0;
                        }
                    }

                    Label { text: "Поставщик:"; Layout.alignment: Qt.AlignRight }
                    ComboBox {
                        id: supplierField
                        model: ListModel {
                            ListElement { text: "ООО Поставщик"; supplierId: 1 }
                            ListElement { text: "ИП Ромашка"; supplierId: 2 }
                            ListElement { text: "Компания Звезда"; supplierId: 3 }
                        }
                        textRole: "text"
                        Layout.fillWidth: true
                        currentIndex: {
                            if (currentItem && currentItem.supplier_id) {
                                for (var i = 0; i < supplierField.model.count; i++) {
                                    if (supplierField.model.get(i).supplierId === currentItem.supplier_id) {
                                        return i;
                                    }
                                }
                            }
                            return -1;
                        }
                    }

                    Label { text: "Покупатель:"; Layout.alignment: Qt.AlignRight }
                    ComboBox {
                        id: customerField
                        model: ListModel {
                            ListElement { text: "ИП Покупатель"; customerId: 1 }
                            ListElement { text: "ООО Клиент"; customerId: 2 }
                            ListElement { text: "ИП Иванов"; customerId: 3 }
                        }
                        textRole: "text"
                        Layout.fillWidth: true
                        currentIndex: {
                            if (currentItem && currentItem.customer_id) {
                                for (var i = 0; i < customerField.model.count; i++) {
                                    if (customerField.model.get(i).customerId === currentItem.customer_id) {
                                        return i;
                                    }
                                }
                            }
                            return -1;
                        }
                    }

                    Label { text: "Сумма документа:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: amountField
                        text: currentItem ? currentItem.total_amount : ""
                        Layout.fillWidth: true
                        validator: DoubleValidator { bottom: 0 }
                    }

                    Label { text: "Комментарий:"; Layout.alignment: Qt.AlignRight }
                    TextArea {
                        id: commentsField
                        text: currentItem ? currentItem.comments : ""
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        height: 100
                    }
                }
            }

            onAccepted: {
                saveChanges()
            }

            function saveChanges() {
                var currentDate = new Date().toISOString()
                var typeId = docTypeField.currentIndex >= 0 ?
                    docTypesModel.get(docTypeField.currentIndex).type_id : 0
                var statusId = docStatusField.currentIndex >= 0 ?
                    docStatusModel.get(docStatusField.currentIndex).status_id : 1
                var warehouseId = warehouseField.currentIndex >= 0 ?
                    warehouseField.model.get(warehouseField.currentIndex).warehouseId : 1
                var supplierId = supplierField.currentIndex >= 0 ?
                    supplierField.model.get(supplierField.currentIndex).supplierId : 0
                var customerId = customerField.currentIndex >= 0 ?
                    customerField.model.get(customerField.currentIndex).customerId : 0

                if(isNew) {
                    var newId = 1;
                    for (var i = 0; i < sourceDocumentModel.count; i++) {
                        if (sourceDocumentModel.get(i).document_id >= newId) {
                            newId = sourceDocumentModel.get(i).document_id + 1;
                        }
                    }

                    sourceDocumentModel.append({
                        document_id: newId,
                        document_number: docNumberField.text,
                        created_date: currentDate,
                        updated_at: currentDate,
                        status: docStatusField.currentText,
                        comments: commentsField.text,
                        customer_id: customerId,
                        supplier_id: supplierId,
                        type_id: typeId,
                        document_status_id: statusId,
                        total_amount: parseFloat(amountField.text) || 0,
                        warehouse_id: warehouseId
                    })
                } else {
                    var index = sourceDocumentModel.indexOf(currentItem)
                    sourceDocumentModel.set(index, {
                        document_number: docNumberField.text,
                        updated_at: currentDate,
                        status: docStatusField.currentText,
                        comments: commentsField.text,
                        customer_id: customerId,
                        supplier_id: supplierId,
                        type_id: typeId,
                        document_status_id: statusId,
                        total_amount: parseFloat(amountField.text) || 0,
                        warehouse_id: warehouseId
                    })
                }
                filterDocuments()
            }
        }
    }

    Component {
        id: validationErrorDialog
        Dialog {
            property var errors: []
            modal: true
            title: "Ошибки ввода"
            width: 400
            standardButtons: Dialog.Ok

            ColumnLayout {
                width: parent.width
                spacing: 10

                Label {
                    text: "Исправьте следующие ошибки:"
                    font.bold: true
                }

                Repeater {
                    model: errors
                    Label {
                        text: "• " + modelData
                        color: "#e74c3c"
                    }
                }
            }
        }
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
                    text: "Документы"
                    iconSource: "qrc:/images/documents.png"
                    onClicked: root.goToDocuments()
                }

                HeaderButton {
                    text: "Типы документов"
                    iconSource: "qrc:/images/doctypes.png"
                }

                Label { text: "Тип:"; color: "white"; Layout.leftMargin: 20 }
                ComboBox {
                    id: typeFilter
                    model: docTypesModel
                    textRole: "name"
                    Layout.preferredWidth: 200
                    onCurrentIndexChanged: {
                        root.currentDocType = currentIndex >= 0 ?
                            docTypesModel.get(currentIndex).type_id : -1
                        filterDocuments()
                    }
                    Component.onCompleted: {
                        typeFilter.model.insert(0, {type_id: -1, name: "Все типы"})
                        currentIndex = 0
                    }
                }

                Label { text: "Статус:"; color: "white"; Layout.leftMargin: 20 }
                ComboBox {
                    id: statusFilter
                    model: ["Все", "Черновик", "Проведен", "Отменен", "Архив"]
                    Layout.preferredWidth: 150
                    onCurrentIndexChanged: {
                        root.showArchived = currentIndex === 4
                        filterDocuments()
                    }
                }

                Item { Layout.fillWidth: true }
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
                            var docId = filteredDocumentModel.get(i).document_id
                            updateSourceModelSelection(docId, checked)
                        }
                        filterDocuments()
                    }
                }

                Button {
                    text: "Добавить"
                    icon.source: "qrc:/images/add.png"
                    onClicked: {
                        documentDialog.createObject(root, {isNew: true}).open()
                    }
                }

                Button {
                    text: "Изменить"
                    icon.source: "qrc:/images/edit.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredDocumentModel.count; i++) {
                            if (filteredDocumentModel.get(i).selected) count++;
                        }
                        return count === 1;
                    }
                    onClicked: {
                        for (var i = 0; i < filteredDocumentModel.count; i++) {
                            if (filteredDocumentModel.get(i).selected) {
                                documentDialog.createObject(root, {
                                    currentItem: filteredDocumentModel.get(i),
                                    isNew: false
                                }).open()
                                break;
                            }
                        }
                    }
                }

                Button {
                    text: "Удалить"
                    icon.source: "qrc:/images/delete.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredDocumentModel.count; i++) {
                            if (filteredDocumentModel.get(i).selected) count++;
                        }
                        return count > 0;
                    }
                    onClicked: deleteSelectedDocuments()
                }

                Button {
                    text: "Провести"
                    icon.source: "qrc:/images/approve.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredDocumentModel.count; i++) {
                            if (filteredDocumentModel.get(i).selected &&
                                filteredDocumentModel.get(i).status !== "Проведен") count++;
                        }
                        return count > 0;
                    }
                    onClicked: setDocumentStatus("Проведен")
                }

                Button {
                    text: "Отменить"
                    icon.source: "qrc:/images/cancel.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredDocumentModel.count; i++) {
                            if (filteredDocumentModel.get(i).selected &&
                                filteredDocumentModel.get(i).status === "Проведен") count++;
                        }
                        return count > 0;
                    }
                    onClicked: setDocumentStatus("Отменен")
                }

                Button {
                    text: "Печать"
                    icon.source: "qrc:/images/print.png"
                    enabled: {
                        for (var i = 0; i < filteredDocumentModel.count; i++) {
                            if (filteredDocumentModel.get(i).selected) return true;
                        }
                        return false;
                    }
                    onClicked: printSelectedDocuments()
                }

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    placeholderText: "Поиск по документам..."
                    leftPadding: 30
                    onTextChanged: {
                        root.searchText = text.toLowerCase()
                        filterDocumentsTimer.restart()
                    }

                    Image {
                        source: "qrc:/images/search.png"
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        width: 20
                        height: 20
                    }
                }

                Button {
                    text: "Очистить"
                    onClicked: {
                        searchField.text = ""
                        root.searchText = ""
                        typeFilter.currentIndex = 0
                        statusFilter.currentIndex = 0
                        filterDocuments()
                    }
                }
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AsNeeded
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            clip: true

            ListView {
                id: documentsListView
                anchors.fill: parent
                model: filteredDocumentModel
                clip: true

                property real totalWidth: 50 + 120 + 150 + 200 + 150 + 120 + 120 + 120 + 120
                width: Math.max(parent.width, totalWidth)

                header: Rectangle {
                    width: documentsListView.totalWidth
                    height: 40
                    color: "#3498db"
                    z: 2

                    Row {
                        anchors.fill: parent
                        spacing: 1

                        HeaderCell { width: 50; text: "" }
                        HeaderCell { width: 120; text: "Номер" }
                        HeaderCell { width: 150; text: "Дата" }
                        HeaderCell { width: 200; text: "Тип" }
                        HeaderCell { width: 150; text: "Контрагент" }
                        HeaderCell { width: 120; text: "Сумма" }
                        HeaderCell { width: 120; text: "Статус" }
                        HeaderCell { width: 120; text: "Создан" }
                        HeaderCell { width: 120; text: "Обновлен" }
                    }
                }

                delegate: Rectangle {
                    width: documentsListView.totalWidth
                    height: 40
                    color: index % 2 === 0 ? "#FFFFFF" : "#F2F4F4"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var selected = !model.selected
                            filteredDocumentModel.setProperty(index, "selected", selected)
                            updateSourceModelSelection(model.document_id, selected)
                        }
                    }

                    Row {
                        anchors.fill: parent
                        spacing: 1

                        Rectangle {
                            width: 50
                            height: parent.height
                            color: "transparent"

                            CheckBox {
                                anchors.centerIn: parent
                                checked: model.selected
                                onCheckedChanged: {
                                    filteredDocumentModel.setProperty(index, "selected", checked)
                                    updateSourceModelSelection(model.document_id, checked)
                                }
                            }
                        }

                        TextCell {
                            width: 120;
                            text: model.document_number
                            font.bold: true
                        }
                        TextCell {
                            width: 150;
                            text: Qt.formatDateTime(new Date(model.created_date), "dd.MM.yyyy")
                        }
                        TextCell {
                            width: 200;
                            text: getTypeName(model.type_id)
                        }
                        TextCell {
                            width: 150;
                            text: getCounterparty(model.supplier_id, model.customer_id)
                        }
                        TextCell {
                            width: 120;
                            text: formatCurrency(model.total_amount)
                            horizontalAlignment: Text.AlignRight
                        }
                        TextCell {
                            width: 120;
                            text: model.status
                            cellColor: model.status === "Проведен" ? "green" :
                                      model.status === "Черновик" ? "orange" :
                                      model.status === "Отменен" ? "red" : "gray"
                        }
                        TextCell {
                            width: 120;
                            text: Qt.formatDateTime(new Date(model.created_date), "dd.MM.yyyy HH:mm")
                        }
                        TextCell {
                            width: 120;
                            text: Qt.formatDateTime(new Date(model.updated_at), "dd.MM.yyyy HH:mm")
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 30
            color: "#2C3E50"

            Label {
                anchors.fill: parent
                anchors.leftMargin: 10
                color: "white"
                text: `Показано: ${filteredDocumentModel.count} из ${sourceDocumentModel.count} документов`
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Timer {
        id: filterDocumentsTimer
        interval: 300
        onTriggered: filterDocuments()
    }

    Component.onCompleted: filterDocuments()

    function filterDocuments() {
        filteredDocumentModel.clear()

        for (var i = 0; i < sourceDocumentModel.count; i++) {
            var item = sourceDocumentModel.get(i)

            if (root.currentDocType !== -1 && item.type_id !== root.currentDocType) continue

            if (statusFilter.currentIndex > 0) {
                var statusText = statusFilter.model[statusFilter.currentIndex]
                if (item.status !== statusText) continue
            }

            var match = root.searchText.length === 0

            if (!match) {
                var props = ["document_number", "comments", "status"]
                for (var j = 0; j < props.length; j++) {
                    var prop = props[j]
                    var value = item[prop] ? item[prop].toString().toLowerCase() : ""
                    if (value.includes(root.searchText)) {
                        match = true
                        break
                    }
                }

                if (!match) {
                    var numValue = item.total_amount.toString()
                    if (numValue.includes(root.searchText)) {
                        match = true
                    }
                }

                if (!match) {
                    var createdDate = Qt.formatDateTime(new Date(item.created_date), "dd.MM.yyyy HH:mm")
                    var updatedDate = Qt.formatDateTime(new Date(item.updated_at), "dd.MM.yyyy HH:mm")
                    if (createdDate.includes(root.searchText) || updatedDate.includes(root.searchText)) {
                        match = true
                    }
                }

                if (!match) {
                    var counterparty = getCounterparty(item.supplier_id, item.customer_id).toLowerCase()
                    if (counterparty.includes(root.searchText)) {
                        match = true
                    }
                }

                if (!match) {
                    var typeName = getTypeName(item.type_id).toLowerCase()
                    if (typeName.includes(root.searchText)) {
                        match = true
                    }
                }
            }

            if (match) {
                filteredDocumentModel.append({
                    document_id: item.document_id,
                    document_number: item.document_number,
                    created_date: item.created_date,
                    updated_at: item.updated_at,
                    status: item.status,
                    comments: item.comments,
                    customer_id: item.customer_id,
                    supplier_id: item.supplier_id,
                    type_id: item.type_id,
                    document_status_id: item.document_status_id,
                    total_amount: item.total_amount,
                    warehouse_id: item.warehouse_id,
                    selected: item.selected || false
                })
            }
        }

        var allSelected = true;
        for (var idx = 0; idx < filteredDocumentModel.count; idx++) {
            if (!filteredDocumentModel.get(idx).selected) {
                allSelected = false;
                break;
            }
        }
        selectAllCheckBox.checked = allSelected;
    }

    function updateSourceModelSelection(id, selected) {
        for (var i = 0; i < sourceDocumentModel.count; i++) {
            if (sourceDocumentModel.get(i).document_id === id) {
                sourceDocumentModel.setProperty(i, "selected", selected)
                break
            }
        }
    }

    function getTypeName(typeId) {
        for (var i = 0; i < docTypesModel.count; i++) {
            if (docTypesModel.get(i).type_id === typeId) {
                return docTypesModel.get(i).name;
            }
        }
        return "Неизвестный тип";
    }

    function getCounterparty(supplierId, customerId) {
        if (supplierId > 0) return "Поставщик #" + supplierId;
        if (customerId > 0) return "Покупатель #" + customerId;
        return "Внутренний";
    }

    function formatCurrency(amount) {
        return amount > 0 ? Number(amount).toLocaleString(Qt.locale("ru_RU"), "f", 2) + " ₽" : "-";
    }

    function deleteSelectedDocuments() {
        var deleteDialog = Qt.createQmlObject(`
            import QtQuick 2.15
            import QtQuick.Controls 2.15

            Dialog {
                title: "Подтверждение удаления"
                modal: true
                width: 400
                standardButtons: Dialog.Yes | Dialog.No

                Label {
                    text: "Вы действительно хотите удалить выбранные документы?"
                    wrapMode: Text.Wrap
                    width: parent.width
                }

                onAccepted: {
                    root.confirmDeleteSelected()
                    close()
                }
            }
        `, root, "deleteDialog")

        deleteDialog.open()
    }

    function setDocumentStatus(status) {
        for (var i = 0; i < filteredDocumentModel.count; i++) {
            if (filteredDocumentModel.get(i).selected) {
                var id = filteredDocumentModel.get(i).document_id

                for (var j = 0; j < sourceDocumentModel.count; j++) {
                    if (sourceDocumentModel.get(j).document_id === id) {
                        sourceDocumentModel.set(j, {
                            status: status,
                            updated_at: new Date().toISOString()
                        })
                        break
                    }
                }
            }
        }
        filterDocuments()
    }

    function printSelectedDocuments() {
        var docNumbers = []
        for (var i = 0; i < filteredDocumentModel.count; i++) {
            if (filteredDocumentModel.get(i).selected) {
                docNumbers.push(filteredDocumentModel.get(i).document_number)
            }
        }
    }

    function confirmDeleteSelected() {
        for (var i = filteredDocumentModel.count - 1; i >= 0; i--) {
            if (filteredDocumentModel.get(i).selected) {
                var id = filteredDocumentModel.get(i).document_id
                filteredDocumentModel.remove(i)

                for (var j = 0; j < sourceDocumentModel.count; j++) {
                    if (sourceDocumentModel.get(j).document_id === id) {
                        sourceDocumentModel.remove(j)
                        break
                    }
                }
            }
        }
        filterDocuments()
    }

    component TextCell: Label {
        property color cellColor: "black"
        width: parent.width
        height: parent.height
        color: cellColor
        padding: 10
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    component HeaderCell: Rectangle {
        property alias text: label.text
        width: parent.width
        height: parent.height
        color: "transparent"

        Label {
            id: label
            anchors.fill: parent
            padding: 10
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            color: "white"
            font.bold: true
            elide: Text.ElideRight
        }
    }
}
