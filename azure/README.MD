# Run DDos
This terraform module does following:
- Creates resource group
- Creates virtual network / subnet
- Creates virtual machine scale set of provided size
- Creates ssh key pair, saves private key locally

Instance template is configured to have startup script that will run ddos script. Script is located in `script.sh`

## Prerequisites
- azure account (Free trial account [creation guide](https://azure.microsoft.com/en-us/offers/ms-azr-0044p/)). 
- azure cli on your workstation ([Installation guide](https://docs.microsoft.com/uk-ua/cli/azure/install-azure-cli)).
- terraform on your workstation ([Installation guide](https://www.terraform.io/downloads)).

## Usage
- Run `az login` to login into your azure account.
- Run

```bash
terraform init
terraform apply
```

You'll be promted with following:
- Number of vm to run


### Customization

- Set vm type with TF_VAR_vm_type environment variable. Default: `Standard_B1s`
- Set region with TF_VAR_region environment variable. Default: `Norway East`

Example:
```bash
export TF_VAR_vm_type=Standard_B1s
terraform apply
```

### Tear down
To tear down infrastructure:
```bash
terraform destroy
```
