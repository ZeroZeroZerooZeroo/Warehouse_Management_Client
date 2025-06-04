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


    property var userData: {
        "user_id": 1,
        "username": "ivanov",
        "email": "ivanov@example.com",
        "is_active": true,
        "created_at": "2025-05-01 10:00:00",
        "last_login": "2025-05-29 15:30:00",
        "inn": "1234567890",
        "organization": "ООО 'Ромашка'",
        "role_id": 1,
        "profile": {
            "full_name": "Иванов Иван Иванович",
            "phone": "+7 (900) 123-45-67",
            "position": "Менеджер по закупкам",
            "department": "Отдел закупок",
            "birth_date": "1985-04-15",
            "avatar_path": "qrc:/images/avatar.jpg"
        }
    }

    
    property bool editMode: false
    
    property var editedData: JSON.parse(JSON.stringify(userData))

    background: Rectangle {
        color: "#F5F7FA"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        
        Header {
            Layout.fillWidth: true
            userInfo: (userData.profile.full_name || userData.username) + "\n" + userData.email
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
            color: "#FFFFFF"
            border.color: "#E4E7EB"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20

                Label {
                    text: "Профиль пользователя"
                    font.pixelSize: 22
                    font.bold: true
                    color: "#2D3748"
                }

                Item { Layout.fillWidth: true }

                
                Row {
                    spacing: 10

                    Button {
                        visible: !editMode
                        text: "Редактировать"
                        icon.source: "qrc:/images/edit.png"
                        flat: true
                        contentItem: Row {
                            spacing: 6
                            Image { source: parent.parent.icon.source; sourceSize: Qt.size(16, 16) }
                            Text { text: parent.parent.text; color: "#4A5568"; font.pixelSize: 14 }
                        }
                        background: Rectangle {
                            radius: 4
                            border.color: "#CBD5E0"
                            border.width: 1
                            color: parent.down ? "#EDF2F7" : "transparent"
                        }
                        onClicked: {
                            editMode = true
                            editedData = JSON.parse(JSON.stringify(userData))
                        }
                    }

                    Button {
                        visible: editMode
                        text: "Сохранить"
                        icon.source: "qrc:/images/save.png"
                        flat: true
                        contentItem: Row {
                            spacing: 6
                            Image { source: parent.parent.icon.source; sourceSize: Qt.size(16, 16) }
                            Text { text: parent.parent.text; color: "#FFFFFF"; font.pixelSize: 14 }
                        }
                        background: Rectangle {
                            radius: 4
                            color: "#3182CE"
                        }
                        onClicked: {
                            userData = JSON.parse(JSON.stringify(editedData))
                            editMode = false
                        }
                    }

                    Button {
                        visible: editMode
                        text: "Отмена"
                        icon.source: "qrc:/images/cancel.png"
                        flat: true
                        contentItem: Row {
                            spacing: 6
                            Image { source: parent.parent.icon.source; sourceSize: Qt.size(16, 16) }
                            Text { text: parent.parent.text; color: "#4A5568"; font.pixelSize: 14 }
                        }
                        background: Rectangle {
                            radius: 4
                            border.color: "#CBD5E0"
                            border.width: 1
                            color: parent.down ? "#EDF2F7" : "transparent"
                        }
                        onClicked: editMode = false
                    }

                    Button {
                        text: "Выход"
                        icon.source: "qrc:/images/logout.png"
                        flat: true
                        contentItem: Row {
                            spacing: 6
                            Image { source: parent.parent.icon.source; sourceSize: Qt.size(16, 16) }
                            Text { text: parent.parent.text; color: "#E53E3E"; font.pixelSize: 14 }
                        }
                        background: Rectangle {
                            radius: 4
                            border.color: "#E53E3E"
                            border.width: 1
                            color: parent.down ? "#FED7D7" : "transparent"
                        }
                        onClicked: root.logout()
                    }
                }
            }
        }

        
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#F5F7FA"

            Flickable  {
                anchors.fill: parent
                anchors.margins: 20
                clip: true
                contentWidth: Math.max(parent.width, 550)
                contentHeight: contentItem.height
                Item {
                    id: contentItem
                            width: Math.max(parent.width, 550) 
                            height: column.height
                Column {
                    id: column
                    width: parent.width
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter


                    Rectangle {
                        id: profileCard
                        width: parent.width
                        height: profileLayout.height + 40
                        
                        radius: 12
                        color: "#FFFFFF"
                        border.color: "#E2E8F0"
                        border.width: 1

                        ColumnLayout {
                            id: profileLayout
                            anchors {
                                top: parent.top
                                left: parent.left
                                right: parent.right
                                margins: 30
                            }

                            spacing: 25

                            
                            RowLayout {
                                spacing: 30
                                Layout.alignment: Qt.AlignHCenter
                                
                                Column {
                                    spacing: 15
                                    Layout.alignment: Qt.AlignTop

                                    Rectangle {
                                        width: 150
                                        height: 150
                                        radius: 75
                                        color: "#EDF2F7"
                                        clip: true

                                        Image {
                                            anchors.fill: parent
                                            source: editMode ? editedData.profile.avatar_path : userData.profile.avatar_path
                                            fillMode: Image.PreserveAspectCrop
                                            mipmap: true
                                        }

                                       
                                        Rectangle {
                                            anchors.fill: parent
                                            radius: parent.radius
                                            color: "transparent"
                                            border.color: "#CBD5E0"
                                            border.width: 1
                                        }
                                    }

                                    Button {
                                        visible: editMode
                                        text: "Изменить фото"
                                        width: 150
                                        icon.source: "qrc:/images/photo.png"
                                        flat: true
                                        contentItem: Row {
                                            spacing: 6
                                            Image { source: parent.parent.icon.source; sourceSize: Qt.size(16, 16) }
                                            Text { text: parent.parent.text; color: "#4A5568"; font.pixelSize: 12 }
                                        }
                                        background: Rectangle {
                                            radius: 4
                                            border.color: "#CBD5E0"
                                            border.width: 1
                                            color: parent.down ? "#EDF2F7" : "transparent"
                                        }
                                    }
                                }

                                ColumnLayout {
                                    spacing: 12
                                    Layout.fillWidth: true

                                  
                                    Label {
                                        visible: !editMode
                                        text: userData.profile.full_name || userData.username
                                        font.pixelSize: 26
                                        font.bold: true
                                        color: "#1A202C"
                                    }

                                    TextField {
                                        visible: editMode
                                        id: fullNameField
                                        text: editedData.profile.full_name
                                        onTextChanged: editedData.profile.full_name = text
                                        placeholderText: "ФИО"
                                        font.pixelSize: 26
                                        Layout.fillWidth: true
                                        background: Rectangle {
                                            implicitHeight: 40
                                            radius: 4
                                            border.color: fullNameField.activeFocus ? "#3182CE" : "#CBD5E0"
                                            border.width: 1
                                        }
                                    }

                                  
                                    Label {
                                        visible: !editMode
                                        text: userData.profile.position
                                        font.pixelSize: 18
                                        color: "#4A5568"
                                    }

                                    TextField {
                                        visible: editMode
                                        id: positionField
                                        text: editedData.profile.position
                                        onTextChanged: editedData.profile.position = text
                                        placeholderText: "Должность"
                                        font.pixelSize: 18
                                        Layout.fillWidth: true
                                        background: Rectangle {
                                            implicitHeight: 36
                                            radius: 4
                                            border.color: positionField.activeFocus ? "#3182CE" : "#CBD5E0"
                                            border.width: 1
                                        }
                                    }

                                
                                    Label {
                                        visible: !editMode
                                        text: userData.profile.department
                                        font.pixelSize: 16
                                        color: "#718096"
                                    }

                                    TextField {
                                        visible: editMode
                                        id: departmentField
                                        text: editedData.profile.department
                                        onTextChanged: editedData.profile.department = text
                                        placeholderText: "Отдел"
                                        font.pixelSize: 16
                                        Layout.fillWidth: true
                                        background: Rectangle {
                                            implicitHeight: 34
                                            radius: 4
                                            border.color: departmentField.activeFocus ? "#3182CE" : "#CBD5E0"
                                            border.width: 1
                                        }
                                    }

                                    
                                    GridLayout {
                                        columns: 2
                                        columnSpacing: 20
                                        rowSpacing: 15
                                        Layout.topMargin: 10

                                 
                                        RowLayout {
                                            spacing: 10
                                            Image {
                                                source: "qrc:/images/phone.png"
                                                sourceSize: Qt.size(20, 20)
                                                opacity: 0.7
                                            }
                                            Label {
                                                visible: !editMode
                                                text: userData.profile.phone
                                                font.pixelSize: 16
                                                color: "#4A5568"
                                            }
                                            TextField {
                                                visible: editMode
                                                id: phoneField
                                                text: editedData.profile.phone
                                                onTextChanged: editedData.profile.phone = text
                                                placeholderText: "Телефон"
                                                font.pixelSize: 16
                                                Layout.fillWidth: true
                                                background: Rectangle {
                                                    implicitHeight: 34
                                                    radius: 4
                                                    border.color: phoneField.activeFocus ? "#3182CE" : "#CBD5E0"
                                                    border.width: 1
                                                }
                                            }
                                        }

                                  
                                        RowLayout {
                                            spacing: 10
                                            Image {
                                                source: "qrc:/images/email.png"
                                                sourceSize: Qt.size(20, 20)
                                                opacity: 0.7
                                            }
                                            Label {
                                                visible: !editMode
                                                text: userData.email
                                                font.pixelSize: 16
                                                color: "#4A5568"
                                            }
                                            TextField {
                                                visible: editMode
                                                id: emailField
                                                text: editedData.email
                                                onTextChanged: editedData.email = text
                                                placeholderText: "Email"
                                                font.pixelSize: 16
                                                Layout.fillWidth: true
                                                background: Rectangle {
                                                    implicitHeight: 34
                                                    radius: 4
                                                    border.color: emailField.activeFocus ? "#3182CE" : "#CBD5E0"
                                                    border.width: 1
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                      
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#E2E8F0"
                                Layout.topMargin: 5
                                Layout.bottomMargin: 5
                            }

                     
                            GridLayout {
                                Layout.fillWidth: true
                                columns: 2
                                columnSpacing: 30
                                rowSpacing: 20

                                Label {
                                    text: "Организация:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                }

                                RowLayout {
                                    Label {
                                        visible: !editMode
                                        text: userData.organization
                                        font.pixelSize: 16
                                        color: "#1A202C"
                                    }
                                    TextField {
                                        visible: editMode
                                        id: organizationField
                                        text: editedData.organization
                                        onTextChanged: editedData.organization = text
                                        placeholderText: "Организация"
                                        font.pixelSize: 16
                                        Layout.fillWidth: true
                                        background: Rectangle {
                                            implicitHeight: 34
                                            radius: 4
                                            border.color: organizationField.activeFocus ? "#3182CE" : "#CBD5E0"
                                            border.width: 1
                                        }
                                    }
                                }

                               
                                Label {
                                    text: "ИНН:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                }

                                RowLayout {
                                    Label {
                                        visible: !editMode
                                        text: userData.inn
                                        font.pixelSize: 16
                                        color: "#1A202C"
                                    }
                                    TextField {
                                        visible: editMode
                                        id: innField
                                        text: editedData.inn
                                        onTextChanged: editedData.inn = text
                                        placeholderText: "ИНН"
                                        font.pixelSize: 16
                                        Layout.fillWidth: true
                                        background: Rectangle {
                                            implicitHeight: 34
                                            radius: 4
                                            border.color: innField.activeFocus ? "#3182CE" : "#CBD5E0"
                                            border.width: 1
                                        }
                                    }
                                }

                             
                                Label {
                                    text: "Роль в системе:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                }

                                Label {
                                    text: {
                                        var roleId = editMode ? editedData.role_id : userData.role_id
                                        switch(roleId) {
                                            case 1: return "Администратор";
                                            case 2: return "Менеджер";
                                            case 3: return "Кладовщик";
                                            default: return "Пользователь";
                                        }
                                    }
                                    font.pixelSize: 16
                                    color: "#1A202C"
                                }

                          
                                Label {
                                    text: "Дата рождения:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                }

                                RowLayout {
                                    Label {
                                        visible: !editMode
                                        text: userData.profile.birth_date
                                        font.pixelSize: 16
                                        color: "#1A202C"
                                    }
                                    TextField {
                                        visible: editMode
                                        id: birthDateField
                                        text: editedData.profile.birth_date
                                        onTextChanged: editedData.profile.birth_date = text
                                        placeholderText: "ГГГГ-ММ-ДД"
                                        font.pixelSize: 16
                                        Layout.fillWidth: true
                                        background: Rectangle {
                                            implicitHeight: 34
                                            radius: 4
                                            border.color: birthDateField.activeFocus ? "#3182CE" : "#CBD5E0"
                                            border.width: 1
                                        }
                                    }
                                }

                              
                                Label {
                                    text: "Дата регистрации:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                }

                                Label {
                                    text: userData.created_at.substring(0, 10)
                                    font.pixelSize: 16
                                    color: "#1A202C"
                                }

                               
                                Label {
                                    text: "Последний вход:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                }

                                Label {
                                    text: userData.last_login.substring(0, 16)
                                    font.pixelSize: 16
                                    color: "#1A202C"
                                }
                            }
                        }
                    }

                 
                    Rectangle {
                        id: passwordBlock
                        visible: editMode
                        width: parent.width
                        height: passwordLayout.height + 40
                        radius: 12
                        color: "#FFFFFF"
                        border.color: "#E2E8F0"
                        border.width: 1



                        ColumnLayout {
                            id: passwordLayout
                            anchors {
                                top: parent.top
                                left: parent.left
                                right: parent.right
                                margins: 30
                            }
                            spacing: 20

                            Label {
                                text: "Смена пароля"
                                font.pixelSize: 20
                                font.bold: true
                                color: "#2D3748"
                            }

                            GridLayout {
                                columns: 2
                                columnSpacing: 25
                                rowSpacing: 18
                                Layout.fillWidth: true

                                Label {
                                    text: "Текущий пароль:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                    Layout.alignment: Qt.AlignRight
                                }

                                TextField {
                                    id: currentPasswordField
                                    echoMode: TextInput.Password
                                    placeholderText: "Введите текущий пароль"
                                    font.pixelSize: 16
                                    Layout.fillWidth: true
                                    background: Rectangle {
                                        implicitHeight: 40
                                        radius: 4
                                        border.color: currentPasswordField.activeFocus ? "#3182CE" : "#CBD5E0"
                                        border.width: 1
                                    }
                                }

                                Label {
                                    text: "Новый пароль:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                    Layout.alignment: Qt.AlignRight
                                }

                                TextField {
                                    id: newPasswordField
                                    echoMode: TextInput.Password
                                    placeholderText: "Введите новый пароль"
                                    font.pixelSize: 16
                                    Layout.fillWidth: true
                                    background: Rectangle {
                                        implicitHeight: 40
                                        radius: 4
                                        border.color: newPasswordField.activeFocus ? "#3182CE" : "#CBD5E0"
                                        border.width: 1
                                    }
                                }

                                Label {
                                    text: "Повторите пароль:"
                                    font.pixelSize: 16
                                    color: "#718096"
                                    Layout.alignment: Qt.AlignRight
                                }

                                TextField {
                                    id: repeatPasswordField
                                    echoMode: TextInput.Password
                                    placeholderText: "Повторите новый пароль"
                                    font.pixelSize: 16
                                    Layout.fillWidth: true
                                    background: Rectangle {
                                        implicitHeight: 40
                                        radius: 4
                                        border.color: repeatPasswordField.activeFocus ? "#3182CE" : "#CBD5E0"
                                        border.width: 1
                                    }
                                }
                            }

                            Button {
                                text: "Сменить пароль"
                                icon.source: "qrc:/images/key.png"
                                Layout.alignment: Qt.AlignRight
                                contentItem: Row {
                                    spacing: 8
                                    Image { source: parent.parent.icon.source; sourceSize: Qt.size(18, 18) }
                                    Text { text: parent.parent.text; color: "#FFFFFF"; font.pixelSize: 14; font.bold: true }
                                }
                                background: Rectangle {
                                    implicitHeight: 40
                                    implicitWidth: 180
                                    radius: 6
                                    color: parent.down ? "#2B6CB0" : "#3182CE"
                                }
                            }
                        }
                    }
                }
                }
            }

            ScrollBar {
                    id: verticalScrollBar
                    width: 10
                    anchors {
                        right: flickable.right
                        top: flickable.top
                        bottom: flickable.bottom
                    }
                    orientation: Qt.Vertical
                    policy: ScrollBar.AlwaysOn
                    visible: flickable.contentHeight > flickable.height

                    contentItem: Rectangle {
                        implicitWidth: 6
                        implicitHeight: 100
                        radius: width / 2
                        color: verticalScrollBar.pressed ? "#718096" : "#CBD5E0"
                    }
                }


        }
    }
    Connections {
        target: root
        function onEditModeChanged() {
            if (root.editMode) {
                
                Qt.callLater(function() {
                    
                    const targetY = passwordBlock.mapToItem(contentItem, 0, 0).y
                    const scrollPosition = Math.min(targetY, flickable.contentHeight - flickable.height)

                    
                    flickable.contentY = scrollPosition - 50
                })
            }
        }
    }

}
