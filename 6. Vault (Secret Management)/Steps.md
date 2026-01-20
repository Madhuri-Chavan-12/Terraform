### Step 1: Install Vault   
1.1 Update system  
```
sudo apt update && sudo apt upgrade -y
```

1.2 Add HashiCorp GPG key  
```
curl -fsSL https://apt.releases.hashicorp.com/gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```
1.3 Add HashiCorp repository  
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com jammy main" \
| sudo tee /etc/apt/sources.list.d/hashicorp.list
```

1.4 Install Vault  
```
sudo apt update
sudo apt install vault -y
```

Verify:
```
vault version
```
---
### Step 2: Start Vault in Dev Mode (for Hands-on practice)  
```
vault server -dev -dev-listen-address="0.0.0.0:8200"
```

You will see in the output: 
```
Root Token

Unseal not required (dev mode)
```

⚠️ Important: Copy the Root Token.
If you lose it, you must restart the Vault server.

--- 
### Step 3: Vault Client Setup

Open a new terminal on the same EC2 instance.

```
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN='<ROOT_TOKEN>'
```

Check:
```
vault status
```
---
### Step 4: Secret Store & Read (Actual Secret Management)
4.1 Write a secret  
```
vault kv put secret/db password="****" username="****"
```

4.2 Read the secret  
```
vault kv get secret/db
```

4.3 Read a specific field  
```
vault kv get -field=password secret/db
```
