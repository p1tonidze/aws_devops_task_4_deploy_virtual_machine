# Uncomment the ami datasource to get the AMI id for your ec2 instance: 
# data "aws_ami" "this" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name = "name"
#     values = ["amzn2-ami-hvm-*-gp2"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }
# }

# create a key pair 
# create an ec2 instance 
