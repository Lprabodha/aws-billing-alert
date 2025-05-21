provider "aws" {
  region = "us-east-1"
}

resource "aws_sns_topic" "billing_alert" {
  name = "billing-alert-topic"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.billing_alert.arn
  protocol  = "email"
  endpoint  = var.email_address
}

resource "aws_budgets_budget" "monthly_billing_alert" {
  name         = "MonthlyBudget"
  budget_type  = "COST"
  limit_amount = "200"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold           = 100.0
    threshold_type      = "PERCENTAGE"

    subscriber {
      address           = aws_sns_topic.billing_alert.arn
      subscription_type = "SNS"
    }
  }
}
