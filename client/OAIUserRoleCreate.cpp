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

#include "OAIUserRoleCreate.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "OAIHelpers.h"

namespace OpenAPI {

OAIUserRoleCreate::OAIUserRoleCreate(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

OAIUserRoleCreate::OAIUserRoleCreate() {
    this->initializeModel();
}

OAIUserRoleCreate::~OAIUserRoleCreate() {}

void OAIUserRoleCreate::initializeModel() {

    m_role_name_isSet = false;
    m_role_name_isValid = false;
}

void OAIUserRoleCreate::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void OAIUserRoleCreate::fromJsonObject(QJsonObject json) {

    m_role_name_isValid = ::OpenAPI::fromJsonValue(m_role_name, json[QString("role_name")]);
    m_role_name_isSet = !json[QString("role_name")].isNull() && m_role_name_isValid;
}

QString OAIUserRoleCreate::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject OAIUserRoleCreate::asJsonObject() const {
    QJsonObject obj;
    if (m_role_name_isSet) {
        obj.insert(QString("role_name"), ::OpenAPI::toJsonValue(m_role_name));
    }
    return obj;
}

QString OAIUserRoleCreate::getRoleName() const {
    return m_role_name;
}
void OAIUserRoleCreate::setRoleName(const QString &role_name) {
    m_role_name = role_name;
    m_role_name_isSet = true;
}

bool OAIUserRoleCreate::is_role_name_Set() const{
    return m_role_name_isSet;
}

bool OAIUserRoleCreate::is_role_name_Valid() const{
    return m_role_name_isValid;
}

bool OAIUserRoleCreate::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_role_name_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool OAIUserRoleCreate::isValid() const {
    // only required properties are required for the object to be considered valid
    return m_role_name_isValid && true;
}

} // namespace OpenAPI
