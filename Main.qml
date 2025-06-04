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
    property var currentUser: null
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: loginPage
    }

    Component {
        id: loginPage
        LoginPage {
            onLoginSuccess: function(userMap) {

                        root.currentUser = userMap;
                        stackView.push(mainPage);
                    }
            onGoToRegistration: stackView.push(registrationPage)
            onGoToForgotPassword: stackView.push(forgotPasswordPage)
        }
    }

    Component {
        id: registrationPage
        RegistrationPage {
            onBackToLogin: stackView.pop()
            onRegistrationSuccess: stackView.pop()
        }
    }

    Component {
        id: forgotPasswordPage
        ForgotPasswordPage {
            onBackToLogin: stackView.pop()
        }
    }

    Component {
        id: mainPage
        MainPage {
            property var pageUser: root.currentUser
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
            onLogout: stackView.pop()
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
