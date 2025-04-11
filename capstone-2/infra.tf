provider aws {
    access_key = "*****"
    secret_key = "*****"
    region = "us-east-1"
}

## VPC

resource "aws_vpc" "cust-vpc" {
    tags = {
        Name = "custom-vpc"
    }
    cidr_block = "10.0.0.0/24"
    enable_dns_hostnames = true
}

## pub-sub

resource "aws_subnet" "pub-sub" {
    vpc_id = aws_vpc.cust-vpc.id
    cidr_block = "10.0.0.0/28"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-sub"
    }
}

## igw

resource "aws_internet_gateway" "cust-igw" {
    vpc_id = aws_vpc.cust-vpc.id
    tags = {
        Name = "custom-igw"
    }
}

## route table

resource "aws_route_table" "cust-rt" {
    vpc_id = aws_vpc.cust-vpc.id
    tags = {
        Name = "custom-rt"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.cust-igw.id
    }
}

resource "aws_route_table_association" "sub-asso" {
    subnet_id = aws_subnet.pub-sub.id
    route_table_id = aws_route_table.cust-rt.id
}

## security security

resource "aws_security_group" "pub-sg" {
    vpc_id = aws_vpc.cust-vpc.id
    name = "public-sg"
    description = "allows ssh,http,custom"
    tags = {
        Name = "public-sg"
    }

    ingress {
        from_port = 22
        to_port = 22
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
        from_port = 30008
        to_port = 30008
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

## instance

resource "aws_instance" "j-master" {
    tags = {
        Name = "j-master"
    }
    ami = "ami-"
    instance_type = "t2.micro"
    key_name = "nv-key"
    subnet_id = aws_subnet.pub-sub.id
    vpc_security_group_ids = [aws_security_group.pub-sg.id]
    associate_public_ip_address = true
    count = 1
}

resource "aws_instance" "j-worker" {
    tags = {
        Name = "j-worker"
    }
    ami = "ami-"
    instance_type = "t2.micro"
    key_name = "nv-key"
    subnet_id = aws_subnet.pub-sub.id
    vpc_security_group_ids = [aws_security_group.pub-sg.id]
    associate_public_ip_address = true
    count = 1
}

resource "aws_instance" "k8s-master" {
    tags = {
        Name = "k8s-master" # as index starts from 0 adding +1
    }
    ami = "ami-"
    instance_type = "t2.micro"
    key_name = "nv-key"
    subnet_id = aws_subnet.pub-sub.id
    vpc_security_group_ids = [aws_security_group.pub-sg.id]
    associate_public_ip_address = true
    count = 1
}

resource "aws_instance" "k8s-worker" {
    tags = {
        Name = "k8s-worker-${(count.index)+1}"
    }
    ami = "ami-"
    instance_type = "t2.micro"
    key_name = "nv-key"
    subnet_id = aws_subnet.pub-sub.id
    vpc_security_group_ids = [aws_security_group.pub-sg.id]
    associate_public_ip_address = true
    count = 2
}
