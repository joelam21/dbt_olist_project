# Pull Request Template
## dbt_olist_project Code Review Checklist

### 📋 **PULL REQUEST OVERVIEW**

#### What does this PR do?
<!-- Provide a clear, concise description of the changes -->

#### Type of Change
- [ ] 🆕 New model/feature
- [ ] 🐛 Bug fix
- [ ] 📚 Documentation update
- [ ] 🎨 Code refactoring
- [ ] ⚡ Performance improvement
- [ ] 🧪 Test addition/modification
- [ ] 🔧 Configuration change

#### Related Issues
<!-- Link to any related GitHub issues -->
Closes #
Fixes #
Related to #

---

### 🎯 **BUSINESS CONTEXT**

#### Business Impact
<!-- Explain the business value and impact of these changes -->

#### Stakeholders
<!-- Who requested this change? Who will be affected? -->

#### Data Dependencies
<!-- What upstream data sources or models does this depend on? -->

---

### 🔧 **TECHNICAL DETAILS**

#### Models Changed/Added
<!-- List all models that were modified or created -->

- [ ] `staging/` models
- [ ] `intermediate/` models
- [ ] `marts/` models
- [ ] `snapshots/` models
- [ ] `macros/` functions
- [ ] `tests/` custom tests

#### Performance Considerations
<!-- Any performance implications? Query optimization? -->

#### Breaking Changes
<!-- Will this break existing downstream dependencies? -->

---

### ✅ **CODE QUALITY CHECKLIST**

#### SQL Style & Standards
- [ ] Follows [SQL Style Guide](SQL_STYLE_GUIDE.md) conventions
- [ ] Uses consistent naming patterns (`stg_`, `int_`, `fct_`, `dim_`)
- [ ] Implements leading commas and proper indentation
- [ ] Uses lowercase for all SQL keywords and functions
- [ ] Optimized for readability and performance

#### dbt Best Practices
- [ ] Proper use of `ref()` and `source()` functions
- [ ] Appropriate materialization strategy selected
- [ ] Includes model configuration when needed
- [ ] Uses macros for reusable logic
- [ ] Follows proper folder organization

#### Documentation Requirements
- [ ] All new models have descriptions
- [ ] All columns have meaningful descriptions
- [ ] Business logic is clearly documented
- [ ] Source freshness configured where applicable
- [ ] Meta fields added (`owner`, `maturity`, etc.)

#### Testing Coverage
- [ ] Primary keys tested with `unique` and `not_null`
- [ ] Foreign key relationships validated
- [ ] Business logic tested with custom tests
- [ ] Data quality tests added where appropriate
- [ ] All tests pass locally

---

### 🧪 **TESTING & VALIDATION**

#### Local Testing Results
<!-- Paste results of local dbt run and test commands -->

```bash
# dbt run results
$ dbt run --select +model_name
# Add output here

# dbt test results
$ dbt test --select +model_name
# Add output here
```

#### Data Quality Validation
- [ ] Row counts match expected values
- [ ] No unexpected NULL values
- [ ] Business rules validated manually
- [ ] Data freshness within acceptable limits

#### Performance Testing
- [ ] Query execution time acceptable (<30 seconds for marts)
- [ ] No significant increase in warehouse compute costs
- [ ] Incremental models perform efficiently
- [ ] No unnecessary full table scans

---

### 📊 **DATA IMPACT ASSESSMENT**

#### Expected Row Counts
<!-- Document expected data volumes -->

| Model | Expected Rows | Actual Rows | Notes |
|-------|---------------|-------------|-------|
| `fct_orders` | ~100K | | |
| `dim_customers` | ~50K | | |

#### Data Quality Metrics
- [ ] No duplicate primary keys
- [ ] Foreign key integrity maintained
- [ ] Business totals reconcile with source
- [ ] Historical data preserved correctly

---

### 🚀 **DEPLOYMENT CHECKLIST**

#### Pre-Deployment Validation
- [ ] All pre-commit hooks pass
- [ ] `dbt compile` succeeds
- [ ] `dbt run` completes successfully
- [ ] `dbt test` passes all tests
- [ ] `dbt docs generate` creates documentation

#### Production Readiness
- [ ] Environment variables configured
- [ ] Appropriate permissions set
- [ ] Monitoring/alerting configured
- [ ] Rollback plan documented if needed

#### Communication Plan
- [ ] Stakeholders notified of changes
- [ ] Documentation updated in data catalog
- [ ] Downstream consumers informed
- [ ] Training materials updated if needed

---

### 👥 **REVIEWER GUIDELINES**

#### For Code Reviewers
Please ensure you've checked:

- [ ] **Business Logic**: Does the code solve the intended business problem?
- [ ] **Code Quality**: Follows style guide and dbt best practices?
- [ ] **Performance**: Are queries optimized and efficient?
- [ ] **Testing**: Adequate test coverage for new functionality?
- [ ] **Documentation**: Clear descriptions and business context?
- [ ] **Security**: No sensitive data exposed inappropriately?

#### Review Focus Areas
- [ ] SQL logic correctness
- [ ] Data model design appropriateness
- [ ] Error handling and edge cases
- [ ] Integration with existing models
- [ ] Future maintainability

---

### 📝 **ADDITIONAL NOTES**

#### Special Considerations
<!-- Any special deployment instructions or considerations? -->

#### Future Work
<!-- Any follow-up tasks or future improvements planned? -->

#### Questions for Reviewers
<!-- Specific questions or areas where you'd like feedback -->

---

### 🏁 **READY FOR REVIEW CHECKLIST**

Before requesting review, confirm:

- [ ] ✅ All automated checks pass (pre-commit hooks, CI/CD)
- [ ] ✅ Code follows established patterns and standards
- [ ] ✅ Tests provide adequate coverage and all pass
- [ ] ✅ Documentation is complete and accurate
- [ ] ✅ Performance impact is acceptable
- [ ] ✅ Business stakeholders are aligned on changes

---

**Review Assignment**: @data-team
**Priority**: `low` | `medium` | `high` | `urgent`
**Target Merge Date**: YYYY-MM-DD

<!--
💡 **Tips for Effective PRs:**
- Keep PRs focused and manageable in size
- Include relevant context and business justification
- Test thoroughly before requesting review
- Be responsive to feedback and questions
- Document any deviations from standards
-->
