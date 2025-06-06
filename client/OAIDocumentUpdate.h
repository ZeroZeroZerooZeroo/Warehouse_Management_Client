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
 * OAIDocumentUpdate.h
 *
 * 
 */

#ifndef OAIDocumentUpdate_H
#define OAIDocumentUpdate_H

#include <QJsonObject>

#include <QString>

#include "OAIEnum.h"
#include "OAIObject.h"

namespace OpenAPI {

class OAIDocumentUpdate : public OAIObject {
public:
    OAIDocumentUpdate();
    OAIDocumentUpdate(QString json);
    ~OAIDocumentUpdate() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    QString getDocumentNumber() const;
    void setDocumentNumber(const QString &document_number);
    bool is_document_number_Set() const;
    bool is_document_number_Valid() const;

    QString getStatus() const;
    void setStatus(const QString &status);
    bool is_status_Set() const;
    bool is_status_Valid() const;

    QString getComments() const;
    void setComments(const QString &comments);
    bool is_comments_Set() const;
    bool is_comments_Valid() const;

    qint64 getCustomerId() const;
    void setCustomerId(const qint64 &customer_id);
    bool is_customer_id_Set() const;
    bool is_customer_id_Valid() const;

    qint64 getItemId() const;
    void setItemId(const qint64 &item_id);
    bool is_item_id_Set() const;
    bool is_item_id_Valid() const;

    qint64 getMovementId() const;
    void setMovementId(const qint64 &movement_id);
    bool is_movement_id_Set() const;
    bool is_movement_id_Valid() const;

    qint64 getMovementTypeId() const;
    void setMovementTypeId(const qint64 &movement_type_id);
    bool is_movement_type_id_Set() const;
    bool is_movement_type_id_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    QString m_document_number;
    bool m_document_number_isSet;
    bool m_document_number_isValid;

    QString m_status;
    bool m_status_isSet;
    bool m_status_isValid;

    QString m_comments;
    bool m_comments_isSet;
    bool m_comments_isValid;

    qint64 m_customer_id;
    bool m_customer_id_isSet;
    bool m_customer_id_isValid;

    qint64 m_item_id;
    bool m_item_id_isSet;
    bool m_item_id_isValid;

    qint64 m_movement_id;
    bool m_movement_id_isSet;
    bool m_movement_id_isValid;

    qint64 m_movement_type_id;
    bool m_movement_type_id_isSet;
    bool m_movement_type_id_isValid;
};

} // namespace OpenAPI

Q_DECLARE_METATYPE(OpenAPI::OAIDocumentUpdate)

#endif // OAIDocumentUpdate_H
