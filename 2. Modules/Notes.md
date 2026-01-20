# Terraform Modules

Modules are reusable blocks of Terraform code.  A Terraform module is a self-contained, reusable set of Terraform configuration files (.tf) that define one or more infrastructure resources and expose inputs (variables) and outputs so the same logic can be used consistently across different environments or projects.

### **Modules help with:**

**1. Modularity**

- Break infrastructure into small, focused components

- Improves readability and maintainability

**2. Reusability**

- Same module used across multiple projects & environments

- Eliminates duplicated code and config drift

**3. Consistency**

- Enforces standard infrastructure patterns

- Reduces environment-specific surprises

**4. Team Collaboration**

- Teams work on independent modules

- Clear ownership, fewer merge conflicts

**5. Versioning & Controlled Changes**

- Modules are versioned separately

- Consumers decide when to upgrade, reducing risk

**6. Abstraction**

- Hides low-level resource details

- Users interact via inputs & outputs only

**7. Testability**

- Modules can be validated and tested independently

- Prevents bugs from propagating

**8. Scalability**

- Codebase scales cleanly as infrastructure grows

- Prevents monolithic Terraform configs

**9. Security & Compliance**

- Security best practices embedded in modules

- Ensures compliant-by-default infrastructure
---
### **Types of Modules**
**1. Root Module:**   
- The main working directory where terraform init/plan/apply is run.

- Calls child modules.

**2. Child Module:**

- A reusable module called by the root module or another module.

- Usually stored in a separate folder or Git repo.
---
### **Typical Module Structure**   
~~~
terraform-ec2/
├── main.tf         # Resource definitions
├── variables.tf    # Input variables
├── outputs.tf      # Outputs
├── versions.tf     # Terraform & provider versions
~~~



