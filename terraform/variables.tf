variable "project" {
  default = "chadev"
}

variable "version" {
  default = "1.0.0"
}

variable "environment" {
  default = "dev"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default {
    public      = "10.0.1.0/24"
  }
}

variable "az" {
  description = "Default Availability Zone"
  default     = "us-east-1d"
}

variable "key" {
  description = "Key pair for ssh access to instances."
  default     = "chadev-demo"
}

/*
Variable maps like this can be referenced like so:
${var.instance_size["nomad_server"]}

Which would resolve to the string "m3.medium".
This allows us to easily scale vertically with instance size when forking from this template
*/
variable "instance_size" {
  description = "Default instance size for various server roles."

  default = {
    docker-node           = "t2.large"
  }
}

variable "packer_build_version" {
  default = {
    docker-node           = "1.0.0"
  }
}
