# Terraform S3 Remote Backend

## Environments & Workspaces
We use Partial Backend Configuration to separate environments (dev, test, prod).

To deploy an environment (e.g., `dev`):

1. **Initialize the Backend for Dev:**
   ```bash
   terraform init -backend-config=environments/dev/backend.hcl -reconfigure
   ```
2. **Review the Plan for Dev:**
   ```bash
   terraform plan -var-file=environments/dev/terraform.tfvars
   ```
3. **Apply the changes for Dev:**
   ```bash
   terraform apply -var-file=environments/dev/terraform.tfvars
   ```
4. **Destroy the Dev environment (When you are done):**
   ```bash
   terraform destroy -var-file=environments/dev/terraform.tfvars
   ```
> **Note:** Whenever you switch between environments, you MUST run `terraform init -backend-config=environments/<env>/backend.hcl -reconfigure` first to ensure Terraform uses the correct state file.

## Connecting to Database

aws ssm start-session \
    --target <db_instance_id> \
    --document-name AWS-StartPortForwardingSessionToRemoteHost \
    --parameters '{"portNumber":["5432"], "localPortNumber":["5432"]}'