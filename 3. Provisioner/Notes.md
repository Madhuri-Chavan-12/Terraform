# Terraform Provisioners   
- Provisioners run scripts or commands on local or remote machines during resource creation or destruction.

- Use only as a last resort. Terraform is declarative; provisioners are imperative and fragile.

## Types :   

### 1. local-exec

- Runs on the machine where Terraform is executed.

```
provisioner "local-exec" {
  command = "echo done"
}
```
### 2. remote-exec

- Runs commands on the created resource (SSH/WinRM required).
```
provisioner "remote-exec" {
  inline = ["sudo apt update"]
}
```
### 3. file

- Copies files to the remote resource.
```
provisioner "file" {
  source      = "app.conf"
  destination = "/tmp/app.conf"
}
```
---
###  Destroy Provisioner

- Runs before resource deletion.
```
provisioner "local-exec" {
  when    = destroy
  command = "echo destroying"
}
```

⚠️ Can block resource destruction if it fails.

