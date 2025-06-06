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

#include "OAISalesHistory.h"

#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QObject>

#include "OAIHelpers.h"

namespace OpenAPI {

OAISalesHistory::OAISalesHistory(QString json) {
    this->initializeModel();
    this->fromJson(json);
}

OAISalesHistory::OAISalesHistory() {
    this->initializeModel();
}

OAISalesHistory::~OAISalesHistory() {}

void OAISalesHistory::initializeModel() {

    m_record_id_isSet = false;
    m_record_id_isValid = false;

    m_date_isSet = false;
    m_date_isValid = false;

    m_quantity_isSet = false;
    m_quantity_isValid = false;

    m_price_isSet = false;
    m_price_isValid = false;

    m_profit_isSet = false;
    m_profit_isValid = false;

    m_product_id_isSet = false;
    m_product_id_isValid = false;
}

void OAISalesHistory::fromJson(QString jsonString) {
    QByteArray array(jsonString.toStdString().c_str());
    QJsonDocument doc = QJsonDocument::fromJson(array);
    QJsonObject jsonObject = doc.object();
    this->fromJsonObject(jsonObject);
}

void OAISalesHistory::fromJsonObject(QJsonObject json) {

    m_record_id_isValid = ::OpenAPI::fromJsonValue(m_record_id, json[QString("record_id")]);
    m_record_id_isSet = !json[QString("record_id")].isNull() && m_record_id_isValid;

    m_date_isValid = ::OpenAPI::fromJsonValue(m_date, json[QString("date")]);
    m_date_isSet = !json[QString("date")].isNull() && m_date_isValid;

    m_quantity_isValid = ::OpenAPI::fromJsonValue(m_quantity, json[QString("quantity")]);
    m_quantity_isSet = !json[QString("quantity")].isNull() && m_quantity_isValid;

    m_price_isValid = ::OpenAPI::fromJsonValue(m_price, json[QString("price")]);
    m_price_isSet = !json[QString("price")].isNull() && m_price_isValid;

    m_profit_isValid = ::OpenAPI::fromJsonValue(m_profit, json[QString("profit")]);
    m_profit_isSet = !json[QString("profit")].isNull() && m_profit_isValid;

    m_product_id_isValid = ::OpenAPI::fromJsonValue(m_product_id, json[QString("product_id")]);
    m_product_id_isSet = !json[QString("product_id")].isNull() && m_product_id_isValid;
}

QString OAISalesHistory::asJson() const {
    QJsonObject obj = this->asJsonObject();
    QJsonDocument doc(obj);
    QByteArray bytes = doc.toJson();
    return QString(bytes);
}

QJsonObject OAISalesHistory::asJsonObject() const {
    QJsonObject obj;
    if (m_record_id_isSet) {
        obj.insert(QString("record_id"), ::OpenAPI::toJsonValue(m_record_id));
    }
    if (m_date_isSet) {
        obj.insert(QString("date"), ::OpenAPI::toJsonValue(m_date));
    }
    if (m_quantity_isSet) {
        obj.insert(QString("quantity"), ::OpenAPI::toJsonValue(m_quantity));
    }
    if (m_price_isSet) {
        obj.insert(QString("price"), ::OpenAPI::toJsonValue(m_price));
    }
    if (m_profit_isSet) {
        obj.insert(QString("profit"), ::OpenAPI::toJsonValue(m_profit));
    }
    if (m_product_id_isSet) {
        obj.insert(QString("product_id"), ::OpenAPI::toJsonValue(m_product_id));
    }
    return obj;
}

qint64 OAISalesHistory::getRecordId() const {
    return m_record_id;
}
void OAISalesHistory::setRecordId(const qint64 &record_id) {
    m_record_id = record_id;
    m_record_id_isSet = true;
}

bool OAISalesHistory::is_record_id_Set() const{
    return m_record_id_isSet;
}

bool OAISalesHistory::is_record_id_Valid() const{
    return m_record_id_isValid;
}

QDate OAISalesHistory::getDate() const {
    return m_date;
}
void OAISalesHistory::setDate(const QDate &date) {
    m_date = date;
    m_date_isSet = true;
}

bool OAISalesHistory::is_date_Set() const{
    return m_date_isSet;
}

bool OAISalesHistory::is_date_Valid() const{
    return m_date_isValid;
}

double OAISalesHistory::getQuantity() const {
    return m_quantity;
}
void OAISalesHistory::setQuantity(const double &quantity) {
    m_quantity = quantity;
    m_quantity_isSet = true;
}

bool OAISalesHistory::is_quantity_Set() const{
    return m_quantity_isSet;
}

bool OAISalesHistory::is_quantity_Valid() const{
    return m_quantity_isValid;
}

double OAISalesHistory::getPrice() const {
    return m_price;
}
void OAISalesHistory::setPrice(const double &price) {
    m_price = price;
    m_price_isSet = true;
}

bool OAISalesHistory::is_price_Set() const{
    return m_price_isSet;
}

bool OAISalesHistory::is_price_Valid() const{
    return m_price_isValid;
}

double OAISalesHistory::getProfit() const {
    return m_profit;
}
void OAISalesHistory::setProfit(const double &profit) {
    m_profit = profit;
    m_profit_isSet = true;
}

bool OAISalesHistory::is_profit_Set() const{
    return m_profit_isSet;
}

bool OAISalesHistory::is_profit_Valid() const{
    return m_profit_isValid;
}

qint64 OAISalesHistory::getProductId() const {
    return m_product_id;
}
void OAISalesHistory::setProductId(const qint64 &product_id) {
    m_product_id = product_id;
    m_product_id_isSet = true;
}

bool OAISalesHistory::is_product_id_Set() const{
    return m_product_id_isSet;
}

bool OAISalesHistory::is_product_id_Valid() const{
    return m_product_id_isValid;
}

bool OAISalesHistory::isSet() const {
    bool isObjectUpdated = false;
    do {
        if (m_record_id_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_date_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_quantity_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_price_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_profit_isSet) {
            isObjectUpdated = true;
            break;
        }

        if (m_product_id_isSet) {
            isObjectUpdated = true;
            break;
        }
    } while (false);
    return isObjectUpdated;
}

bool OAISalesHistory::isValid() const {
    // only required properties are required for the object to be considered valid
    return m_record_id_isValid && m_date_isValid && m_quantity_isValid && m_price_isValid && m_profit_isValid && true;
}

} // namespace OpenAPI
