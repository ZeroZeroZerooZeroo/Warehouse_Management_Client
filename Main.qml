import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./pages"
ApplicationWindow {
    id: root
    width: 1920
    height: 1080
    visible: true
    title: "Динамическое управление складом"

    property string currentPage: "login"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: loginPage
    }

    Component {
        id: loginPage
        LoginPage {
            onLoginSuccess: {
                if (isLoginSuccess) {
                    console.log("Пользователь:", loginResponse.username);
                    stackView.push(mainPage);
                }
            } // Переход на главную страницу
            onGoToRegistration: stackView.push(registrationPage) // Переход на регистрацию
            onGoToForgotPassword: stackView.push(forgotPasswordPage) // Переход на восстановление
        }
    }

    Component {
        id: registrationPage
        RegistrationPage {
            onBackToLogin: stackView.pop() // Возврат на страницу входа
            onRegistrationSuccess: stackView.pop() // Возврат после успешной регистрации
        }
    }

    Component {
        id: forgotPasswordPage
        ForgotPasswordPage {
            onBackToLogin: stackView.pop() // Возврат на страницу входа
        }
    }

    Component {
        id: mainPage
        MainPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: indicatorsPage
        IndicatorsPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            //onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
            onGoToDocuments:stackView.push(documentsPage)
        }
    }

    Component {
        id: purchasesPage
        PurchasesPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: salesPage
        SalesPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: warehousesPage
        WarehousesPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }
    Component {
        id: productsPage
        ProductsPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: counterpartiesPage
        CounterpartiesPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: moneysPage
        MoneyPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: forecastingPage
        ForecastingPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: notificationsPage
        NotificationsPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: helpPage
        HelpPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }

    Component {
        id: profilePage
        ProfilePage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
        }
    }

    Component {
        id: documentsPage
        DocumentsPage {
            onLogout: stackView.pop() // Возврат на страницу входа
            onGoToMain: stackView.push(mainPage)
            onGoToIndicators: stackView.push(indicatorsPage)
            onGoToPurchases:stackView.push(purchasesPage)
            onGoToSales:stackView.push(salesPage)
            onGoToWarehouses:stackView.push(warehousesPage)
            onGoToProducts:stackView.push(productsPage)
            onGoToCounterparties:stackView.push(counterpartiesPage)
            onGoToMoney:stackView.push(moneysPage)
            onGoToForecasting:stackView.push(forecastingPage)
            onGoToNotifications:stackView.push(notificationsPage)
            onGoToHelp:stackView.push(helpPage)
            onGoToProfile:stackView.push(profilePage)
        }
    }
}
