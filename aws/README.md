# Steps
1. Setup AWS ACC
2. Create IAM user with Administrator privileges
<img width="1746" alt="image" src="https://user-images.githubusercontent.com/48525503/156642487-c95b4cb2-b943-4519-9aa7-d74b06297671.png">
<img width="1050" alt="image" src="https://user-images.githubusercontent.com/48525503/156642653-de50ede1-77df-4acf-80e2-5eedb3f81f61.png">
<img width="1025" alt="image" src="https://user-images.githubusercontent.com/48525503/156642812-943fe72b-20ba-4d7b-abf2-320a8705ee5a.png">


3. Put this user credentials to `~/.aws/credentials` on your laptop
```
[user1]
aws_access_key_id=AKIAI44QH8DHBEXAMPLE
aws_secret_access_key=je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
```
3. Download Terraform - https://www.terraform.io/downloads
4. Clone this repo
```
git clone https://github.com/nomatterz/pnh
cd pnh
```
5. There are default variables values (`variables.tf` file and also they are listed below here, in `README.md`).  
Also you can provide your own values and override defaults - file with custom variables shoud have extenstion `*.tfvars`   
Repo contains sample variable file - `ireland.tfvars`.   
Specify your profile (`user1`) to terraform `profile` variable either by overridding value in `ireland.tfvars` or in your custom variable file.
6. Adjust ddoser launch cmd if needed in `user_data_ddoser.sh`
7. Run
```
terraform init
terraform apply -var-file myfile.tfvars 
```
9. To launch instances in another region create `*.tfvars` file with needed values (available regions can be found here - https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html - `us-east-1`, `eu-central-1`, etc
10. To destroy AWS resources
```
terraform destroy -var-file myfile.tfvars
```
---
# How to increase available Spot instances number to launch 
for new accounts you should request 32-64 vCPU
![image](https://user-images.githubusercontent.com/48525503/156899393-523dd4f7-5706-454a-a01a-3b5bf7047488.png)
![image](https://user-images.githubusercontent.com/48525503/156899400-466c27c7-fbf8-402e-8d07-b8497fe8b09f.png)
![image](https://user-images.githubusercontent.com/48525503/156899417-cbf9d715-b39f-41b1-b7e9-9a91dd9fbf61.png)

# Terraforms docs
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.on_demand](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_group.spot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_iam_instance_profile.profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy_attachment.attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_launch_template.base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_ami.amazon_linux2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnets.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Max size for autoscaling groups. Both on-demand and spot. | `number` | `32` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Min size for autoscale groups. Both on-demand and spot | `number` | `0` | no |
| <a name="input_on_demand_desired_capacity"></a> [on\_demand\_desired\_capacity](#input\_on\_demand\_desired\_capacity) | number of on-demand instances to launch | `number` | `2` | no |
| <a name="input_on_demand_instance_type"></a> [on\_demand\_instance\_type](#input\_on\_demand\_instance\_type) | on-demand instance type to use | `string` | `"t3.micro"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Profile for AWS credentials | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_spot_desired_capacity"></a> [spot\_desired\_capacity](#input\_spot\_desired\_capacity) | number of spot instances to launch | `number` | `2` | no |
| <a name="input_spot_instance_types"></a> [spot\_instance\_types](#input\_spot\_instance\_types) | list of spot instance types to launch. defaults to empty | `list(string)` | `[]` | no |
| <a name="input_spot_max_price"></a> [spot\_max\_price](#input\_spot\_max\_price) | max price for spot instances. same for all the types | `string` | `"0.004"` | no |
| <a name="input_user_data_filename"></a> [user\_data\_filename](#input\_user\_data\_filename) | name of file that will be used as ec2 userdata script | `string` | `"user_data_ddoser.sh"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
