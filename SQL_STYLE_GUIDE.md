# SQL Style Guide & Naming Conventions
## dbt_olist_project Production Standards

This document establishes the SQL coding standards and naming conventions for our dbt project. These standards ensure code consistency, readability, and maintainability across the team.

---

## 📋 **TABLE OF CONTENTS**
- [General Principles](#general-principles)
- [Naming Conventions](#naming-conventions)
- [SQL Formatting Standards](#sql-formatting-standards)
- [dbt-Specific Standards](#dbt-specific-standards)
- [Model Organization](#model-organization)
- [Documentation Requirements](#documentation-requirements)

---

## 🎯 **GENERAL PRINCIPLES**

### Code Quality Standards
1. **Readability First**: Code should be self-documenting and easy to understand
2. **Consistency**: Follow established patterns throughout the project
3. **Maintainability**: Write code that's easy to modify and extend
4. **Performance**: Consider query performance in all SQL design decisions
5. **Documentation**: Every model and column should have clear descriptions

### Style Philosophy
- **Lowercase everything**: Keywords, functions, table names, column names
- **Explicit over implicit**: Always be clear about what the code does
- **Leading commas**: Use leading commas for better diffs and readability
- **Meaningful names**: Use descriptive names that explain business purpose

---

## 🏷️ **NAMING CONVENTIONS**

### Model Naming Patterns

#### Staging Models (`models/staging/`)
```sql
-- Pattern: stg_{source_system}_{entity}
stg_ecommerce_orders.sql
stg_ecommerce_customers.sql
stg_marketing_campaigns.sql
stg_payments_transactions.sql
```

#### Intermediate Models (`models/intermediate/`)
```sql
-- Pattern: int_{entity}_{business_logic}
int_orders_with_payments.sql
int_customers_with_metrics.sql
int_products_with_categories.sql
int_order_items_enriched.sql
```

#### Fact Tables (`models/marts/`)
```sql
-- Pattern: fct_{business_process}
fct_orders.sql
fct_order_items.sql
fct_payments.sql
fct_customer_transactions.sql
```

#### Dimension Tables (`models/marts/`)
```sql
-- Pattern: dim_{entity}
dim_customers.sql
dim_products.sql
dim_dates.sql
dim_sellers.sql
```

### Column Naming Standards

#### Primary Keys
```sql
-- Pattern: {table_name}_id (or entity_id for dimensions)
order_id
customer_id
product_id
seller_id
```

#### Foreign Keys
```sql
-- Pattern: {referenced_table}_id
customer_id  -- references dim_customers
product_id   -- references dim_products
order_id     -- references fct_orders
```

#### Timestamp Columns
```sql
-- Standard timestamp names
created_at
updated_at
deleted_at
order_date
payment_date
shipped_date
```

#### Boolean Columns
```sql
-- Pattern: is_{condition} or has_{condition}
is_active
is_deleted
has_discount
is_premium_customer
```

#### Calculated Fields
```sql
-- Be descriptive about calculations
total_order_value
profit_margin_percent
days_since_last_order
customer_lifetime_value
```

#### Categorical Fields
```sql
-- Use clear, business-friendly names
order_status          -- 'pending', 'shipped', 'delivered', 'cancelled'
payment_method        -- 'credit_card', 'debit_card', 'boleto', 'voucher'
customer_segment      -- 'new', 'returning', 'vip', 'churned'
product_category      -- 'electronics', 'fashion', 'home_garden'
```

---

## 🎨 **SQL FORMATTING STANDARDS**

### General Formatting Rules

#### Indentation and Spacing
```sql
-- Use 4 spaces for indentation, no tabs
-- Add blank lines to separate logical sections
select
    customer_id
    , customer_name
    , customer_email
    , created_at

from {{ ref('stg_ecommerce_customers') }}

where is_active = true
    and created_at >= '2023-01-01'
```

#### Leading Commas
```sql
-- Use leading commas for better version control diffs
select
    order_id
    , customer_id
    , order_date
    , total_amount
    , case
        when total_amount > 100 then 'high_value'
        when total_amount > 50 then 'medium_value'
        else 'low_value'
      end as order_value_category

from {{ ref('stg_ecommerce_orders') }}
```

#### Keywords and Functions
```sql
-- All SQL keywords and functions in lowercase
select distinct
    lower(customer_email) as customer_email
    , upper(state_code) as state_code
    , coalesce(phone_number, 'unknown') as phone_number
    , extract(year from created_at) as created_year

from {{ ref('stg_ecommerce_customers') }}

where customer_email is not null
    and created_at between '2023-01-01' and '2023-12-31'

order by created_at desc
```

#### Complex Queries Structure
```sql
-- Structure complex queries with CTEs for readability
with order_metrics as (

    select
        order_id
        , customer_id
        , order_date
        , sum(item_price * quantity) as total_order_value
        , count(distinct product_id) as unique_products

    from {{ ref('stg_ecommerce_order_items') }}

    group by 1, 2, 3

), customer_summary as (

    select
        customer_id
        , count(distinct order_id) as total_orders
        , sum(total_order_value) as lifetime_value
        , avg(total_order_value) as avg_order_value
        , min(order_date) as first_order_date
        , max(order_date) as last_order_date

    from order_metrics

    group by 1

)

select
    c.customer_id
    , c.total_orders
    , c.lifetime_value
    , c.avg_order_value
    , c.first_order_date
    , c.last_order_date
    , case
        when c.total_orders >= 10 then 'loyal'
        when c.total_orders >= 5 then 'repeat'
        when c.total_orders >= 2 then 'multi_purchase'
        else 'single_purchase'
      end as customer_segment

from customer_summary c

where c.total_orders > 0

order by c.lifetime_value desc
```

---

## 🔧 **DBT-SPECIFIC STANDARDS**

### Model Configuration
```sql
-- Model configuration at the top of each file
{{ config(
    materialized='table',
    unique_key='order_id',
    indexes=[
        {'columns': ['customer_id'], 'type': 'btree'},
        {'columns': ['order_date'], 'type': 'btree'}
    ],
    pre_hook="grant select on {{ this }} to role reporter",
    post_hook="analyze {{ this }}"
) }}
```

### Jinja and Macros
```sql
-- Use descriptive variable names in Jinja
{% set payment_methods = ['credit_card', 'debit_card', 'boleto', 'voucher'] %}

select
    order_id
    , customer_id
    {% for method in payment_methods %}
    , sum(case when payment_method = '{{ method }}' then payment_value else 0 end) as {{ method }}_amount
    {% endfor %}

from {{ ref('stg_payments_transactions') }}

group by 1, 2
```

### Source and Reference Usage
```sql
-- Always use ref() for models and source() for raw data
-- Be explicit about schema and table names in sources
select
    o.order_id
    , o.customer_id
    , c.customer_name
    , p.payment_value

from {{ ref('stg_ecommerce_orders') }} o

left join {{ ref('dim_customers') }} c
    on o.customer_id = c.customer_id

left join {{ source('raw_payments', 'transactions') }} p
    on o.order_id = p.order_id
```

---

## 📁 **MODEL ORGANIZATION**

### Folder Structure Standards
```
models/
├── staging/
│   ├── ecommerce/
│   │   ├── _ecommerce_sources.yml
│   │   ├── stg_ecommerce_orders.sql
│   │   ├── stg_ecommerce_customers.sql
│   │   └── stg_ecommerce_order_items.sql
│   ├── payments/
│   │   ├── _payments_sources.yml
│   │   └── stg_payments_transactions.sql
│   └── marketing/
│       ├── _marketing_sources.yml
│       └── stg_marketing_campaigns.sql
├── intermediate/
│   ├── int_orders_with_payments.sql
│   ├── int_customers_with_metrics.sql
│   └── int_products_with_categories.sql
└── marts/
    ├── core/
    │   ├── _core_models.yml
    │   ├── fct_orders.sql
    │   ├── fct_order_items.sql
    │   ├── dim_customers.sql
    │   └── dim_products.sql
    └── analytics/
        ├── _analytics_models.yml
        ├── customer_lifetime_value.sql
        └── monthly_revenue_summary.sql
```

### File Naming Patterns
- **One model per file**: Each SQL file should contain exactly one model
- **Descriptive names**: File names should clearly indicate the model's purpose
- **Schema files**: Use `_schema.yml` or `_{domain}_models.yml` for documentation

---

## 📚 **DOCUMENTATION REQUIREMENTS**

### Model Documentation
```yaml
# Every model must have a description and column documentation
models:
  - name: fct_orders
    description: >
      Fact table containing one record per order with key business metrics.
      Includes order totals, dates, status, and customer information.
      Updated daily via incremental load from source systems.

    columns:
      - name: order_id
        description: Unique identifier for each order
        tests:
          - unique
          - not_null

      - name: customer_id
        description: Foreign key to dim_customers table
        tests:
          - not_null
          - relationships:
              to: ref('dim_customers')
              field: customer_id

      - name: order_date
        description: Date the order was placed (YYYY-MM-DD format)
        tests:
          - not_null

      - name: total_order_value
        description: Total value of the order in local currency
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 100000
```

### Column Description Standards
- **Clear and concise**: Explain what the column contains in business terms
- **Include units**: Specify currency, date formats, measurement units
- **Business context**: Explain how the field is used in business processes
- **Data lineage**: Note if calculated or derived from other fields

---

## ✅ **ENFORCEMENT & VALIDATION**

### Automated Checks
Our pre-commit hooks enforce these standards:
- **SQLFluff**: Validates SQL formatting and style
- **dbt-checkpoint**: Ensures documentation and testing requirements
- **YAML validation**: Checks schema file syntax

### Code Review Checklist
- [ ] Follows naming conventions for models and columns
- [ ] Uses leading commas and proper indentation
- [ ] All models have descriptions
- [ ] Key columns have appropriate tests
- [ ] SQL is optimized for performance
- [ ] Business logic is clear and documented

### Style Guide Compliance
- Run `sqlfluff lint` before committing
- Ensure all pre-commit hooks pass
- Include meaningful commit messages
- Document any deviations with business justification

---

## 🔗 **RESOURCES**

### Reference Materials
- [dbt Style Guide](https://docs.getdbt.com/guides/best-practices/how-we-style/0-how-we-style-our-dbt-projects)
- [Brooklyn Data Co SQL Style Guide](https://github.com/brooklyn-data/co/blob/main/sql_style_guide.md)
- [SQLFluff Documentation](https://docs.sqlfluff.com/)
- [Snowflake SQL Reference](https://docs.snowflake.com/en/sql-reference)

### Tools
- **SQLFluff**: Automated SQL linting and formatting
- **dbt-checkpoint**: dbt-specific code quality checks
- **VS Code dbt Power User**: IDE integration for dbt development
- **Pre-commit**: Automated code quality enforcement

---

*This style guide is a living document. Team members should propose updates through pull requests with clear justification for changes.*
