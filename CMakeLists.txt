cmake_minimum_required(VERSION 3.16)

project(Warehouse_Management_Client VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Core
    Gui
    Widgets
    Qml
    Quick
    QuickControls2
    Charts
)
qt_standard_project_setup(REQUIRES 6.8)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)





qt_add_executable(appWarehouse_Management_Client
    main.cpp
    images.qrc
)

qt_add_qml_module(appWarehouse_Management_Client
    URI Warehouse_Management_Client
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES client/OAICustomer.cpp client/OAICustomer.h client/OAICustomerCreate.cpp client/OAICustomerCreate.h client/OAICustomersApi.cpp client/OAICustomersApi.h client/OAICustomerUpdate.cpp client/OAICustomerUpdate.h client/OAIDemandForecast.cpp client/OAIDemandForecast.h client/OAIDemandForecastCreate.cpp client/OAIDemandForecastCreate.h client/OAIDemandForecastUpdate.cpp client/OAIDemandForecastUpdate.h client/OAIDocument.cpp client/OAIDocument.h client/OAIDocumentCreate.cpp client/OAIDocumentCreate.h client/OAIDocumentItem.cpp client/OAIDocumentItem.h client/OAIDocumentItemCreate.cpp client/OAIDocumentItemCreate.h client/OAIDocumentItemUpdate.cpp client/OAIDocumentItemUpdate.h client/OAIDocumentsApi.cpp client/OAIDocumentsApi.h client/OAIDocumentStatus.cpp client/OAIDocumentStatus.h client/OAIDocumentStatusCreate.cpp client/OAIDocumentStatusCreate.h client/OAIDocumentStatusUpdate.cpp client/OAIDocumentStatusUpdate.h client/OAIDocumentType.cpp client/OAIDocumentType.h client/OAIDocumentTypeCreate.cpp client/OAIDocumentTypeCreate.h client/OAIDocumentTypeUpdate.cpp client/OAIDocumentTypeUpdate.h client/OAIDocumentUpdate.cpp client/OAIDocumentUpdate.h client/OAIEnum.h client/OAIForecastNNRequest.cpp client/OAIForecastNNRequest.h client/OAIForecastsApi.cpp client/OAIForecastsApi.h client/OAIForecastsType.cpp client/OAIForecastsType.h client/OAIForecastsTypeCreate.cpp client/OAIForecastsTypeCreate.h client/OAIForecastsTypeUpdate.cpp client/OAIForecastsTypeUpdate.h client/OAIHelpers.cpp client/OAIHelpers.h client/OAIHttpFileElement.cpp client/OAIHttpFileElement.h client/OAIHttpRequest.cpp client/OAIHttpRequest.h client/OAIInline_object.cpp client/OAIInline_object.h client/OAIInline_object_1.cpp client/OAIInline_object_1.h client/OAIInline_object_2.cpp client/OAIInline_object_2.h client/OAIInline_object_3.cpp client/OAIInline_object_3.h client/OAIInline_object_4.cpp client/OAIInline_object_4.h client/OAIInventory.cpp client/OAIInventory.h client/OAIInventoryApi.cpp client/OAIInventoryApi.h client/OAIInventoryCreate.cpp client/OAIInventoryCreate.h client/OAIInventoryUpdate.cpp client/OAIInventoryUpdate.h client/OAILoginRequest.cpp client/OAILoginRequest.h client/OAIMovementType.cpp client/OAIMovementType.h client/OAIMovementTypeCreate.cpp client/OAIMovementTypeCreate.h client/OAIMovementTypeUpdate.cpp client/OAIMovementTypeUpdate.h client/OAINotification.cpp client/OAINotification.h client/OAINotificationCreate.cpp client/OAINotificationCreate.h client/OAINotificationsApi.cpp client/OAINotificationsApi.h client/OAINotificationUpdate.cpp client/OAINotificationUpdate.h client/OAIOauth.cpp client/OAIOauth.h client/OAIObject.h client/OAIProduct.cpp client/OAIProduct.h client/OAIProductCategory.cpp client/OAIProductCategory.h client/OAIProductCategoryCreate.cpp client/OAIProductCategoryCreate.h client/OAIProductCategoryUpdate.cpp client/OAIProductCategoryUpdate.h client/OAIProductCreate.cpp client/OAIProductCreate.h client/OAIProductRef.cpp client/OAIProductRef.h client/OAIProductsApi.cpp client/OAIProductsApi.h client/OAIProductUpdate.cpp client/OAIProductUpdate.h client/OAIProfilesApi.cpp client/OAIProfilesApi.h client/OAISalesApi.cpp client/OAISalesApi.h client/OAISalesHistory.cpp client/OAISalesHistory.h client/OAISalesHistoryCreate.cpp client/OAISalesHistoryCreate.h client/OAISalesHistoryUpdate.cpp client/OAISalesHistoryUpdate.h client/OAIServerConfiguration.h client/OAIServerVariable.h client/OAIStockMovement.cpp client/OAIStockMovement.h client/OAIStockMovementCreate.cpp client/OAIStockMovementCreate.h client/OAIStockMovementsApi.cpp client/OAIStockMovementsApi.h client/OAIStockMovementUpdate.cpp client/OAIStockMovementUpdate.h client/OAISupplier.cpp client/OAISupplier.h client/OAISupplierCreate.cpp client/OAISupplierCreate.h client/OAISuppliersApi.cpp client/OAISuppliersApi.h client/OAISupplierUpdate.cpp client/OAISupplierUpdate.h client/OAIUser.cpp client/OAIUser.h client/OAIUserCreate.cpp client/OAIUserCreate.h client/OAIUserProfile.cpp client/OAIUserProfile.h client/OAIUserProfileCreate.cpp client/OAIUserProfileCreate.h client/OAIUserProfileUpdate.cpp client/OAIUserProfileUpdate.h client/OAIUserRole.cpp client/OAIUserRole.h client/OAIUserRoleCreate.cpp client/OAIUserRoleCreate.h client/OAIUserRoleUpdate.cpp client/OAIUserRoleUpdate.h client/OAIUsersApi.cpp client/OAIUsersApi.h client/OAIUserUpdate.cpp client/OAIUserUpdate.h client/OAIWarehouse.cpp client/OAIWarehouse.h client/OAIWarehouseCreate.cpp client/OAIWarehouseCreate.h client/OAIWarehousesApi.cpp client/OAIWarehousesApi.h client/OAIWarehouseUpdate.cpp client/OAIWarehouseUpdate.h
RESOURCES images/forecast.png images/help.png images/home.png images/logo.png images/money.png images/notifications.png images/partners.png images/products.png images/profile.png images/purchase.png images/sales.png images/stats.png images/warehouse.png
QML_FILES components/Header.qml components/HeaderButton.qml components/Logo.qml pages/CounterpartiesPage.qml pages/DocumentsPage.qml pages/ForecastingPage.qml pages/ForgotPasswordPage.qml pages/IndicatorsPage.qml pages/LoginPage.qml pages/MainPage.qml pages/MoneyPage.qml pages/ProductsPage.qml pages/ProfilePage.qml pages/PurchasesPage.qml pages/RegistrationPage.qml pages/SalesPage.qml pages/WarehousesPage.qml
QML_FILES components/HelpPopup.qml components/NotificationPopup.qml
QML_FILES pages/DocumentTypesPage.qml
QML_FILES pages/WarehouseDetailsPage.qml





)



# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appWarehouse_Management_Client PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appWarehouse_Management_Client
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWarehouse_Management_Client PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Charts

)

include(GNUInstallDirs)
install(TARGETS appWarehouse_Management_Client
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
