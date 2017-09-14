resource "aws_security_group" "public" {
  name        = "${var.project}-public"
  description = "Publicsecurity group"
  vpc_id      = "${aws_vpc.default.id}"

  /* allow ssh, not recommended for production! */
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /* allow http */
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /* allow https */
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  /* allow ping */
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /* allow all outbound */
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.project}-sg-public"
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Version     = "${var.version}"
  }
}
