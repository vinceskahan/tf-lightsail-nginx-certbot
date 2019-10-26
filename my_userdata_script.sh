#!/bin/bash

echo "userdata run at `date`" >> /root/000-TERRAFORM-DATE

# don't run this on 18.04 because it prompts
# for an interactive 'yes' for some items that
# need updating
#     apt-get update
#     apt-get upgrade -y

