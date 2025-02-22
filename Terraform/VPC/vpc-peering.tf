provider aws {
    access_key = "*****"
    secret_key = "*****"
    region = "us-east-2"
    alias = "oh-region"
}

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

resource "aws_security_group" "oh-pub-sg" {
    provider = aws.oh-region
    vpc_id = aws_vpc.oh-vpc.id
    name = "oh-public-sg"
    description = "allows ssh, http, https traffic from internet"
    tags = {
        Name = "oh-public-sg"
    }

    ingress {
        from_port = 22
        to_port=22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "oh-ec2" {
    provider = aws.oh-region
    ami = "ami-0cb91c7de36eed2cb"
    instance_type = "t2.micro"
    key_name =  "oh-key"
    subnet_id = aws_subnet.oh-pub-sub.id
    security_groups = [aws_security_group.oh-pub-sg.id]
    associate_public_ip_address = true
    count = 1
    tags = {
        Name = "oh-instance-${(count.index)+1}"
    }
}

provider aws {
    access_key = "*****"
    secret_key = "*****"
    region = "us-east-1"
    alias = "nv-region"
}

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

resource "aws_security_group" "nv-pub-sg" {
    provider = aws.nv-region
    vpc_id = aws_vpc.nv-vpc.id
    name = "nv-public-sg"
    description = "allows ssh, http, https traffic from internet"
    tags = {
        Name = "nv-public-sg"
    }

    ingress {
        from_port = 22
        to_port=22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "nv-ec2" {
    provider = aws.nv-region
    tags = {
        Name = "nv-ec2-${(count.index)+1}"
    }
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    key_name = "nv-key"
    subnet_id = aws_subnet.nv-pub-sub.id
    security_groups = [aws_security_group.nv-pub-sg.id]
    associate_public_ip_address = true
    count = 1
}