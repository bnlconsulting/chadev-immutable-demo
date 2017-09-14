resource "aws_instance" "docker-node" {
  ami                         = "${data.aws_ami.docker-node.id}"
  availability_zone           = "${var.az}"
  instance_type               = "${var.instance_size["docker-node"]}"
  key_name                    = "${var.key}"
  vpc_security_group_ids      = ["${aws_security_group.public.id}"]
  subnet_id                   = "${aws_subnet.public.id}"
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
  }

  tags {
    Name        = "${var.project}-docker-node"
    Project     = "${var.project}"
    Role        = "Docker node"
    Environment = "${var.environment}"
    Version     = "${var.version}"
  }
}
