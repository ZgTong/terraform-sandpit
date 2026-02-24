data "aws_availability_zones" "myzones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ec2_instance_type_offerings" "my_ins_type" {
  for_each = toset(data.aws_availability_zones.myzones.names)
  filter {
    name   = "instance-type"
    values = [var.instance_type]
  }

  filter {
    name  = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}

output "output_1" {
  value = toset([for k, v in data.aws_ec2_instance_type_offerings.my_ins_type : v.instance_types[0]])
}

# Basic Output: All Availability Zones mapped to Supported Instance Types
output "output_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types
  }
}

# Filtered Output: Exclude Unsupported Availability Zones
output "output_3" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types if length(details.instance_types) != 0
  }
}

# Filtered Output: with Keys Function - Which gets keys from a Map
# This will return the list of availability zones supported for a instance type
output "output_4" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types if length(details.instance_types) != 0
  })
}

# Filtered Output: As the output is list now, get the first item from list
output "output_5" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types if length(details.instance_types) != 0
  })[0]
}