# Terraform + HashiCorp Vault 

## 1. What is HashiCorp Vault?

HashiCorp Vault is a secrets management tool used to:

* Store secrets securely (passwords, API keys, tokens)
* Generate dynamic credentials (DB users, cloud creds)
* Control access using policies
* Audit secret access


---

## 2. Why Use Vault with Terraform?

Terraform needs credentials to create infrastructure. Vault helps by:

* Keeping secrets out of `.tf` files
* Rotating secrets automatically
* Providing short-lived credentials
* Improving security and compliance


---

## 3. Terraform Vault Provider

Terraform communicates with Vault using the official provider.

### Provider Configuration

Vault address and token are usually provided via environment variables:

* `VAULT_ADDR`
* `VAULT_TOKEN`


---

## 4. Authentication Methods

Common Vault auth methods used with Terraform:

* **Token auth** (simple, not ideal for production)
* **AppRole** (recommended for CI/CD)
* **Kubernetes auth** (for in-cluster Terraform)
* **AWS IAM auth** (for AWS-based automation)


---

## 5. Reading Secrets from Vault

Terraform can read secrets using data sources.

Typical use cases:

* Fetch DB passwords
* Fetch API keys
* Fetch TLS certificates


---

## 6. Writing Secrets to Vault

Terraform can also write secrets to Vault:

Examples:

* Store generated passwords
* Store outputs from infrastructure provisioning


---

## 7. Vault Policies

Vault policies define what Terraform can access.

Guidelines:

* Use least privilege
* Separate policies for dev / staging / prod
* Never use root token

If Terraform can read everything in Vault, your security model is broken.

---

## 8. CI/CD Integration

Typical flow:

1. CI job authenticates to Vault (AppRole / IAM)
2. Vault returns short-lived token
3. Terraform uses token to read required secrets
4. Token expires automatically

---

## 9. Terraform State & Vault

Critical issue:

* Terraform state may store secrets in plain text

Mitigations:

* Use remote state with encryption (S3 + KMS, Terraform Cloud)
* Limit secret exposure in outputs
* Prefer dynamic secrets that expire


