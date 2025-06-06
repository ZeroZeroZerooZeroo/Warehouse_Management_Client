/**
 * Warehouse Management API
 * API for managing all operations available in the application
 *
 * The version of the OpenAPI document: 1.0.0
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */

#ifndef OAI_OAIInventoryApi_H
#define OAI_OAIInventoryApi_H

#include "OAIHelpers.h"
#include "OAIHttpRequest.h"
#include "OAIServerConfiguration.h"
#include "OAIOauth.h"

#include "OAIInventory.h"
#include "OAIInventoryCreate.h"
#include "OAIInventoryUpdate.h"
#include <QString>

#include <QObject>
#include <QByteArray>
#include <QStringList>
#include <QList>
#include <QNetworkAccessManager>

namespace OpenAPI {

class OAIInventoryApi : public QObject {
    Q_OBJECT

public:
    OAIInventoryApi(const int timeOut = 0);
    ~OAIInventoryApi();

    void initializeServerConfigs();
    int setDefaultServerValue(int serverIndex,const QString &operation, const QString &variable,const QString &val);
    void setServerIndex(const QString &operation, int serverIndex);
    void setApiKey(const QString &apiKeyName, const QString &apiKey);
    void setBearerToken(const QString &token);
    void setUsername(const QString &username);
    void setPassword(const QString &password);
    void setTimeOut(const int timeOut);
    void setWorkingDirectory(const QString &path);
    void setNetworkAccessManager(QNetworkAccessManager* manager);
    int addServerConfiguration(const QString &operation, const QUrl &url, const QString &description = "", const QMap<QString, OAIServerVariable> &variables = QMap<QString, OAIServerVariable>());
    void setNewServerForAllOperations(const QUrl &url, const QString &description = "", const QMap<QString, OAIServerVariable> &variables =  QMap<QString, OAIServerVariable>());
    void setNewServer(const QString &operation, const QUrl &url, const QString &description = "", const QMap<QString, OAIServerVariable> &variables =  QMap<QString, OAIServerVariable>());
    void addHeaders(const QString &key, const QString &value);
    void enableRequestCompression();
    void enableResponseCompression();
    void abortRequests();
    QString getParamStylePrefix(const QString &style);
    QString getParamStyleSuffix(const QString &style);
    QString getParamStyleDelimiter(const QString &style, const QString &name, bool isExplode);


    virtual void inventoryGET();

    /**
    * @param[in]  inventory_id qint32 [required]
    */
    virtual void inventoryInventoryIdDELETE(const qint32 &inventory_id);

    /**
    * @param[in]  inventory_id qint32 [required]
    */
    virtual void inventoryInventoryIdGET(const qint32 &inventory_id);

    /**
    * @param[in]  inventory_id qint32 [required]
    * @param[in]  oai_inventory_update OAIInventoryUpdate [required]
    */
    virtual void inventoryInventoryIdPUT(const qint32 &inventory_id, const OAIInventoryUpdate &oai_inventory_update);

    /**
    * @param[in]  oai_inventory_create OAIInventoryCreate [required]
    */
    virtual void inventoryPOST(const OAIInventoryCreate &oai_inventory_create);


private:
    QMap<QString,int> _serverIndices;
    QMap<QString,QList<OAIServerConfiguration>> _serverConfigs;
    QMap<QString, QString> _apiKeys;
    QString _bearerToken;
    QString _username;
    QString _password;
    int _timeOut;
    QString _workingDirectory;
    QNetworkAccessManager* _manager;
    QMap<QString, QString> _defaultHeaders;
    bool _isResponseCompressionEnabled;
    bool _isRequestCompressionEnabled;
    OAIHttpRequestInput _latestInput;
    OAIHttpRequestWorker *_latestWorker;
    QStringList _latestScope;
    OauthCode _authFlow;
    OauthImplicit _implicitFlow;
    OauthCredentials _credentialFlow;
    OauthPassword _passwordFlow;
    int _OauthMethod = 0;

    void inventoryGETCallback(OAIHttpRequestWorker *worker);
    void inventoryInventoryIdDELETECallback(OAIHttpRequestWorker *worker);
    void inventoryInventoryIdGETCallback(OAIHttpRequestWorker *worker);
    void inventoryInventoryIdPUTCallback(OAIHttpRequestWorker *worker);
    void inventoryPOSTCallback(OAIHttpRequestWorker *worker);

Q_SIGNALS:

    void inventoryGETSignal(QList<OAIInventory> summary);
    void inventoryInventoryIdDELETESignal();
    void inventoryInventoryIdGETSignal(OAIInventory summary);
    void inventoryInventoryIdPUTSignal(OAIInventory summary);
    void inventoryPOSTSignal(OAIInventory summary);


    void inventoryGETSignalFull(OAIHttpRequestWorker *worker, QList<OAIInventory> summary);
    void inventoryInventoryIdDELETESignalFull(OAIHttpRequestWorker *worker);
    void inventoryInventoryIdGETSignalFull(OAIHttpRequestWorker *worker, OAIInventory summary);
    void inventoryInventoryIdPUTSignalFull(OAIHttpRequestWorker *worker, OAIInventory summary);
    void inventoryPOSTSignalFull(OAIHttpRequestWorker *worker, OAIInventory summary);

    Q_DECL_DEPRECATED_X("Use inventoryGETSignalError() instead")
    void inventoryGETSignalE(QList<OAIInventory> summary, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryGETSignalError(QList<OAIInventory> summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use inventoryInventoryIdDELETESignalError() instead")
    void inventoryInventoryIdDELETESignalE(QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryInventoryIdDELETESignalError(QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use inventoryInventoryIdGETSignalError() instead")
    void inventoryInventoryIdGETSignalE(OAIInventory summary, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryInventoryIdGETSignalError(OAIInventory summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use inventoryInventoryIdPUTSignalError() instead")
    void inventoryInventoryIdPUTSignalE(OAIInventory summary, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryInventoryIdPUTSignalError(OAIInventory summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use inventoryPOSTSignalError() instead")
    void inventoryPOSTSignalE(OAIInventory summary, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryPOSTSignalError(OAIInventory summary, QNetworkReply::NetworkError error_type, const QString &error_str);

    Q_DECL_DEPRECATED_X("Use inventoryGETSignalErrorFull() instead")
    void inventoryGETSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryGETSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use inventoryInventoryIdDELETESignalErrorFull() instead")
    void inventoryInventoryIdDELETESignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryInventoryIdDELETESignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use inventoryInventoryIdGETSignalErrorFull() instead")
    void inventoryInventoryIdGETSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryInventoryIdGETSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use inventoryInventoryIdPUTSignalErrorFull() instead")
    void inventoryInventoryIdPUTSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryInventoryIdPUTSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use inventoryPOSTSignalErrorFull() instead")
    void inventoryPOSTSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void inventoryPOSTSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);

    void abortRequestsSignal();
    void allPendingRequestsCompleted();

public Q_SLOTS:
    void tokenAvailable();
};

} // namespace OpenAPI
#endif
