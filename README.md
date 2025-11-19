# Data-modal-Learn

Data-Modal Learning.

for diagram -
%% === Entities (PK fields marked) ===
PARTY {
string partyId PK
string partyTypeId
string statusId
}
PERSON {
string partyId PK FK "→ PARTY"
string firstName
string lastName
}
USERLOGIN {
string userLoginId PK
string partyId FK "→ PARTY"
string enabled
}
PRODUCT {
string productId PK
string productTypeId FK
string productName
string productStoreId FK
}
PRODUCT_TYPE {
string productTypeId PK
string description
}
CATALOG {
string catalogId PK
string catalogName
}
CATEGORY {
string categoryId PK
string parentCategoryId FK
string categoryName
}
BRAND {
string brandId PK
string brandName
}
PRODUCT_CATEGORY {
string productId PK FK
string categoryId PK FK
}

FACILITY {
string facilityId PK
string facilityTypeId FK
string ownerPartyId FK
string productStoreId FK
string primaryFacilityGroupId FK
string defaultWeightUomId FK
}
FACILITY_TYPE {
string facilityTypeId PK
}
FACILITY_GROUP {
string facilityGroupId PK
}
PRODUCT_STORE {
string productStoreId PK
string storeName
}
FACILITY_LOCATION {
string facilityId PK "composite"
string locationSeqId PK "composite"
string locationTypeEnumId FK
string aisleId
string sectionId
string positionId
}

INVENTORYITEM {
string inventoryItemId PK
string productId FK
string facilityId FK
decimal quantityOnHandTotal
}
INVENTORYITEMDETAIL {
string inventoryItemId PK "composite"
int inventoryItemDetailSeqId PK "composite"
decimal quantityOnHandDiff
datetime inventoryDate
string reasonEnumId FK
}
INVENTORY_ITEM_TYPE {
string inventoryItemTypeId PK
}
UOM {
string uomId PK
}

ORDERHEADER {
string orderId PK
string partyId FK
string orderTypeId FK
string statusId FK
date orderDate
}
ORDERTYPE {
string orderTypeId PK
}
ORDERITEM {
string orderId PK "composite"
int orderItemSeqId PK "composite"
string productId FK
decimal quantity
string statusId FK
}
ORDER_ITEM_SHIP_GROUP {
string orderId PK "composite"
int shipGroupSeqId PK "composite"
}

SHIPMENT {
string shipmentId PK
string shipmentTypeId FK
string shipmentMethodTypeId FK
string facilityIdFrom FK
string facilityIdTo FK
date shipmentDate
}
SHIPMENTITEM {
string shipmentId PK "composite"
int shipmentItemSeqId PK "composite"
string inventoryItemId FK
string productId FK
decimal quantity
}
SHIPMENT_TYPE {
string shipmentTypeId PK
}
SHIPMENT_METHOD_TYPE {
string shipmentMethodTypeId PK
}

PAYMENT_METHOD_TYPE {
string paymentMethodTypeId PK
}
PAYMENT_METHOD {
string paymentMethodId PK
string paymentMethodTypeId FK
string partyId FK
}
ORDER_PAYMENT_PREFERENCE {
string orderPaymentPreferenceId PK
string orderId FK
string paymentMethodId FK
}

ENUMERATION_TYPE {
string enumTypeId PK
}
ENUMERATION {
string enumId PK
string enumTypeId FK
string description
}

%% === Relationships with plain English labels ===
PARTY ||--o{ ORDERHEADER : "Customer places order"
ORDERHEADER ||--o{ ORDERITEM : "Order contains item"
ORDERITEM }o--|| PRODUCT : "Item refers to a product"
PRODUCT ||--o{ INVENTORYITEM : "Product stored as inventory"
FACILITY ||--o{ INVENTORYITEM : "Facility stores inventory"
INVENTORYITEM ||--o{ INVENTORYITEMDETAIL : "Inventory records changes"
FACILITY ||--o{ FACILITY_LOCATION : "Facility has locations (aisles/shelves)"
SHIPMENT ||--o{ SHIPMENTITEM : "Shipment contains items"
SHIPMENTITEM }o--|| INVENTORYITEM : "Shipment moves inventory item"
ORDERITEM ||--o{ SHIPMENTITEM : "Order item fulfilled by shipment item"
SHIPMENT }o--|| FACILITY : "Shipment moves from/to facilities"
ORDERHEADER ||--o{ ORDER_PAYMENT_PREFERENCE : "Order uses a payment method"
PAYMENT_METHOD ||--o{ ORDER_PAYMENT_PREFERENCE : "Payment method used for order"
PARTY ||--o{ PAYMENT_METHOD : "Customer has payment methods"
ENUMERATION_TYPE ||--o{ ENUMERATION : "Lists of statuses/reasons"
