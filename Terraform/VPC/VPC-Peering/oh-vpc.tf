resource "aws_vpc" "oh-vpc" {
    provider = aws.oh-region
    tags = {
        Name = "oh-vpc"
    }
    cidr_block = "20.0.0.0/24"
}

resource "aws_subnet" "oh-pub-sub" {
    provider = aws.oh-region
    vpc_id = aws_vpc.oh-vpc.id
    availability_zone = "us-east-2a"
    cidr_block = "20.0.0.0/28"
    tags = {
        Name = "oh-pub-sub"
    }
}

resource "aws_subnet" "oh-pvt-sub" {
    provider = aws.oh-region
    vpc_id = aws_vpc.oh-vpc.id
    availability_zone = "us-east-2a"
    cidr_block = "20.0.0.16/28"
    tags = {
        Name = "oh-pvt-sub"
    }
}

resource "aws_internet_gateway" "oh-igw" {
    provider = aws.oh-region
    vpc_id = aws_vpc.oh-vpc.id
    tags = {
        Name = "oh-igw"
    }
}

resource "aws_route_table" "oh-cust-rt" {
    provider = aws.oh-region
    vpc_id = aws_vpc.oh-vpc.id
    tags = {
        Name = "oh-custom-rt"
    }
}

resource "aws_route_table_association" "oh-sub-asso" {
    provider = aws.oh-region
    subnet_id = aws_subnet.oh-pub-sub.id
    route_table_id = aws_route_table.oh-cust-rt.id
}

resource "aws_route" "oh-igw-rt" {
    provider = aws.oh-region
    route_table_id = aws_route_table.oh-cust-rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.oh-igw.id
}

data "aws_route_table" "oh-main-rt" {
    provider = aws.oh-region
    vpc_id = aws_vpc.oh-vpc.id
    filter {
        name   = "association.main"
        values = ["true"]
  }
}

resource "aws_route_table_association" "oh-main-rt-asso" {
    provider = aws.oh-region
    route_table_id = data.aws_route_table.oh-main-rt.id
    subnet_id = aws_subnet.oh-pvt-sub.id
}

resource "aws_route" "oh-peering-rt" {
    provider = aws.oh-region
    route_table_id = data.aws_route_table.oh-main-rt.id
    destination_cidr_block = "10.0.0.0/24"
    gateway_id = aws_vpc_peering_connection.nv-oh-peering.id
}