# AWS Essentials: Deploy a Virtual Machine

This day has come — you are deploying Grafana! Of course, to deploy Grafana you will need a virtual machine. You will do everything with Terraform, and we will build on top of what you did in the [previous task](https://github.com/mate-academy/aws_devops_task_3_configure_network) 🤓.

## Prerequisites

Before completing any task in the module, make sure that you followed all the steps described in the **Environment Setup** topic, in particular:

1. Make sure you have an [AWS](https://aws.amazon.com/free/) account.

2. Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

3. Install [PowerShell Core](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.4).

4. Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

5. Log in to AWS CLI on your computer by running the command:

    ```
    aws configure
    ```

## Task Requirements

In this task, you will deploy an EC2 instance and install [Grafana](https://grafana.com/) on it.

To complete this task:

1. Edit `terraform.tfvars` — fill out the `tfvars` file with the outputs from the previous modules and your own configuration variables. You should use those variables as parameters for the resources in this task. This task requires only two variables — `subnet_id` and `security_group_id`, which you can get as Terraform module outputs in the [previous task](https://github.com/mate-academy/aws_devops_task_3_configure_network).

2. Edit `main.tf` — add resources required for this task:

    - Uncomment the [`aws_ami`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) resource and its configuration, and use it to get the AMI ID for your EC2 instance deployment.

    - Use the resource [`aws_key_pair`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) to create an SSH key pair resource for your EC2 instance.
        - For the resource, you have to provide an RSA SSH public key (if you don't have one — [generate it](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)).
        - If you want to get a bonus — use the [file](https://developer.hashicorp.com/terraform/language/functions/file) function to load the public key file content from your `.ssh` folder instead of hardcoding it in Terraform.

    - Use the resource [`aws_instance`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) to deploy an EC2 instance and install Grafana on it!
        - Use the data source you uncommented to get the AMI ID.
        - Use the `t2.micro` instance type.
        - Enable association of a public IP address.
        - Deploy the VM to the subnet you deployed in the previous task.
        - Use the security group you created in the previous task (for that, use the parameter `vpc_security_group_ids`).
        - Use the key pair you are deploying in this module.
        - Create a `Name` tag with the `mate-aws-grafana-lab` value.
        - Install Grafana on the VM using `cloud-init` (the parameter is called `user_data`). You can find a bash script for installing Grafana in the `install-grafana.sh` file in this repo. Use either the [file](https://developer.hashicorp.com/terraform/language/functions/file) function or a [multiline string](https://developer.hashicorp.com/terraform/language/expressions/strings#heredoc-strings) to load the script content to the Terraform resource parameter.

3. After adding the code to `main.tf`, review the `outputs.tf` file and make sure that all output variables are valid and can output relevant values, as described in the output variable descriptions.

4. Run the following commands to generate a Terraform execution plan in **JSON** format:

    ```
    terraform init
    terraform plan -out=tfplan
    terraform show -json tfplan > tfplan.json
    ```

5. Run an automated test to check yourself:

    ```
    pwsh ./tests/test-tf-plan.ps1
    ```

    If any test fails, please check your task code and repeat step 4 to generate a new `tfplan.json` file.

6. Deploy the infrastructure using the following command:

    ```
    terraform apply
    ```

    Make sure to collect module outputs — we will use those values in the next tasks.

7. Wait for 5 minutes after the deployment, and try to open the Grafana URL from the Terraform module output. When logging in for the first time, you will be prompted to change the admin password. Save the new password somewhere — you will need it for the next task.

8. Commit the `tfplan.json` file and submit your solution for review.
