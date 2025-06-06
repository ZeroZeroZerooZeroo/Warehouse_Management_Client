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

#ifndef OAI_OAIUsersApi_H
#define OAI_OAIUsersApi_H

#include "OAIHelpers.h"
#include "OAIHttpRequest.h"
#include "OAIServerConfiguration.h"
#include "OAIOauth.h"

#include "OAILoginRequest.h"
#include "OAIUser.h"
#include "OAIUserCreate.h"
#include "OAIUserRole.h"
#include "OAIUserRoleCreate.h"
#include "OAIUserRoleUpdate.h"
#include "OAIUserUpdate.h"
#include <QString>

#include <QObject>
#include <QByteArray>
#include <QStringList>
#include <QList>
#include <QNetworkAccessManager>

namespace OpenAPI {

class OAIUsersApi : public QObject {
    Q_OBJECT

public:
    OAIUsersApi(const int timeOut = 0);
    ~OAIUsersApi();

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
    Q_INVOKABLE void qmlUsersLoginPOST(const QString& username, const QString& password);

    virtual void rolesGET();

    /**
    * @param[in]  oai_user_role_create OAIUserRoleCreate [required]
    */
    virtual void rolesPOST(const OAIUserRoleCreate &oai_user_role_create);

    /**
    * @param[in]  role_id qint32 [required]
    */
    virtual void rolesRoleIdDELETE(const qint32 &role_id);

    /**
    * @param[in]  role_id qint32 [required]
    */
    virtual void rolesRoleIdGET(const qint32 &role_id);

    /**
    * @param[in]  role_id qint32 [required]
    * @param[in]  oai_user_role_update OAIUserRoleUpdate [required]
    */
    virtual void rolesRoleIdPUT(const qint32 &role_id, const OAIUserRoleUpdate &oai_user_role_update);


    virtual void usersGET();

    /**
    * @param[in]  oai_login_request OAILoginRequest [required]
    */
    virtual void usersLoginPOST(const OAILoginRequest &oai_login_request);

    /**
    * @param[in]  oai_user_create OAIUserCreate [required]
    */
    virtual void usersPOST(const OAIUserCreate &oai_user_create);

    /**
    * @param[in]  user_id qint32 [required]
    */
    virtual void usersUserIdDELETE(const qint32 &user_id);

    /**
    * @param[in]  user_id qint32 [required]
    */
    virtual void usersUserIdGET(const qint32 &user_id);

    /**
    * @param[in]  user_id qint32 [required]
    * @param[in]  oai_user_update OAIUserUpdate [required]
    */
    virtual void usersUserIdPUT(const qint32 &user_id, const OAIUserUpdate &oai_user_update);


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

    void rolesGETCallback(OAIHttpRequestWorker *worker);
    void rolesPOSTCallback(OAIHttpRequestWorker *worker);
    void rolesRoleIdDELETECallback(OAIHttpRequestWorker *worker);
    void rolesRoleIdGETCallback(OAIHttpRequestWorker *worker);
    void rolesRoleIdPUTCallback(OAIHttpRequestWorker *worker);
    void usersGETCallback(OAIHttpRequestWorker *worker);
    void usersLoginPOSTCallback(OAIHttpRequestWorker *worker);
    void usersPOSTCallback(OAIHttpRequestWorker *worker);
    void usersUserIdDELETECallback(OAIHttpRequestWorker *worker);
    void usersUserIdGETCallback(OAIHttpRequestWorker *worker);
    void usersUserIdPUTCallback(OAIHttpRequestWorker *worker);

Q_SIGNALS:

    void rolesGETSignal(QList<OAIUserRole> summary);
    void rolesPOSTSignal(OAIUserRole summary);
    void rolesRoleIdDELETESignal();
    void rolesRoleIdGETSignal(OAIUserRole summary);
    void rolesRoleIdPUTSignal(OAIUserRole summary);
    void usersGETSignal(QList<OAIUser> summary);
    //void usersLoginPOSTSignal(OAIUser summary);
    void usersLoginPOSTSignal(QVariantMap summary);
    void usersPOSTSignal(OAIUser summary);
    void usersUserIdDELETESignal();
    void usersUserIdGETSignal(OAIUser summary);
    void usersUserIdPUTSignal(OAIUser summary);


    void rolesGETSignalFull(OAIHttpRequestWorker *worker, QList<OAIUserRole> summary);
    void rolesPOSTSignalFull(OAIHttpRequestWorker *worker, OAIUserRole summary);
    void rolesRoleIdDELETESignalFull(OAIHttpRequestWorker *worker);
    void rolesRoleIdGETSignalFull(OAIHttpRequestWorker *worker, OAIUserRole summary);
    void rolesRoleIdPUTSignalFull(OAIHttpRequestWorker *worker, OAIUserRole summary);
    void usersGETSignalFull(OAIHttpRequestWorker *worker, QList<OAIUser> summary);
    void usersLoginPOSTSignalFull(OAIHttpRequestWorker *worker, OAIUser summary);
    void usersPOSTSignalFull(OAIHttpRequestWorker *worker, OAIUser summary);
    void usersUserIdDELETESignalFull(OAIHttpRequestWorker *worker);
    void usersUserIdGETSignalFull(OAIHttpRequestWorker *worker, OAIUser summary);
    void usersUserIdPUTSignalFull(OAIHttpRequestWorker *worker, OAIUser summary);

    Q_DECL_DEPRECATED_X("Use rolesGETSignalError() instead")
    void rolesGETSignalE(QList<OAIUserRole> summary, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesGETSignalError(QList<OAIUserRole> summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use rolesPOSTSignalError() instead")
    void rolesPOSTSignalE(OAIUserRole summary, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesPOSTSignalError(OAIUserRole summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use rolesRoleIdDELETESignalError() instead")
    void rolesRoleIdDELETESignalE(QNetworkReply::NetworkError error_type, QString error_str);
    void rolesRoleIdDELETESignalError(QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use rolesRoleIdGETSignalError() instead")
    void rolesRoleIdGETSignalE(OAIUserRole summary, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesRoleIdGETSignalError(OAIUserRole summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use rolesRoleIdPUTSignalError() instead")
    void rolesRoleIdPUTSignalE(OAIUserRole summary, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesRoleIdPUTSignalError(OAIUserRole summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersGETSignalError() instead")
    void usersGETSignalE(QList<OAIUser> summary, QNetworkReply::NetworkError error_type, QString error_str);
    void usersGETSignalError(QList<OAIUser> summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersLoginPOSTSignalError() instead")
    void usersLoginPOSTSignalE(OAIUser summary, QNetworkReply::NetworkError error_type, QString error_str);
    void usersLoginPOSTSignalError(OAIUser summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersPOSTSignalError() instead")
    void usersPOSTSignalE(OAIUser summary, QNetworkReply::NetworkError error_type, QString error_str);
    void usersPOSTSignalError(OAIUser summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersUserIdDELETESignalError() instead")
    void usersUserIdDELETESignalE(QNetworkReply::NetworkError error_type, QString error_str);
    void usersUserIdDELETESignalError(QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersUserIdGETSignalError() instead")
    void usersUserIdGETSignalE(OAIUser summary, QNetworkReply::NetworkError error_type, QString error_str);
    void usersUserIdGETSignalError(OAIUser summary, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersUserIdPUTSignalError() instead")
    void usersUserIdPUTSignalE(OAIUser summary, QNetworkReply::NetworkError error_type, QString error_str);
    void usersUserIdPUTSignalError(OAIUser summary, QNetworkReply::NetworkError error_type, const QString &error_str);

    Q_DECL_DEPRECATED_X("Use rolesGETSignalErrorFull() instead")
    void rolesGETSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesGETSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use rolesPOSTSignalErrorFull() instead")
    void rolesPOSTSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesPOSTSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use rolesRoleIdDELETESignalErrorFull() instead")
    void rolesRoleIdDELETESignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesRoleIdDELETESignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use rolesRoleIdGETSignalErrorFull() instead")
    void rolesRoleIdGETSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesRoleIdGETSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use rolesRoleIdPUTSignalErrorFull() instead")
    void rolesRoleIdPUTSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void rolesRoleIdPUTSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersGETSignalErrorFull() instead")
    void usersGETSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void usersGETSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersLoginPOSTSignalErrorFull() instead")
    void usersLoginPOSTSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void usersLoginPOSTSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersPOSTSignalErrorFull() instead")
    void usersPOSTSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void usersPOSTSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersUserIdDELETESignalErrorFull() instead")
    void usersUserIdDELETESignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void usersUserIdDELETESignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersUserIdGETSignalErrorFull() instead")
    void usersUserIdGETSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void usersUserIdGETSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);
    Q_DECL_DEPRECATED_X("Use usersUserIdPUTSignalErrorFull() instead")
    void usersUserIdPUTSignalEFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, QString error_str);
    void usersUserIdPUTSignalErrorFull(OAIHttpRequestWorker *worker, QNetworkReply::NetworkError error_type, const QString &error_str);

    void abortRequestsSignal();
    void allPendingRequestsCompleted();

public Q_SLOTS:
    void tokenAvailable();
};

} // namespace OpenAPI
#endif
