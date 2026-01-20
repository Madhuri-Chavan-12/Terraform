# Terraform Workspaces 

A Terraform workspace is a way to manage **multiple state files** from the **same Terraform configuration**. Each workspace represents a separate instance of your infrastructure (for example: `dev`, `staging`, `prod`).

Terraform uses **one state file per workspace**.

---

## Why Use Workspaces?

Use workspaces when:

* You want **multiple environments** using the **same codebase**
* You want **isolated state** without duplicating Terraform files
* You need a **quick and lightweight environment split**

---

## Default Workspace

* Terraform always starts with a workspace named **`default`**
* `default` cannot be deleted


---

## Common Workspace Commands

```bash
terraform workspace list
terraform workspace show
terraform workspace new dev
terraform workspace select prod
terraform workspace delete dev
```

---

## How Workspaces Affect State

Each workspace has its own state file:

```
terraform.tfstate.d/
├── dev/terraform.tfstate
├── staging/terraform.tfstate
└── prod/terraform.tfstate
```

With remote backends (S3, Terraform Cloud), Terraform automatically namespaces the state per workspace.

---

## Using Workspace in Code

Access current workspace:

```hcl
terraform.workspace
```

Example usage:

```hcl
resource "aws_instance" "app" {
  instance_type = terraform.workspace == "prod" ? "t3.large" : "t3.micro"
}
```




---

## Summary

Terraform workspaces are:

* State-level isolation
* Same code, multiple environments
* Simple but limited

