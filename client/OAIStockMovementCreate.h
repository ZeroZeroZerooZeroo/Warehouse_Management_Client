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
 * OAIStockMovementCreate.h
 *
 * 
 */

#ifndef OAIStockMovementCreate_H
#define OAIStockMovementCreate_H

#include <QJsonObject>

#include <QString>

#include "OAIEnum.h"
#include "OAIObject.h"

namespace OpenAPI {

class OAIStockMovementCreate : public OAIObject {
public:
    OAIStockMovementCreate();
    OAIStockMovementCreate(QString json);
    ~OAIStockMovementCreate() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    qint64 getMovementTypeId() const;
    void setMovementTypeId(const qint64 &movement_type_id);
    bool is_movement_type_id_Set() const;
    bool is_movement_type_id_Valid() const;

    double getQuantity() const;
    void setQuantity(const double &quantity);
    bool is_quantity_Set() const;
    bool is_quantity_Valid() const;

    QString getMovementType() const;
    void setMovementType(const QString &movement_type);
    bool is_movement_type_Set() const;
    bool is_movement_type_Valid() const;

    double getCost() const;
    void setCost(const double &cost);
    bool is_cost_Set() const;
    bool is_cost_Valid() const;

    QString getComments() const;
    void setComments(const QString &comments);
    bool is_comments_Set() const;
    bool is_comments_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    qint64 m_movement_type_id;
    bool m_movement_type_id_isSet;
    bool m_movement_type_id_isValid;

    double m_quantity;
    bool m_quantity_isSet;
    bool m_quantity_isValid;

    QString m_movement_type;
    bool m_movement_type_isSet;
    bool m_movement_type_isValid;

    double m_cost;
    bool m_cost_isSet;
    bool m_cost_isValid;

    QString m_comments;
    bool m_comments_isSet;
    bool m_comments_isValid;
};

} // namespace OpenAPI

Q_DECLARE_METATYPE(OpenAPI::OAIStockMovementCreate)

#endif // OAIStockMovementCreate_H
