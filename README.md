# 💰 AWS Billing Alert Notification Setup

This project provides infrastructure-as-code using **Terraform** and **CloudFormation** to monitor your AWS billing. You’ll receive an **email alert** when your **monthly AWS charges exceed $200**.

---

## 📌 Features

- ✅ Budget alert threshold at **$200 USD**
- ✅ Sends **email notification** using Amazon SNS
- ✅ Infrastructure provisioned via **Terraform** or **CloudFormation**
- ✅ Fully customizable and reusable setup

---

## 🧰 Prerequisites

- AWS Account (with billing enabled)
- AWS CLI installed and configured
- Terraform installed (if using Terraform)
- Email address to receive alerts (must be confirmed)

---

## 🏗️ Project Structure

```
aws-billing-alert/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── README.md
├── cloudformation/
│   ├── billing-alert.yaml
│   └── README.md
├── LICENSE
├── .gitignore
└── README.md
```

---

## 🚀 Step-by-Step Guide

### 1️⃣ Set Up AWS Account

1. Sign up at [https://aws.amazon.com](https://aws.amazon.com)
2. Enable billing alerts:
   - Go to **Billing Console**
   - Click **Billing Preferences**
   - Check `Receive Billing Alerts`
3. Create an IAM user with **AdministratorAccess**
4. Save the **Access Key ID** and **Secret Access Key**

---

### 2️⃣ Install AWS CLI

```bash
# macOS/Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
```

---

### 3️⃣ Configure AWS CLI

```bash
aws configure
```

Provide:

- **Access Key ID**
- **Secret Access Key**
- **Default region:** `us-east-1` (billing alerts are only available here)
- **Output format:** `json`

---

## ⚙️ Terraform Deployment

**File:** `terraform/main.tf`

Creates:

- SNS Topic + Email Subscription
- AWS Budget with alert

#### 🔧 Setup

```bash
cd terraform
terraform init
terraform apply -var="email_address=you@example.com"
```

📧 **Confirm the subscription via email to receive alerts.**

---

## 🧱 CloudFormation Deployment

**File:** `cloudformation/billing-alert.yaml`

Sets up the same resources via CloudFormation.

#### 🔧 Setup via Console

1. Go to AWS CloudFormation
2. Click **Create Stack > With new resources**
3. Upload `billing-alert.yaml`
4. Update `you@example.com` in the file with your actual email
5. Follow the stack creation process

#### 🔧 Setup via CLI

```bash
aws cloudformation create-stack \
  --stack-name BillingAlertStack \
  --template-body file://cloudformation/billing-alert.yaml \
  --capabilities CAPABILITY_NAMED_IAM
```

📧 **Confirm the email subscription.**

---

## 🛑 Limitations

- The budget limit is static. Dynamic increase detection (e.g. "increase by $200 from yesterday") would require custom logic with AWS Lambda + CloudWatch.
- Billing data is only available in `us-east-1`.

---