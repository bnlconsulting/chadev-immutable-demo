/* Define our public subnet */
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.subnet_cidr["public"]}"
  availability_zone       = "${var.az}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_internet_gateway.default"]

  tags {
    Name        = "${var.project}-public-subnet"
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Version     = "${var.version}"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Project     = "${var.project}"
    Name        = "${var.project}-route-table-public"
    Environment = "${var.environment}"
    Version     = "${var.version}"
  }
}

/* Routing table for public subnet */
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}
