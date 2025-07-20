# Documentation Standards
## dbt_olist_project Model & Column Documentation

This document establishes comprehensive documentation requirements for all dbt models, ensuring consistency, clarity, and business value communication.

---

## 📋 **DOCUMENTATION REQUIREMENTS**

### Model Documentation Template
Every model must include:
1. **Model Description**: Clear business purpose and context
2. **Column Descriptions**: Business meaning for every column
3. **Meta Information**: Owner, maturity level, update frequency
4. **Test Coverage**: Appropriate data quality tests
5. **Business Logic**: Complex transformations explained

---

## 🎯 **MODEL DESCRIPTION STANDARDS**

### Required Elements
```yaml
models:
  - name: fct_orders
    description: |
      **Business Purpose**: Central fact table containing one record per customer order

      **Data Scope**: All orders from the Olist e-commerce platform since 2016

      **Update Frequency**: Daily incremental load at 6 AM UTC

      **Business Rules**:
      - Only includes orders with 'delivered' or 'shipped' status
      - Order totals include product price + freight value + any applicable taxes
      - Cancelled orders are excluded from this model

      **Key Business Questions Answered**:
      - What is our daily/monthly revenue trend?
      - Which customers are our highest value?
      - What's the average order value by region?

      **Data Quality Notes**:
      - Primary key: order_id (unique across all time)
      - Foreign keys validated against dim_customers and dim_products
      - All monetary values in Brazilian Real (BRL)
```

### Description Content Guidelines
- **Start with business purpose**: Why does this model exist?
- **Explain scope and filters**: What data is included/excluded?
- **Document business rules**: How are calculations performed?
- **Note data freshness**: When is it updated?
- **Include business context**: How is it used in decision-making?

---

## 📊 **COLUMN DOCUMENTATION STANDARDS**

### Documentation Block Strategy
**Best Practice**: Use `{{ doc() }}` blocks for reusable column descriptions to maintain consistency across models.

#### Benefits of `{{ doc() }}` blocks:
- **Consistency**: Same description for the same concept across all models
- **Maintainability**: Update once, apply everywhere
- **DRY Principle**: Don't repeat yourself in documentation
- **Team Efficiency**: Shared vocabulary and definitions

#### Documentation Block Location
```
models/
├── docs/
│   └── column_descriptions.md   # All {{ doc() }} blocks defined here
├── staging/
│   └── _models.yml             # References {{ doc() }} blocks
└── marts/
    └── _models.yml             # References {{ doc() }} blocks
```

### Standard Column Descriptions

#### Primary Keys
```yaml
- name: order_id
  description: "{{ doc('order_id_pk') }}"
  tests:
    - unique
    - not_null
```

#### Foreign Keys
```yaml
- name: customer_id
  description: "{{ doc('customer_id_fk') }}"
  tests:
    - not_null
    - relationships:
        to: ref('dim_customers')
        field: customer_id
```

#### Reusable Business Concepts
```yaml
# Use doc blocks for concepts that appear across models
- name: order_status_category
  description: "{{ doc('order_status_category') }}"

- name: is_order_completed
  description: "{{ doc('is_order_completed') }}"
```

#### Model-Specific Descriptions
```yaml
# Use inline descriptions for model-specific derived fields
- name: model_specific_calculation
  description: |
    Complex calculation specific to this model only.
    Formula: (field_a * field_b) / field_c
    Used only in this particular business context.
```
  tests:
    - not_null
    - relationships:
        to: ref('dim_customers')
        field: customer_id
```

#### Timestamp Columns
```yaml
- name: order_purchase_timestamp
  description: |
    Exact timestamp when customer completed the purchase (UTC timezone).
    Used for trend analysis, seasonality studies, and operational reporting.
    Format: YYYY-MM-DD HH:MM:SS
  tests:
    - not_null
    - dbt_utils.accepted_range:
        min_value: '2016-01-01'
        max_value: '{{ var("max_order_date") }}'
```

#### Business Metrics
```yaml
- name: total_order_value
  description: |
    Total monetary value of the order in Brazilian Real (BRL).
    Calculated as: sum(item_price * quantity) + freight_value + any_taxes.
    Excludes cancelled items. Used for revenue reporting and customer LTV calculations.
  tests:
    - not_null
    - dbt_utils.accepted_range:
        min_value: 0
        max_value: 50000
```

#### Categorical Fields
```yaml
- name: order_status
  description: |
    Current status of the order in the fulfillment process.
    Values: 'delivered', 'shipped', 'processing', 'cancelled', 'created'
    Business Logic: Only 'delivered' and 'shipped' orders included in revenue metrics
  tests:
    - not_null
    - accepted_values:
        values: ['delivered', 'shipped', 'processing', 'cancelled', 'created']
```

#### Derived/Calculated Fields
```yaml
- name: days_to_delivery
  description: |
    Number of calendar days from order purchase to customer delivery.
    Calculated as: order_delivered_customer_date - order_purchase_timestamp.
    NULL for orders not yet delivered. Used for logistics performance analysis.
  tests:
    - dbt_utils.accepted_range:
        min_value: 0
        max_value: 180
        where: "order_status = 'delivered'"
```

---

## 🏷️ **META INFORMATION REQUIREMENTS**

### Required Meta Fields
```yaml
models:
  - name: fct_orders
    description: "Fact table for customer orders..."
    meta:
      owner: "data-team@company.com"
      maturity: "high"              # high, medium, low, experimental
      update_frequency: "daily"     # real-time, hourly, daily, weekly, monthly
      business_domain: "sales"      # sales, marketing, finance, operations
      data_classification: "internal"  # public, internal, confidential, restricted

    columns:
      - name: customer_id
        meta:
          business_definition: "Customer identifier for cross-platform analytics"
          data_steward: "sales-operations@company.com"
          pii_category: "identifier"  # identifier, quasi-identifier, sensitive, none
```

### Meta Field Definitions
- **Owner**: Team/person responsible for model maintenance
- **Maturity**: Production readiness level
  - `high`: Production-ready, stable, well-tested
  - `medium`: Production-ready, some known limitations
  - `low`: Development/testing, not for critical decisions
  - `experimental`: Early development, may break
- **Update Frequency**: How often data is refreshed
- **Business Domain**: Primary business area served
- **Data Classification**: Security/privacy level

---

## 🧪 **TESTING DOCUMENTATION**

### Test Documentation Standards
```yaml
models:
  - name: fct_orders
    tests:
      - dbt_utils.unique_combination_of_columns:
          combination_of_columns:
            - order_id
            - order_item_id
          config:
            meta:
              description: "Each order item should appear only once per order"
              business_rule: "Prevents double-counting of revenue"

    columns:
      - name: profit_margin_percent
        tests:
          - dbt_utils.accepted_range:
              min_value: -100
              max_value: 500
              config:
                meta:
                  description: "Profit margins should be within reasonable business range"
                  business_rule: "Negative margins allowed for promotional items up to -100%"
```

### Custom Test Documentation
```sql
-- tests/assert_order_totals_match_items.sql
/*
Test: Order totals should equal sum of order items
Business Rule: Order.total_value = sum(OrderItems.item_price * quantity) + freight
Data Quality Impact: Ensures revenue reporting accuracy
Frequency: Run on every dbt model execution
Owner: finance-team@company.com
*/

select
    order_id
    , total_order_value as order_total
    , calculated_total
    , abs(total_order_value - calculated_total) as difference

from (
    select
        o.order_id
        , o.total_order_value
        , sum(oi.item_price * oi.quantity) + o.freight_value as calculated_total
    from {{ ref('fct_orders') }} o
    left join {{ ref('fct_order_items') }} oi using (order_id)
    group by 1, 2, o.freight_value
)

where abs(total_order_value - calculated_total) > 0.01
```

---

## 📁 **SCHEMA FILE ORGANIZATION**

### Folder-Level Schema Files
```yaml
# models/staging/ecommerce/_ecommerce_sources.yml
version: 2

sources:
  - name: ecommerce_raw
    description: |
      Raw e-commerce data from the Olist platform operational database.
      Data is extracted nightly via CDC and loaded to Snowflake.

    meta:
      owner: "data-engineering@company.com"
      extraction_method: "CDC via Fivetran"
      source_system: "Olist PostgreSQL Database"

    tables:
      - name: orders
        description: |
          Core order information including customer, dates, and status.
          One row per order placed on the platform.

        freshness:
          warn_after: {count: 2, period: day}
          error_after: {count: 3, period: day}

        columns:
          - name: order_id
            description: "Primary key, unique order identifier"
            tests:
              - unique
              - not_null
```

### Model-Level Schema Files
```yaml
# models/marts/core/_core_models.yml
version: 2

models:
  - name: fct_orders
    description: "Central fact table for order analytics..."

  - name: dim_customers
    description: "Customer dimension with demographics..."

  - name: dim_products
    description: "Product dimension with category information..."
```

---

## 📖 **BUSINESS GLOSSARY INTEGRATION**

### Business Term Definitions
```yaml
# Include business term definitions in model documentation
models:
  - name: fct_orders
    description: |
      **Business Terms Used**:

      - **Order Value**: Total amount customer paid including taxes and shipping
      - **Delivery Date**: Date package was delivered to customer address
      - **Processing Time**: Business days from order to shipment
      - **Customer Segment**: Classification based on purchase behavior (new/returning/vip)

      **Related Dashboards**:
      - Executive Revenue Dashboard: {{ var('dashboard_base_url') }}/executive
      - Operations Daily Report: {{ var('dashboard_base_url') }}/operations

      **Key Stakeholders**:
      - Sales Team: Uses for revenue tracking and goal monitoring
      - Operations: Uses for fulfillment performance analysis
      - Finance: Uses for revenue recognition and reporting
```

---

## ✅ **DOCUMENTATION QUALITY CHECKLIST**

### Before Committing
- [ ] Every model has a clear business description
- [ ] All columns have meaningful descriptions
- [ ] Meta information is complete and accurate
- [ ] Business rules and calculations are explained
- [ ] Test coverage is documented and justified
- [ ] Stakeholder context is provided

### Review Standards
- [ ] Documentation is written for business users, not just technical
- [ ] No jargon without explanation
- [ ] Examples provided for complex calculations
- [ ] Links to related resources included
- [ ] Contact information for questions provided

---

## 🔗 **AUTOMATION & MAINTENANCE**

### Automated Documentation Checks
Our pre-commit hooks enforce:
- Every model must have a description
- Every column must have a description
- Required meta fields must be present
- Test coverage must meet minimum thresholds

### Documentation Maintenance
- **Quarterly Reviews**: Update descriptions for accuracy
- **Change Management**: Update docs when business logic changes
- **Stakeholder Feedback**: Regular review sessions with business users
- **Template Updates**: Evolve standards based on team learnings

---

*Documentation is not just about compliance—it's about enabling self-service analytics and building stakeholder confidence in our data.*
