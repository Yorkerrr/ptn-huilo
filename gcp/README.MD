# Run DDos
This terraform module does following:
- Creates google instance template
- Creates managed instance group
- Adds network firewall to allow egress traffic to 0.0.0.0\0 for instances with tag `ddos`

Instance template is configured to have startup script that will run ddos script. Script is located in `script.sh`

## Prerequisites
- gloud account with enabled GCE api
- gcloud account must have `default` network
- gcloud account must have default internet gateway rout
- installed terraform on your workstation

## Usage
- Run `gcloud auth application-default login`
- Run

```bash
terraform init
terraform apply
```

You'll be promted with following:
- GCP project id
- GCP region
- Number of vm to run

Example:
```bash
➜  ptn-huilo git:(master) ✗ terraform apply
var.project_id
  The GCP project

  Enter a value: endless-tractor-116006

var.region
  The GCP region, e.g: us-central1

  Enter a value: us-central1

var.vm_count
  The target number of running instances

  Enter a value: 2
```

### Customization

- Set vm type with TF_VAR_vm_type environment variable. Default: `n1-standard-1`
- Set custom network with TF_VAR_network. Default: `default`. NOTE: NETWORK MUST EXISTS IN GCP ACCOUNT.
- Disable preemtible with TF_VAR_preemtible=false. Default: `true`

Example:
```bash
export TF_VAR_vm_type=n1-standard-2
export TF_VAR_network=mynet
export TF_VAR_preemtible=false
terraform apply
```

### Tear down
To tear down infrastructure:
```bash
terraform destroy
```