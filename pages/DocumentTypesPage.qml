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
    signal goToDocumentTypes()


 onGoToNotifications: notificationPopup.open()
    onGoToHelp: helpPopup.open()


    NotificationPopup {
      id: notificationPopup
    }

    HelpPopup {
      id: helpPopup
    }
    property string searchText: ""

    background: Rectangle {
        color: "#ECF0F1"
    }

    ListModel {
        id: documentTypesModel
        
        function loadSampleData() {
            append({type_id: 1, name: "Поступление", prefix: "П", direction: "in", requires_approval: true})
            append({type_id: 2, name: "Реализация", prefix: "Р", direction: "out", requires_approval: true})
            append({type_id: 3, name: "Возврат", prefix: "В", direction: "in", requires_approval: false})
            append({type_id: 4, name: "Перемещение", prefix: "М", direction: "internal", requires_approval: false})
            append({type_id: 5, name: "Списание", prefix: "С", direction: "out", requires_approval: true})
            filterDocumentTypes()
        }
        Component.onCompleted: loadSampleData()
    }

    ListModel {
        id: filteredDocumentTypesModel
    }

    Component {
        id: documentTypeDialog
        Dialog {
            id: dialog
            property var currentItem: null
            property bool isNew: false

            modal: true
            width: Math.min(500, parent.width * 0.9)
            height: Math.min(400, parent.height * 0.9)
            title: isNew ? "Добавить тип документа" : "Редактировать тип документа"
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
                }

                Label { text: "Префикс:"; Layout.alignment: Qt.AlignRight }
                TextField {
                    id: prefixField
                    text: currentItem ? currentItem.prefix : ""
                    Layout.fillWidth: true
                }

                Label { text: "Направление:"; Layout.alignment: Qt.AlignRight }
                ComboBox {
                    id: directionField
                    model: ["in", "out", "internal"]
                    currentIndex: model.indexOf(currentItem ? currentItem.direction : "in")
                    Layout.fillWidth: true
                }

                Label { text: "Требует согласования:"; Layout.alignment: Qt.AlignRight }
                CheckBox {
                    id: approvalField
                    checked: currentItem ? currentItem.requires_approval : false
                }
            }

            onAccepted: {
                saveChanges()
            }

            function saveChanges() {
                if(isNew) {
                    var newId = 1;
                    for (var i = 0; i < documentTypesModel.count; i++) {
                        if (documentTypesModel.get(i).type_id >= newId) {
                            newId = documentTypesModel.get(i).type_id + 1;
                        }
                    }

                    documentTypesModel.append({
                        type_id: newId,
                        name: nameField.text,
                        prefix: prefixField.text,
                        direction: directionField.currentText,
                        requires_approval: approvalField.checked
                    })
                } else {
                    var index = documentTypesModel.indexOf(currentItem)
                    documentTypesModel.set(index, {
                        name: nameField.text,
                        prefix: prefixField.text,
                        direction: directionField.currentText,
                        requires_approval: approvalField.checked
                    })
                }
                filterDocumentTypes()
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
                    case "Типы документов": root.goToDocumentTypes(); break;
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
                    onClicked: root.goToDocumentTypes()
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
                        for (var i = 0; i < filteredDocumentTypesModel.count; i++) {
                            var typeId = filteredDocumentTypesModel.get(i).type_id
                            updateSourceModelSelection(typeId, checked)
                        }
                        filterDocumentTypes()
                    }
                }

                Button {
                    text: "Добавить"
                    icon.source: "qrc:/images/add.png"
                    onClicked: {
                        documentTypeDialog.createObject(root, {isNew: true}).open()
                    }
                }

                Button {
                    text: "Изменить"
                    icon.source: "qrc:/images/edit.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredDocumentTypesModel.count; i++) {
                            if (filteredDocumentTypesModel.get(i).selected) count++;
                        }
                        return count === 1;
                    }
                    onClicked: {
                        for (var i = 0; i < filteredDocumentTypesModel.count; i++) {
                            if (filteredDocumentTypesModel.get(i).selected) {
                                documentTypeDialog.createObject(root, {
                                    currentItem: filteredDocumentTypesModel.get(i),
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
                        for (var i = 0; i < filteredDocumentTypesModel.count; i++) {
                            if (filteredDocumentTypesModel.get(i).selected) count++;
                        }
                        return count > 0;
                    }
                    onClicked: deleteSelectedDocumentTypes()
                }

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    placeholderText: "Поиск по типам документов..."
                    leftPadding: 30
                    onTextChanged: {
                        root.searchText = text.toLowerCase()
                        filterDocumentTypesTimer.restart()
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
                        filterDocumentTypes()
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
                id: documentTypesListView
                anchors.fill: parent
                model: filteredDocumentTypesModel
                clip: true

                property real totalWidth: 50 + 200 + 100 + 150 + 150
                width: Math.max(parent.width, totalWidth)

                header: Rectangle {
                    width: documentTypesListView.totalWidth
                    height: 40
                    color: "#3498db"
                    z: 2

                    Row {
                        anchors.fill: parent
                        spacing: 1

                        HeaderCell { width: 50; text: "" }
                        HeaderCell { width: 200; text: "Название" }
                        HeaderCell { width: 100; text: "Префикс" }
                        HeaderCell { width: 150; text: "Направление" }
                        HeaderCell { width: 150; text: "Согласование" }
                    }
                }

                delegate: Rectangle {
                    width: documentTypesListView.totalWidth
                    height: 40
                    color: index % 2 === 0 ? "#FFFFFF" : "#F2F4F4"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var selected = !model.selected
                            filteredDocumentTypesModel.setProperty(index, "selected", selected)
                            updateSourceModelSelection(model.type_id, selected)
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
                                    filteredDocumentTypesModel.setProperty(index, "selected", checked)
                                    updateSourceModelSelection(model.type_id, checked)
                                }
                            }
                        }

                        TextCell { width: 200; text: model.name }
                        TextCell { width: 100; text: model.prefix }
                        TextCell { width: 150; text: model.direction }
                        TextCell { 
                            width: 150; 
                            text: model.requires_approval ? "Требуется" : "Не требуется"
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
                text: `Показано: ${filteredDocumentTypesModel.count} из ${documentTypesModel.count} типов`
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Timer {
        id: filterDocumentTypesTimer
        interval: 300
        onTriggered: filterDocumentTypes()
    }

    Component.onCompleted: filterDocumentTypes()

    function filterDocumentTypes() {
        filteredDocumentTypesModel.clear()

        for (var i = 0; i < documentTypesModel.count; i++) {
            var item = documentTypesModel.get(i)
            var match = root.searchText.length === 0

            if (!match) {
                var props = ["name", "prefix", "direction"]
                for (var j = 0; j < props.length; j++) {
                    var prop = props[j]
                    var value = item[prop] ? item[prop].toString().toLowerCase() : ""
                    if (value.includes(root.searchText)) {
                        match = true
                        break
                    }
                }
            }

            if (match) {
                filteredDocumentTypesModel.append({
                    type_id: item.type_id,
                    name: item.name,
                    prefix: item.prefix,
                    direction: item.direction,
                    requires_approval: item.requires_approval,
                    selected: item.selected || false
                })
            }
        }

        var allSelected = true;
        for (var idx = 0; idx < filteredDocumentTypesModel.count; idx++) {
            if (!filteredDocumentTypesModel.get(idx).selected) {
                allSelected = false;
                break;
            }
        }
        selectAllCheckBox.checked = allSelected;
    }

    function updateSourceModelSelection(id, selected) {
        for (var i = 0; i < documentTypesModel.count; i++) {
            if (documentTypesModel.get(i).type_id === id) {
                documentTypesModel.setProperty(i, "selected", selected)
                break
            }
        }
    }

    function deleteSelectedDocumentTypes() {
        var deleteDialog = Qt.createQmlObject(`
            import QtQuick 2.15
            import QtQuick.Controls 2.15

            Dialog {
                title: "Подтверждение удаления"
                modal: true
                width: 400
                standardButtons: Dialog.Yes | Dialog.No

                Label {
                    text: "Вы действительно хотите удалить выбранные типы документов?"
                    wrapMode: Text.Wrap
                    width: parent.width
                }

                onAccepted: {
                    root.confirmDeleteSelectedDocumentTypes()
                    close()
                }
            }
        `, root, "deleteDialog")

        deleteDialog.open()
    }

    function confirmDeleteSelectedDocumentTypes() {
        for (var i = filteredDocumentTypesModel.count - 1; i >= 0; i--) {
            if (filteredDocumentTypesModel.get(i).selected) {
                var id = filteredDocumentTypesModel.get(i).type_id
                filteredDocumentTypesModel.remove(i)

                for (var j = 0; j < documentTypesModel.count; j++) {
                    if (documentTypesModel.get(j).type_id === id) {
                        documentTypesModel.remove(j)
                        break
                    }
                }
            }
        }
        filterDocumentTypes()
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