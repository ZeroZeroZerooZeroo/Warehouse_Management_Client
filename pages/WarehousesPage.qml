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
    signal openWarehouse(int warehouseId)

    property int currentWarehouse: -1
    property string searchText: ""


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

    ListModel {
        id: warehousesModel
        Component.onCompleted: loadSampleData()

        function loadSampleData() {
            append({
                warehouse_id: 1,
                name: "Основной склад",
                address: "Москва, ул. Складская, 1",
                total_capacity: 5000,
                current_utilization: 3500,
                status: true,
                created_at: "2023-01-01T08:00:00",
                update_at: "2023-06-01T12:30:00"
            })
            append({
                warehouse_id: 2,
                name: "Склад №2",
                address: "Москва, пр. Ленина, 45",
                total_capacity: 3000,
                current_utilization: 1500,
                status: true,
                created_at: "2023-02-15T09:15:00",
                update_at: "2023-05-20T14:20:00"
            })
            append({
                warehouse_id: 3,
                name: "Запасной склад",
                address: "Москва, ул. Заводская, 12",
                total_capacity: 2000,
                current_utilization: 2000,
                status: false,
                created_at: "2023-03-10T11:30:00",
                update_at: "2023-04-01T10:45:00"
            })
            append({
                warehouse_id: 4,
                name: "Холодильный склад",
                address: "Москва, ул. Морозная, 7",
                total_capacity: 1000,
                current_utilization: 800,
                status: true,
                created_at: "2023-01-20T13:20:00",
                update_at: "2023-06-10T16:15:00"
            })
            filterWarehouses()
        }
    }

    ListModel {
        id: filteredWarehousesModel
    }

    Component {
        id: warehouseDialog
        Dialog {
            id: dialog
            property var currentItem: null
            property bool isNew: false

            modal: true
            width: Math.min(600, parent.width * 0.9)
            height: Math.min(500, parent.height * 0.9)
            title: isNew ? "Добавить склад" : "Редактировать склад"
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

                    Label { text: "Название:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: nameField
                        text: currentItem ? currentItem.name : ""
                        Layout.fillWidth: true
                        placeholderText: "Название склада"
                    }

                    Label { text: "Адрес:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: addressField
                        text: currentItem ? currentItem.address : ""
                        Layout.fillWidth: true
                        placeholderText: "Адрес склада"
                    }

                    Label { text: "Общая емкость:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: capacityField
                        text: currentItem ? currentItem.total_capacity : ""
                        Layout.fillWidth: true
                        validator: IntValidator { bottom: 1 }
                        placeholderText: "Общая емкость"
                    }

                    Label { text: "Текущая загрузка:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: utilizationField
                        text: currentItem ? currentItem.current_utilization : ""
                        Layout.fillWidth: true
                        validator: IntValidator { bottom: 0 }
                        placeholderText: "Текущая загрузка"
                    }

                    Label { text: "Статус:"; Layout.alignment: Qt.AlignRight }
                    CheckBox {
                        id: statusField
                        text: "Активен"
                        checked: currentItem ? currentItem.status : true
                    }

                    Label { text: "Дата создания:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: createdField
                        text: currentItem ? Qt.formatDateTime(new Date(currentItem.created_at), "dd.MM.yyyy HH:mm") : ""
                        Layout.fillWidth: true
                        readOnly: true
                    }

                    Label { text: "Дата обновления:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: updatedField
                        text: currentItem ? Qt.formatDateTime(new Date(currentItem.update_at), "dd.MM.yyyy HH:mm") : ""
                        Layout.fillWidth: true
                        readOnly: true
                    }
                }
            }

            onAccepted: {
                if (validateForm()) {
                    saveChanges()
                } else {
                    open()
                }
            }

            function validateForm() {
                var errors = []

                if (nameField.text.trim() === "") {
                    errors.push("Название склада не может быть пустым")
                    nameField.focus = true
                }

                if (addressField.text.trim() === "") {
                    errors.push("Адрес склада не может быть пустым")
                    addressField.focus = true
                }

                if (capacityField.text.trim() === "" || parseInt(capacityField.text) <= 0) {
                    errors.push("Общая емкость должна быть положительным числом")
                    capacityField.focus = true
                }

                if (utilizationField.text.trim() === "" || parseInt(utilizationField.text) < 0) {
                    errors.push("Текущая загрузка должна быть неотрицательным числом")
                    utilizationField.focus = true
                }

                if (parseInt(utilizationField.text) > parseInt(capacityField.text)) {
                    errors.push("Текущая загрузка не может превышать общую емкость")
                    utilizationField.focus = true
                }

                if (errors.length > 0) {
                    validationErrorDialog.createObject(root, {errors: errors}).open()
                    return false
                }
                return true
            }

            function saveChanges() {
                var currentDate = new Date().toISOString()

                if(isNew) {

                    var newId = 1;
                    for (var i = 0; i < warehousesModel.count; i++) {
                        if (warehousesModel.get(i).warehouse_id >= newId) {
                            newId = warehousesModel.get(i).warehouse_id + 1;
                        }
                    }

                    warehousesModel.append({
                        warehouse_id: newId,
                        name: nameField.text,
                        address: addressField.text,
                        total_capacity: parseInt(capacityField.text),
                        current_utilization: parseInt(utilizationField.text),
                        status: statusField.checked,
                        created_at: currentDate,
                        update_at: currentDate
                    })
                } else {
                    var index = warehousesModel.indexOf(currentItem)
                    warehousesModel.set(index, {
                        name: nameField.text,
                        address: addressField.text,
                        total_capacity: parseInt(capacityField.text),
                        current_utilization: parseInt(utilizationField.text),
                        status: statusField.checked,
                        update_at: currentDate
                    })
                }
                filterWarehouses()
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
                        for (var i = 0; i < filteredWarehousesModel.count; i++) {
                            var warehouseId = filteredWarehousesModel.get(i).warehouse_id
                            updateSourceModelSelection(warehouseId, checked)
                        }
                        filterWarehouses()
                    }
                }

                Button {
                    text: "Добавить"
                    icon.source: "qrc:/images/add.png"
                    onClicked: {
                        warehouseDialog.createObject(root, {isNew: true}).open()
                    }
                }

                Button {
                    text: "Изменить"
                    icon.source: "qrc:/images/edit.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredWarehousesModel.count; i++) {
                            if (filteredWarehousesModel.get(i).selected) count++;
                        }
                        return count === 1;
                    }
                    onClicked: {
                        for (var i = 0; i < filteredWarehousesModel.count; i++) {
                            if (filteredWarehousesModel.get(i).selected) {
                                warehouseDialog.createObject(root, {
                                    currentItem: filteredWarehousesModel.get(i),
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
                        for (var i = 0; i < filteredWarehousesModel.count; i++) {
                            if (filteredWarehousesModel.get(i).selected) count++;
                        }
                        return count > 0;
                    }
                    onClicked: deleteSelectedWarehouses()
                }

                Button {
                    text: "Открыть"
                    icon.source: "qrc:/images/open.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredWarehousesModel.count; i++) {
                            if (filteredWarehousesModel.get(i).selected) count++;
                        }
                        return count === 1;
                    }
                    onClicked: {
                        for (var i = 0; i < filteredWarehousesModel.count; i++) {
                            if (filteredWarehousesModel.get(i).selected) {
                                root.openWarehouse(filteredWarehousesModel.get(i).warehouse_id)
                                break;
                            }
                        }
                    }
                }

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    placeholderText: "Поиск по складам..."
                    leftPadding: 30
                    onTextChanged: {
                        root.searchText = text.toLowerCase()
                        filterWarehousesTimer.restart()
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
                        filterWarehouses()
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
                id: warehousesListView
                anchors.fill: parent
                model: filteredWarehousesModel
                clip: true


                property real totalWidth: 50 + 250 + 400 + 200 + 200 + 150 + 150
                width: Math.max(parent.width, totalWidth)

                header: Rectangle {
                    width: warehousesListView.totalWidth
                    height: 40
                    color: "#3498db"
                    z: 2

                    Row {
                        anchors.fill: parent
                        spacing: 1

                        HeaderCell { width: 50; text: "" }
                        HeaderCell { width: 250; text: "Название" }
                        HeaderCell { width: 400; text: "Адрес" }
                        HeaderCell { width: 200; text: "Загрузка" }
                        HeaderCell { width: 200; text: "Статус" }
                        HeaderCell { width: 150; text: "Создан" }
                        HeaderCell { width: 150; text: "Обновлен" }
                    }
                }

                delegate: Rectangle {
                    width: warehousesListView.totalWidth
                    height: 60
                    color: index % 2 === 0 ? "#FFFFFF" : "#F2F4F4"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var selected = !model.selected
                            filteredWarehousesModel.setProperty(index, "selected", selected)
                            updateSourceModelSelection(model.warehouse_id, selected)
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
                                    filteredWarehousesModel.setProperty(index, "selected", checked)
                                    updateSourceModelSelection(model.warehouse_id, checked)
                                }
                            }
                        }


                        TextCell {
                            width: 250;
                            text: model.name
                            font.bold: true
                        }
                        TextCell {
                            width: 400;
                            text: model.address
                            elide: Text.ElideRight
                        }
                        Rectangle {
                            width: 200
                            height: parent.height
                            color: "transparent"

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 5
                                spacing: 2

                                ProgressBar {
                                    Layout.fillWidth: true
                                    value: model.current_utilization / model.total_capacity
                                    background: Rectangle {
                                        color: "#e0e0e0"
                                        radius: 3
                                    }
                                    contentItem: Item {
                                        Rectangle {
                                            width: parent.width * parent.parent.value
                                            height: parent.height
                                            radius: 3
                                            color: value > 0.9 ? "#e74c3c" :
                                                   value > 0.7 ? "#f39c12" : "#2ecc71"
                                        }
                                    }
                                }

                                Label {
                                    text: `${model.current_utilization} / ${model.total_capacity} (${Math.round((model.current_utilization / model.total_capacity) * 100)}%)`
                                    font.pixelSize: 12
                                }
                            }
                        }
                        TextCell {
                            width: 200;
                            text: model.status ? "Активен" : "Неактивен"
                            cellColor: model.status ? "green" : "red"
                            font.bold: true
                        }
                        TextCell {
                            width: 150;
                            text: Qt.formatDateTime(new Date(model.created_at), "dd.MM.yyyy")
                        }
                        TextCell {
                            width: 150;
                            text: Qt.formatDateTime(new Date(model.update_at), "dd.MM.yyyy")
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
                text: `Показано: ${filteredWarehousesModel.count} из ${warehousesModel.count} складов`
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Timer {
        id: filterWarehousesTimer
        interval: 300
        onTriggered: filterWarehouses()
    }

    Component.onCompleted: filterWarehouses()

    function filterWarehouses() {
        filteredWarehousesModel.clear()

        for (var i = 0; i < warehousesModel.count; i++) {
            var item = warehousesModel.get(i)
            var match = root.searchText.length === 0

            if (!match) {

                var props = ["name", "address"]
                for (var j = 0; j < props.length; j++) {
                    var prop = props[j]
                    var value = item[prop] ? item[prop].toString().toLowerCase() : ""
                    if (value.includes(root.searchText)) {
                        match = true
                        break
                    }
                }


                if (!match) {
                    var numProps = ["total_capacity", "current_utilization"]
                    for (var k = 0; k < numProps.length; k++) {
                        var numProp = numProps[k]
                        var numValue = item[numProp].toString()
                        if (numValue.includes(root.searchText)) {
                            match = true
                            break
                        }
                    }
                }


                if (!match) {
                    var statusText = item.status ? "активен" : "неактивен"
                    if (statusText.includes(root.searchText)) {
                        match = true
                    }
                }


                if (!match) {
                    var createdDate = Qt.formatDateTime(new Date(item.created_at), "dd.MM.yyyy")
                    var updatedDate = Qt.formatDateTime(new Date(item.update_at), "dd.MM.yyyy")
                    if (createdDate.includes(root.searchText) || updatedDate.includes(root.searchText)) {
                        match = true
                    }
                }
            }

            if (match) {
                filteredWarehousesModel.append({
                    warehouse_id: item.warehouse_id,
                    name: item.name,
                    address: item.address,
                    total_capacity: item.total_capacity,
                    current_utilization: item.current_utilization,
                    status: item.status,
                    created_at: item.created_at,
                    update_at: item.update_at,
                    selected: item.selected || false
                })
            }
        }


        var allSelected = true;
        for (var idx = 0; idx < filteredWarehousesModel.count; idx++) {
            if (!filteredWarehousesModel.get(idx).selected) {
                allSelected = false;
                break;
            }
        }
        selectAllCheckBox.checked = allSelected;
    }

    function updateSourceModelSelection(id, selected) {
        for (var i = 0; i < warehousesModel.count; i++) {
            if (warehousesModel.get(i).warehouse_id === id) {
                warehousesModel.setProperty(i, "selected", selected)
                break
            }
        }
    }

    function deleteSelectedWarehouses() {
        var deleteDialog = Qt.createQmlObject(`
            import QtQuick 2.15
            import QtQuick.Controls 2.15

            Dialog {
                title: "Подтверждение удаления"
                modal: true
                width: 400
                standardButtons: Dialog.Yes | Dialog.No

                Label {
                    text: "Вы действительно хотите удалить выбранные склады?"
                    wrapMode: Text.Wrap
                    width: parent.width
                }

                onAccepted: {
                    root.confirmDeleteSelectedWarehouses()
                    close()
                }
            }
        `, root, "deleteDialog")

        deleteDialog.open()
    }

    function confirmDeleteSelectedWarehouses() {
        for (var i = filteredWarehousesModel.count - 1; i >= 0; i--) {
            if (filteredWarehousesModel.get(i).selected) {
                var id = filteredWarehousesModel.get(i).warehouse_id
                filteredWarehousesModel.remove(i)


                for (var j = 0; j < warehousesModel.count; j++) {
                    if (warehousesModel.get(j).warehouse_id === id) {
                        warehousesModel.remove(j)
                        break
                    }
                }
            }
        }
        filterWarehouses()
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
