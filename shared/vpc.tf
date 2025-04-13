data "aws_availability_zones" "available" {}

resource "aws_vpc" "shot_it_vpc" {
  cidr_block = var.vpc_cidr # Use the variable for the CIDR block
}

resource "aws_subnet" "shot_it_subnets" {
  count             = 2 # Create multiple subnets for high availability
  vpc_id            = aws_vpc.shot_it_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.shot_it_vpc.cidr_block, 2, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true

  tags = {
    Application = "shot-it"
    Name        = "shot-it-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.shot_it_vpc.id

  tags = {
    Name = "shot-it-igw"
  }
}

resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.shot_it_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "shot-it-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count = length(aws_subnet.shot_it_subnets)

  subnet_id      = aws_subnet.shot_it_subnets.*.id[count.index]
  route_table_id = aws_route_table.public_routetable.id
}

resource "aws_security_group" "ssh_cluster" {
  vpc_id = aws_vpc.shot_it_vpc.id

  tags = {
    name = "shot-it-ssh-sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}