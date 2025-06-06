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

#include "OAIForecastsTypeCreate.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "OAIHelpers.h"

namespace OpenAPI {

OAIForecastsTypeCreate::OAIForecastsTypeCreate(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

OAIForecastsTypeCreate::OAIForecastsTypeCreate() {
    this->initializeModel();
}

OAIForecastsTypeCreate::~OAIForecastsTypeCreate() {}

void OAIForecastsTypeCreate::initializeModel() {

    m_name_forecasts_type_isSet = false;
    m_name_forecasts_type_isValid = false;
}

void OAIForecastsTypeCreate::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void OAIForecastsTypeCreate::fromJsonObject(QJsonObject json) {

    m_name_forecasts_type_isValid = ::OpenAPI::fromJsonValue(m_name_forecasts_type, json[QString("name_forecasts_type")]);
    m_name_forecasts_type_isSet = !json[QString("name_forecasts_type")].isNull() && m_name_forecasts_type_isValid;
}

QString OAIForecastsTypeCreate::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject OAIForecastsTypeCreate::asJsonObject() const {
    QJsonObject obj;
    if (m_name_forecasts_type_isSet) {
        obj.insert(QString("name_forecasts_type"), ::OpenAPI::toJsonValue(m_name_forecasts_type));
    }
    return obj;
}

QString OAIForecastsTypeCreate::getNameForecastsType() const {
    return m_name_forecasts_type;
}
void OAIForecastsTypeCreate::setNameForecastsType(const QString &name_forecasts_type) {
    m_name_forecasts_type = name_forecasts_type;
    m_name_forecasts_type_isSet = true;
}

bool OAIForecastsTypeCreate::is_name_forecasts_type_Set() const{
    return m_name_forecasts_type_isSet;
}

bool OAIForecastsTypeCreate::is_name_forecasts_type_Valid() const{
    return m_name_forecasts_type_isValid;
}

bool OAIForecastsTypeCreate::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_name_forecasts_type_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool OAIForecastsTypeCreate::isValid() const {
    // only required properties are required for the object to be considered valid
    return m_name_forecasts_type_isValid && true;
}

} // namespace OpenAPI
