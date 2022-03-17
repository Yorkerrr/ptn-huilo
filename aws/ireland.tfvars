region  = "eu-west-1"
profile = "vb"

on_demand_desired_capacity = 0
on_demand_instance_type    = "t3.micro"

spot_desired_capacity = 2
spot_instance_types   = ["t3.micro", "t3a.micro"]
spot_max_price        = "0.004"

user_data_filename = "script.sh"
