
#---------------------------------------------------------------------
# define our region and which credentials to use
#---------------------------------------------------------------------

provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "/Users/vince/.aws/credentials"
  profile                 = "vince"
}

#---------------------------------------------------------------------
# create a lightsail instance
#---------------------------------------------------------------------

# key_pair_name must be a pre-existing key_pair name created manually
# in the Lightsail console.  aws_key_pair cannot be used at this time
# according to the TF documentation

resource "aws_lightsail_instance" "vdstest" {
  name              = "tfbuntu"
  availability_zone = "us-west-2a"
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "nano_2_0"
  key_pair_name     = "vds-oregon-lightsail-key"
  user_data         = "${file("my_userdata_script.sh")}"
}

#---------------------------------------------------------------------
# allocate a public ip address
#---------------------------------------------------------------------

resource "aws_lightsail_static_ip" "vdstest" {
  name = "vdstest_ip"
}

#---------------------------------------------------------------------
# attach the public ip to the lightsail instance
#---------------------------------------------------------------------

resource "aws_lightsail_static_ip_attachment" "vdstest" {
  static_ip_name = "${aws_lightsail_static_ip.vdstest.name}"
  instance_name  = "${aws_lightsail_instance.vdstest.name}"
}

############################
# exported attributes
############################
# ip_address = the allocated ip address

#---------------------------------------------------------------------
# report which public ip was generated
#---------------------------------------------------------------------

output "public_ip_address" {
  value = "${aws_lightsail_static_ip.vdstest.ip_address}"
}
