#include <QQmlApplicationEngine>
#include <QApplication>
#include <QtCharts>
#include <QUrl>
#include "client/OAIUsersApi.h"
#include <QQmlContext>
#include "client/OAIUser.h"

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
     qRegisterMetaType<OpenAPI::OAIUser>("OAIUser");
    QQmlApplicationEngine engine;


    OpenAPI::OAIUsersApi *usersApi = new OpenAPI::OAIUsersApi();
    usersApi->setNewServerForAllOperations(QUrl("http://localhost:3000"),
                                           "Development server",
                                           QMap<QString, OpenAPI::OAIServerVariable>());

    engine.rootContext()->setContextProperty("usersApi", usersApi);

    engine.loadFromModule("Warehouse_Management_Client", "Main");
    return app.exec();
}
