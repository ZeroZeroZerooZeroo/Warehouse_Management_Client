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

/*
 * OAIWarehouse.h
 *
 * 
 */

#ifndef OAIWarehouse_H
#define OAIWarehouse_H

#include <QJsonObject>

#include <QDateTime>
#include <QString>

#include "OAIEnum.h"
#include "OAIObject.h"

namespace OpenAPI {

class OAIWarehouse : public OAIObject {
public:
    OAIWarehouse();
    OAIWarehouse(QString json);
    ~OAIWarehouse() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    qint64 getWarehouseId() const;
    void setWarehouseId(const qint64 &warehouse_id);
    bool is_warehouse_id_Set() const;
    bool is_warehouse_id_Valid() const;

    QString getName() const;
    void setName(const QString &name);
    bool is_name_Set() const;
    bool is_name_Valid() const;

    QString getAddress() const;
    void setAddress(const QString &address);
    bool is_address_Set() const;
    bool is_address_Valid() const;

    double getTotalCapacity() const;
    void setTotalCapacity(const double &total_capacity);
    bool is_total_capacity_Set() const;
    bool is_total_capacity_Valid() const;

    double getCurrentUtilization() const;
    void setCurrentUtilization(const double &current_utilization);
    bool is_current_utilization_Set() const;
    bool is_current_utilization_Valid() const;

    bool isStatus() const;
    void setStatus(const bool &status);
    bool is_status_Set() const;
    bool is_status_Valid() const;

    QDateTime getCreatedAt() const;
    void setCreatedAt(const QDateTime &created_at);
    bool is_created_at_Set() const;
    bool is_created_at_Valid() const;

    QDateTime getUpdatedAt() const;
    void setUpdatedAt(const QDateTime &updated_at);
    bool is_updated_at_Set() const;
    bool is_updated_at_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    qint64 m_warehouse_id;
    bool m_warehouse_id_isSet;
    bool m_warehouse_id_isValid;

    QString m_name;
    bool m_name_isSet;
    bool m_name_isValid;

    QString m_address;
    bool m_address_isSet;
    bool m_address_isValid;

    double m_total_capacity;
    bool m_total_capacity_isSet;
    bool m_total_capacity_isValid;

    double m_current_utilization;
    bool m_current_utilization_isSet;
    bool m_current_utilization_isValid;

    bool m_status;
    bool m_status_isSet;
    bool m_status_isValid;

    QDateTime m_created_at;
    bool m_created_at_isSet;
    bool m_created_at_isValid;

    QDateTime m_updated_at;
    bool m_updated_at_isSet;
    bool m_updated_at_isValid;
};

} // namespace OpenAPI

Q_DECLARE_METATYPE(OpenAPI::OAIWarehouse)

#endif // OAIWarehouse_H
