#Public_Security-Group

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