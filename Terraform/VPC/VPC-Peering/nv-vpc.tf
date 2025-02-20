resource "aws_vpc" "nv-vpc" {
    provider = aws.nv-region
    tags = {
        Name = "nv-vpc"
    }
    cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "nv-pub-sub" {
    provider = aws.nv-region
    vpc_id = aws_vpc.nv-vpc.id
    cidr_block = "10.0.0.0/28"
    availability_zone = "us-east-1a"
    tags = {
        Name = "public-subnet"
    }
}

resource "aws_subnet" "nv-pvt-sub" {
    provider = aws.nv-region
    vpc_id = aws_vpc.nv-vpc.id
    cidr_block = "10.0.0.16/28"
    availability_zone = "us-east-1a"
    tags = {
        Name = "private-subnet"
    }
}

resource "aws_internet_gateway" "nv-igw" {
    provider = aws.nv-region
    vpc_id = aws_vpc.nv-vpc.id
    tags = {
        Name = "nv-igw"
    }
}

resource "aws_route_table" "nv-cust-rt" {
    provider = aws.nv-region
    vpc_id = aws_vpc.nv-vpc.id
    tags = {
        Name = "nv-custom-rt"
    }
}

resource "aws_route" "nv-pub-rt" {
    provider = aws.nv-region
    route_table_id = aws_route_table.nv-cust-rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nv-igw.id
}

resource "aws_route_table_association" "sub-asso" {
    provider = aws.nv-region
    subnet_id = aws_subnet.nv-pub-sub.id
    route_table_id = aws_route_table.nv-cust-rt.id
}

data "aws_route_table" "nv-main-rt" {
    provider = aws.nv-region
    vpc_id = aws_vpc.nv-vpc.id
    filter {
        name   = "association.main"
        values = ["true"]
  }
}

resource "aws_route_table_association" "nv-main-rt-asso" {
    provider = aws.nv-region
    route_table_id = data.aws_route_table.nv-main-rt.id
    subnet_id = aws_subnet.nv-pvt-sub.id
}

resource "aws_route" "nv-peering-rt" {
    provider = aws.nv-region
    route_table_id = data.aws_route_table.nv-main-rt.id
    destination_cidr_block = "20.0.0.0/24"
    gateway_id = aws_vpc_peering_connection.nv-oh-peering.id
}