data "aws_ami" "docker-node" {
  filter {
    name   = "tag:Version"
    values = ["${var.packer_build_version["docker-node"]}"]
  }

  most_recent = true
  name_regex  = "^.*docker*"
}
