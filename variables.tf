
#---------------------------------------------------------------------
# AWS region and AZ to build the vm in
#---------------------------------------------------------------------
variable "aws_region"                  { default = "us-west-2" }
variable "aws_availability_zone"       { default = "us-west-2a" }

#---------------------------------------------------------------------
# filename with our AWS credentials
#---------------------------------------------------------------------
variable "aws_shared_credentials_file" { default = "/Users/vince/.aws/credentials" }

#---------------------------------------------------------------------
# profile in the credentials file to use
#---------------------------------------------------------------------
variable "aws_profile"                 { default = "vince" }

#---------------------------------------------------------------------
# predefined keypair to use from your account's AWS IAM console
#---------------------------------------------------------------------
variable "aws_key_pair_name"           { default = "vds-oregon-lightsail-key" }

#---------------------------------------------------------------------
# base image to use
#---------------------------------------------------------------------
####variable "aws_blueprint_id"            { default = "ubuntu_18_04" }
variable "aws_blueprint_id"            { default = "ubuntu_20_04" }

#---------------------------------------------------------------------
# instance size
#---------------------------------------------------------------------
variable "aws_bundle_id"               { default = "nano_2_0" }

#---------------------------------------------------------------------
# instance name to create
#---------------------------------------------------------------------
#variable "instance_name"               { default = "tfbuntu" }
variable "instance_name"               { default = "tfbuntu2004" }

#---------------------------------------------------------------------
# userdata script to run
#---------------------------------------------------------------------
variable "userdata_script"             { default = "userdata.sh" }

#---------------------------------------------------------------------
# that's all folks
#---------------------------------------------------------------------


