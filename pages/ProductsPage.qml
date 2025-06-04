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

    property bool showInactive: false // Флаг показа неактивных товаров
    property int currentCategory: -1 // ID текущей категории

    background: Rectangle {
        color: "#ECF0F1"
    }

    // Модель категорий
    ListModel {
        id: categoriesModel
        Component.onCompleted: loadSampleData()

        function loadSampleData() {
            append({category_id: 1, name: "Компьютеры"})
            append({category_id: 2, name: "Мониторы"})
            append({category_id: 3, name: "Периферия"})
            append({category_id: 4, name: "Комплектующие"})
        }
    }

    // Модель товаров
    ListModel {
        id: productsModel
        Component.onCompleted: loadSampleData()

        function loadSampleData() {
            append({product_id: 1, sku: "PRD001", name: "Ноутбук HP EliteBook", description: "15.6\", Core i7, 16GB RAM",
                    unit: "шт", barcode: "123456789012", min_stock: 5, max_stock: 50, delivery_time: 3,
                    purchase_price: 50000, selling_price: 65000, is_active: true, category_id: 1,
                    created_at: "2023-01-15", updated_at: "2023-06-20"})

            append({product_id: 2, sku: "PRD002", name: "Монитор Dell 24\"", description: "Full HD, IPS, 1920x1080",
                    unit: "шт", barcode: "234567890123", min_stock: 10, max_stock: 100, delivery_time: 2,
                    purchase_price: 15000, selling_price: 20000, is_active: true, category_id: 2,
                    created_at: "2023-02-10", updated_at: "2023-05-15"})

            append({product_id: 3, sku: "PRD003", name: "Клавиатура Logitech", description: "Проводная, USB",
                    unit: "шт", barcode: "345678901234", min_stock: 20, max_stock: 200, delivery_time: 1,
                    purchase_price: 800, selling_price: 1500, is_active: true, category_id: 3,
                    created_at: "2023-03-05", updated_at: "2023-04-12"})

            append({product_id: 4, sku: "PRD004", name: "Мышь беспроводная", description: "Bluetooth, 2400 dpi",
                    unit: "шт", barcode: "456789012345", min_stock: 15, max_stock: 150, delivery_time: 1,
                    purchase_price: 600, selling_price: 1200, is_active: false, category_id: 3,
                    created_at: "2023-01-20", updated_at: "2023-03-18"})

            append({product_id: 5, sku: "PRD005", name: "Веб-камера HD", description: "1080p, автофокус",
                    unit: "шт", barcode: "567890123456", min_stock: 8, max_stock: 80, delivery_time: 2,
                    purchase_price: 2000, selling_price: 3500, is_active: true, category_id: 3,
                    created_at: "2023-04-18", updated_at: "2023-07-01"})

            filterProducts()
        }
    }

    // Фильтрованная модель
    ListModel {
        id: filteredProducts
    }

    // Диалог редактирования товара
    Component {
        id: productDialog
        Dialog {
            id: dialog
            property var currentItem: null
            property bool isNew: false

            modal: true
            width: Math.min(600, parent.width * 0.9)
            height: Math.min(700, parent.height * 0.9)
            title: isNew ? "Добавить товар" : "Редактировать товар"
            standardButtons: Dialog.Ok | Dialog.Cancel

            // Заголовок диалога
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

                    // Основная информация
                    Label {
                        text: "Основная информация"
                        font.bold: true
                        Layout.columnSpan: 2
                        Layout.topMargin: 10
                    }

                    Label { text: "Артикул:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: skuField
                        text: currentItem ? currentItem.sku : ""
                        Layout.fillWidth: true
                        placeholderText: "Уникальный артикул"
                    }

                    Label { text: "Наименование:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: nameField
                        text: currentItem ? currentItem.name : ""
                        Layout.fillWidth: true
                        placeholderText: "Наименование товара"
                    }

                    Label { text: "Описание:"; Layout.alignment: Qt.AlignRight }
                    TextArea {
                        id: descriptionField
                        text: currentItem ? currentItem.description : ""
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        height: 80
                        placeholderText: "Описание товара"
                    }

                    Label { text: "Категория:"; Layout.alignment: Qt.AlignRight }
                    ComboBox {
                        id: categoryField
                        model: categoriesModel
                        textRole: "name"
                        Layout.fillWidth: true
                        currentIndex: {
                            if (currentItem && currentItem.category_id) {
                                for (var i = 0; i < categoriesModel.count; i++) {
                                    if (categoriesModel.get(i).category_id === currentItem.category_id) {
                                        return i;
                                    }
                                }
                            }
                            return -1;
                        }
                    }

                    // Единицы измерения и штрих-код
                    Label { text: "Единица измерения:"; Layout.alignment: Qt.AlignRight }
                    ComboBox {
                        id: unitField
                        model: ["шт", "кг", "м", "л", "упак"]
                        currentIndex: model.indexOf(currentItem ? currentItem.unit : "шт")
                        Layout.fillWidth: true
                    }

                    Label { text: "Штрих-код:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: barcodeField
                        text: currentItem ? currentItem.barcode : ""
                        Layout.fillWidth: true
                        placeholderText: "Штрих-код"
                    }

                    // Уровни запасов
                    Label {
                        text: "Управление запасами"
                        font.bold: true
                        Layout.columnSpan: 2
                        Layout.topMargin: 10
                    }

                    Label { text: "Мин. запас:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: minStockField
                        text: currentItem ? currentItem.min_stock : ""
                        validator: IntValidator { bottom: 0 }
                        Layout.fillWidth: true
                        placeholderText: "Минимальный запас"
                    }

                    Label { text: "Макс. запас:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: maxStockField
                        text: currentItem ? currentItem.max_stock : ""
                        validator: IntValidator { bottom: 0 }
                        Layout.fillWidth: true
                        placeholderText: "Максимальный запас"
                    }

                    Label { text: "Срок поставки (дни):"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: deliveryTimeField
                        text: currentItem ? currentItem.delivery_time : ""
                        validator: IntValidator { bottom: 0 }
                        Layout.fillWidth: true
                        placeholderText: "Срок поставки в днях"
                    }

                    // Цены
                    Label {
                        text: "Цены"
                        font.bold: true
                        Layout.columnSpan: 2
                        Layout.topMargin: 10
                    }

                    Label { text: "Цена закупки:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: purchasePriceField
                        text: currentItem ? currentItem.purchase_price : ""
                        validator: DoubleValidator { bottom: 0 }
                        Layout.fillWidth: true
                        placeholderText: "Цена закупки"
                    }

                    Label { text: "Цена продажи:"; Layout.alignment: Qt.AlignRight }
                    TextField {
                        id: sellingPriceField
                        text: currentItem ? currentItem.selling_price : ""
                        validator: DoubleValidator { bottom: 0 }
                        Layout.fillWidth: true
                        placeholderText: "Цена продажи"
                    }

                    // Статус
                    Label {
                        text: "Статус"
                        font.bold: true
                        Layout.columnSpan: 2
                        Layout.topMargin: 10
                    }

                    Label { text: "Статус:"; Layout.alignment: Qt.AlignRight }
                    CheckBox {
                        id: isActiveField
                        text: "Активен"
                        checked: currentItem ? currentItem.is_active : true
                    }

                    // Даты создания/обновления
                    Label {
                        text: "Системная информация"
                        font.bold: true
                        Layout.columnSpan: 2
                        Layout.topMargin: 10
                    }

                    Label {
                        text: "Дата создания:";
                        Layout.alignment: Qt.AlignRight
                        visible: !isNew
                    }
                    Label {
                        text: !isNew && currentItem ? Qt.formatDateTime(new Date(currentItem.created_at), "dd.MM.yyyy HH:mm") : "Новый товар"
                        Layout.fillWidth: true
                        visible: !isNew
                    }

                    Label {
                        text: "Дата обновления:";
                        Layout.alignment: Qt.AlignRight
                        visible: !isNew
                    }
                    Label {
                        text: !isNew && currentItem ? Qt.formatDateTime(new Date(currentItem.updated_at), "dd.MM.yyyy HH:mm") : "Еще не обновлялся"
                        Layout.fillWidth: true
                        visible: !isNew
                    }
                }
            }

            onAccepted: {
                if (validateForm()) {
                    saveChanges()
                } else {
                    open() // Оставить диалог открытым при ошибке
                }
            }

            function validateForm() {
                var errors = []

                if (skuField.text.trim() === "") {
                    errors.push("Артикул не может быть пустым")
                    skuField.focus = true
                }
                if (nameField.text.trim() === "") {
                    errors.push("Наименование не может быть пустым")
                    nameField.focus = true
                }
                if (purchasePriceField.text.trim() === "" || parseFloat(purchasePriceField.text) <= 0) {
                    errors.push("Цена закупки должна быть положительным числом")
                    purchasePriceField.focus = true
                }
                if (sellingPriceField.text.trim() === "" || parseFloat(sellingPriceField.text) <= 0) {
                    errors.push("Цена продажи должна быть положительным числом")
                    sellingPriceField.focus = true
                }
                if (minStockField.text.trim() !== "" && maxStockField.text.trim() !== "") {
                    var min = parseInt(minStockField.text)
                    var max = parseInt(maxStockField.text)
                    if (min > max) {
                        errors.push("Минимальный запас не может превышать максимальный")
                        minStockField.focus = true
                    }
                }

                if (errors.length > 0) {
                    validationErrorDialog.createObject(root, {errors: errors}).open()
                    return false
                }
                return true
            }

            function saveChanges() {
                var categoryId = categoryField.currentIndex >= 0 ?
                    categoriesModel.get(categoryField.currentIndex).category_id : 0

                var currentDate = new Date().toISOString()

                if(isNew) {
                    // Генерация нового ID
                    var newId = 1;
                    for (var i = 0; i < productsModel.count; i++) {
                        if (productsModel.get(i).product_id >= newId) {
                            newId = productsModel.get(i).product_id + 1;
                        }
                    }

                    productsModel.append({
                        product_id: newId,
                        sku: skuField.text,
                        name: nameField.text,
                        description: descriptionField.text,
                        unit: unitField.currentText,
                        barcode: barcodeField.text,
                        min_stock: parseInt(minStockField.text) || 0,
                        max_stock: parseInt(maxStockField.text) || 0,
                        delivery_time: parseInt(deliveryTimeField.text) || 0,
                        purchase_price: parseFloat(purchasePriceField.text),
                        selling_price: parseFloat(sellingPriceField.text),
                        is_active: isActiveField.checked,
                        category_id: categoryId,
                        created_at: currentDate,
                        updated_at: currentDate
                    })
                } else {
                    var index = productsModel.indexOf(currentItem)
                    productsModel.set(index, {
                        sku: skuField.text,
                        name: nameField.text,
                        description: descriptionField.text,
                        unit: unitField.currentText,
                        barcode: barcodeField.text,
                        min_stock: parseInt(minStockField.text) || 0,
                        max_stock: parseInt(maxStockField.text) || 0,
                        delivery_time: parseInt(deliveryTimeField.text) || 0,
                        purchase_price: parseFloat(purchasePriceField.text),
                        selling_price: parseFloat(sellingPriceField.text),
                        is_active: isActiveField.checked,
                        category_id: categoryId,
                        updated_at: currentDate
                    })
                }
                filterProducts()
            }
        }
    }

    // Компонент для отображения ошибок валидации
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

        // Основной заголовок
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
                }
            }
        }

        // Подзаголовок для раздела товаров
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
                    text: "Товары"
                    iconSource: "qrc:/images/products.png"
                    onClicked: root.goToProducts()
                    pageName: "Товары"
                }

                HeaderButton {
                    text: "Категории"
                    iconSource: "qrc:/images/categories.png"
                    onClicked: {
                        // Реализация перехода к категориям товаров
                        console.log("Переход к категориям товаров")
                    }
                    pageName: "Категории"
                }

                // Фильтр по категории
                Label {
                    text: "Категория:"
                    color: "white"
                    Layout.leftMargin: 20
                }

                ComboBox {
                    id: categoryFilter
                    model: categoriesModel
                    textRole: "name"
                    Layout.preferredWidth: 200
                    currentIndex: -1

                    onCurrentIndexChanged: {
                        if (currentIndex >= 0) {
                            root.currentCategory = categoriesModel.get(currentIndex).category_id
                        } else {
                            root.currentCategory = -1
                        }
                        filterProducts()
                    }

                    // Опция "Все категории"
                    Component.onCompleted: {
                        categoryFilter.model.insert(0, {category_id: -1, name: "Все категории"})
                        currentIndex = 0
                    }
                }

                // Фильтр по статусу
                Label {
                    text: "Статус:"
                    color: "white"
                    Layout.leftMargin: 20
                }

                ComboBox {
                    id: statusFilter
                    model: ["Все товары", "Только активные", "Только неактивные"]
                    Layout.preferredWidth: 150
                    currentIndex: 0

                    onCurrentIndexChanged: {
                        root.showInactive = currentIndex === 2
                        filterProducts()
                    }
                }

                Item { Layout.fillWidth: true }
            }
        }

        // Панель инструментов
        Rectangle {
            Layout.fillWidth: true
            height: 60
            color: "#D6DBDF"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                spacing: 10

                // Чекбокс "Выбрать все"
                CheckBox {
                    id: selectAllCheckBox
                    text: "Все"
                    onCheckedChanged: {
                        for (var i = 0; i < filteredProducts.count; i++) {
                            var productId = filteredProducts.get(i).product_id
                            updateSourceModelSelection(productId, checked)
                        }
                        filterProducts()
                    }
                }

                // Кнопки действий
                Button {
                    text: "Добавить"
                    icon.source: "qrc:/images/add.png"
                    onClicked: {
                        productDialog.createObject(root, {isNew: true}).open()
                    }
                }

                Button {
                    text: "Изменить"
                    icon.source: "qrc:/images/edit.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredProducts.count; i++) {
                            if (filteredProducts.get(i).selected) count++;
                        }
                        return count === 1;
                    }
                    onClicked: {
                        for (var i = 0; i < filteredProducts.count; i++) {
                            if (filteredProducts.get(i).selected) {
                                productDialog.createObject(root, {
                                    currentItem: filteredProducts.get(i),
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
                        for (var i = 0; i < filteredProducts.count; i++) {
                            if (filteredProducts.get(i).selected) count++;
                        }
                        return count > 0;
                    }
                    onClicked: deleteSelectedProducts()
                }

                Button {
                    text: "Активировать"
                    icon.source: "qrc:/images/activate.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredProducts.count; i++) {
                            if (filteredProducts.get(i).selected) count++;
                        }
                        return count > 0;
                    }
                    onClicked: activateSelected(true)
                }

                Button {
                    text: "Деактивировать"
                    icon.source: "qrc:/images/deactivate.png"
                    enabled: {
                        var count = 0;
                        for (var i = 0; i < filteredProducts.count; i++) {
                            if (filteredProducts.get(i).selected) count++;
                        }
                        return count > 0;
                    }
                    onClicked: activateSelected(false)
                }

                // Поиск
                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    placeholderText: "Поиск по товарам..."
                    leftPadding: 30

                    Image {
                        source: "qrc:/images/search.png"
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        width: 20
                        height: 20
                    }

                    onTextChanged: filterProductsTimer.restart()
                }

                Button {
                    text: "Очистить"
                    onClicked: {
                        searchField.text = ""
                        categoryFilter.currentIndex = 0
                        statusFilter.currentIndex = 0
                        filterProducts()
                    }
                }
            }
        }

        // Таблица товаров с горизонтальной прокруткой
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AsNeeded
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            clip: true

            // Заголовки таблицы
            ListView {
                id: productsListView
                anchors.fill: parent
                model: filteredProducts
                clip: true

                // Рассчитываем общую ширину таблицы
                property real totalWidth: 50 + 120 + 250 + 100 + 150 + 100 + 100 + 120 + 120 + 150 + 120 + 120
                width: Math.max(parent.width, totalWidth)

                header: Rectangle {
                    width: productsListView.totalWidth
                    height: 40
                    color: "#3498db"
                    z: 2

                    Row {
                        anchors.fill: parent
                        spacing: 1

                        HeaderCell { width: 50; text: "" }
                        HeaderCell { width: 120; text: "Артикул" }
                        HeaderCell { width: 250; text: "Наименование" }
                        HeaderCell { width: 100; text: "Ед.изм" }
                        HeaderCell { width: 150; text: "Штрих-код" }
                        HeaderCell { width: 100; text: "Мин.запас" }
                        HeaderCell { width: 100; text: "Макс.запас" }
                        HeaderCell { width: 120; text: "Цена закупки" }
                        HeaderCell { width: 120; text: "Цена продажи" }
                        HeaderCell { width: 150; text: "Категория" }
                        HeaderCell { width: 120; text: "Создан" }
                        HeaderCell { width: 120; text: "Обновлен" }
                    }
                }

                delegate: Rectangle {
                    width: productsListView.totalWidth
                    height: 40
                    color: index % 2 === 0 ? "#FFFFFF" : "#F2F4F4"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var selected = !model.selected
                            filteredProducts.setProperty(index, "selected", selected)
                            updateSourceModelSelection(model.product_id, selected)
                        }
                    }

                    Row {
                        anchors.fill: parent
                        spacing: 1

                        // Чекбокс выбора
                        Rectangle {
                            width: 50
                            height: parent.height
                            color: "transparent"

                            CheckBox {
                                anchors.centerIn: parent
                                checked: model.selected
                                onCheckedChanged: {
                                    filteredProducts.setProperty(index, "selected", checked)
                                    updateSourceModelSelection(model.product_id, checked)
                                }
                            }
                        }

                        // Поля товара
                        TextCell {
                            width: 120;
                            text: model.sku
                            cellColor: model.is_active ? "black" : "gray"
                        }
                        TextCell {
                            width: 250;
                            text: model.name
                            cellColor: model.is_active ? "black" : "gray"
                        }
                        TextCell {
                            width: 100;
                            text: model.unit
                            cellColor: model.is_active ? "black" : "gray"
                        }
                        TextCell {
                            width: 150;
                            text: model.barcode
                            cellColor: model.is_active ? "black" : "gray"
                        }
                        TextCell {
                            width: 100;
                            text: model.min_stock
                            color: model.min_stock > 0 ? "black" : "red"
                            horizontalAlignment: Text.AlignRight
                        }
                        TextCell {
                            width: 100;
                            text: model.max_stock
                            color: model.max_stock > 0 ? "black" : "red"
                            horizontalAlignment: Text.AlignRight
                        }
                        TextCell {
                            width: 120;
                            text: Number(model.purchase_price).toLocaleString(Qt.locale("ru_RU"), "f", 2)
                            cellColor: model.is_active ? "black" : "gray"
                            horizontalAlignment: Text.AlignRight
                        }
                        TextCell {
                            width: 120;
                            text: Number(model.selling_price).toLocaleString(Qt.locale("ru_RU"), "f", 2)
                            cellColor: model.is_active ? "black" : "gray"
                            horizontalAlignment: Text.AlignRight
                        }
                        TextCell {
                            width: 150;
                            text: {
                                for (var i = 0; i < categoriesModel.count; i++) {
                                    if (categoriesModel.get(i).category_id === model.category_id) {
                                        return categoriesModel.get(i).name;
                                    }
                                }
                                return "Без категории";
                            }
                            cellColor: model.is_active ? "black" : "gray"
                        }
                        TextCell {
                            width: 120;
                            text: Qt.formatDateTime(new Date(model.created_at), "dd.MM.yyyy")
                            cellColor: model.is_active ? "black" : "gray"
                        }
                        TextCell {
                            width: 120;
                            text: Qt.formatDateTime(new Date(model.updated_at), "dd.MM.yyyy")
                            cellColor: model.is_active ? "black" : "gray"
                        }
                    }
                }
            }
        }

        // Статус бар
        Rectangle {
            Layout.fillWidth: true
            height: 30
            color: "#2C3E50"

            Label {
                anchors.fill: parent
                anchors.leftMargin: 10
                color: "white"
                text: `Показано: ${filteredProducts.count} из ${productsModel.count} товаров`
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Timer {
        id: filterProductsTimer
        interval: 300
        onTriggered: filterProducts()
    }

    Component.onCompleted: filterProducts()

    function filterProducts() {
        var searchText = searchField.text.toLowerCase()
        filteredProducts.clear()

        for (var i = 0; i < productsModel.count; i++) {
            var item = productsModel.get(i)

            // Фильтрация по статусу
            if (!root.showInactive && !item.is_active) continue
            if (statusFilter.currentIndex === 2 && item.is_active) continue

            // Фильтрация по категории
            if (root.currentCategory !== -1 && item.category_id !== root.currentCategory) continue

            var match = searchText.length === 0

            if (!match) {
                // Поиск по всем текстовым полям
                var props = ["sku", "name", "description", "unit", "barcode"]
                for (var j = 0; j < props.length; j++) {
                    var prop = props[j]
                    var value = item[prop] ? item[prop].toString().toLowerCase() : ""
                    if (value.includes(searchText)) {
                        match = true
                        break
                    }
                }

                // Поиск по числовым полям
                if (!match) {
                    var numProps = ["purchase_price", "selling_price", "min_stock", "max_stock"]
                    for (var k = 0; k < numProps.length; k++) {
                        var numProp = numProps[k]
                        var numValue = item[numProp].toString()
                        if (numValue.includes(searchText)) {
                            match = true
                            break
                        }
                    }
                }

                // Поиск по категории
                if (!match) {
                    for (var c = 0; c < categoriesModel.count; c++) {
                        if (categoriesModel.get(c).category_id === item.category_id) {
                            var catName = categoriesModel.get(c).name.toLowerCase()
                            if (catName.includes(searchText)) {
                                match = true
                                break
                            }
                        }
                    }
                }
            }

            if (match) {
                filteredProducts.append({
                    product_id: item.product_id,
                    sku: item.sku,
                    name: item.name,
                    description: item.description,
                    unit: item.unit,
                    barcode: item.barcode,
                    min_stock: item.min_stock,
                    max_stock: item.max_stock,
                    delivery_time: item.delivery_time,
                    purchase_price: item.purchase_price,
                    selling_price: item.selling_price,
                    is_active: item.is_active,
                    category_id: item.category_id,
                    created_at: item.created_at,
                    updated_at: item.updated_at,
                    selected: item.selected || false
                })
            }
        }

        // Сбросить выбор "Все", если не все элементы выбраны
        var allSelected = true;
        for (var idx = 0; idx < filteredProducts.count; idx++) {
            if (!filteredProducts.get(idx).selected) {
                allSelected = false;
                break;
            }
        }
        selectAllCheckBox.checked = allSelected;
    }

    function updateSourceModelSelection(id, selected) {
        for (var i = 0; i < productsModel.count; i++) {
            if (productsModel.get(i).product_id === id) {
                productsModel.setProperty(i, "selected", selected)
                break
            }
        }
    }

    function deleteSelectedProducts() {
        var deleteDialog = Qt.createQmlObject(`
            import QtQuick 2.15
            import QtQuick.Controls 2.15

            Dialog {
                title: "Подтверждение удаления"
                modal: true
                width: 400
                standardButtons: Dialog.Yes | Dialog.No

                Label {
                    text: "Вы действительно хотите удалить выбранные товары?"
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

    function activateSelected(active) {
        for (var i = 0; i < filteredProducts.count; i++) {
            if (filteredProducts.get(i).selected) {
                var id = filteredProducts.get(i).product_id

                // Обновляем в основной модели
                for (var j = 0; j < productsModel.count; j++) {
                    if (productsModel.get(j).product_id === id) {
                        productsModel.set(j, {
                            is_active: active,
                            updated_at: new Date().toISOString()
                        })
                        break
                    }
                }
            }
        }
        filterProducts()
    }

    function confirmDeleteSelected() {
        for (var i = filteredProducts.count - 1; i >= 0; i--) {
            if (filteredProducts.get(i).selected) {
                var id = filteredProducts.get(i).product_id
                filteredProducts.remove(i)

                // Удалить из основной модели
                for (var j = 0; j < productsModel.count; j++) {
                    if (productsModel.get(j).product_id === id) {
                        productsModel.remove(j)
                        break
                    }
                }
            }
        }
        filterProducts()
    }

    // Компонент для ячейки текста
    component TextCell: Label {
        property color cellColor: "black"
        width: parent.width
        height: parent.height
        color: cellColor
        padding: 10
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    // Компонент для заголовка
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
