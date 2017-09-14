/* required in at least .tf file, but don't specify it twice! */
provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = false

  tags {
    Name        = "${var.project}-vpc"
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Version     = "${var.version}"
  }
}

/* connect to the internets! */
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.project}-internet-gateway"
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Version     = "${var.version}"
  }
}
