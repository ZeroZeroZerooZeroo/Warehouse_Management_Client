#include <QQmlApplicationEngine>
#include <QApplication>
#include <QtCharts>
#include <QUrl> // Добавляем для работы с QUrl
#include "client/OAIUsersApi.h"
#include <QQmlContext>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Создаем API
    OpenAPI::OAIUsersApi *usersApi = new OpenAPI::OAIUsersApi();
    usersApi->setNewServerForAllOperations(QUrl("http://localhost:3000"),
                                           "Development server",
                                           QMap<QString, OpenAPI::OAIServerVariable>());

    // Регистрируем API как глобальный объект
    engine.rootContext()->setContextProperty("usersApi", usersApi);

    engine.loadFromModule("Warehouse_Management_Client", "Main");
    return app.exec();
}
