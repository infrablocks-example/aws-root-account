module "bill_payment_management_policy" {
  source  = "infrablocks/billing-policy/aws"
  version = "0.3.0"

  policy_name = "bill-payment-management"
  policy_description = "A policy to allow management of bill payments for the account."

  allow_account_management = "no"
  allow_billing_management = "yes"
  allow_payment_method_management = "yes"
  allow_budget_management = "no"
  allow_cost_and_usage_report_management = "no"
}

module "bill_reporting_policy" {
  source  = "infrablocks/billing-policy/aws"
  version = "0.3.0"

  policy_name = "bill-reporting"
  policy_description = "A policy to allow reporting on billing for the account."

  allow_account_management = "no"
  allow_billing_management = "no"
  allow_payment_method_management = "no"
  allow_budget_management = "yes"
  allow_cost_and_usage_report_management = "yes"
}
