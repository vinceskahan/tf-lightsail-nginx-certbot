
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

# note the userdata script below, which is assumed to be in
# the current working directory.   To verify it worked, look
# for the cloud-init logs in /var/log in the VM once it boots.

resource "aws_lightsail_instance" "my_instance" {
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

resource "aws_lightsail_static_ip" "my_public_ip" {
  name = "${aws_lightsail_instance.my_instance.name}_ip"
}

#---------------------------------------------------------------------
# attach public ip to lightsail instance using their resource names
#---------------------------------------------------------------------

resource "aws_lightsail_static_ip_attachment" "my_ip_attachment" {
  static_ip_name = "${aws_lightsail_static_ip.my_public_ip.name}"
  instance_name  = "${aws_lightsail_instance.my_instance.name}"
}

#---------------------------------------------------------------------
# report which public ip was generated
#---------------------------------------------------------------------

output "public_ip_address" {
  value = "${aws_lightsail_static_ip_attachment.my_ip_attachment.ip_address}"
}

#---------------------------------------------------------------------
# that's all folks
#---------------------------------------------------------------------
