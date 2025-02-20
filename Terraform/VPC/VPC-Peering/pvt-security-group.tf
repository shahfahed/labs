#Private_Security-Group

resource "aws_security_group" "nv-pvt-sg" {
    provider = aws.nv-region
    vpc_id = aws_vpc.nv-vpc.id
    name = "nv-private-sg"
    description = "allows ssh only"
    tags = {
        Name = "nv-private-sg"
    }

    ingress {
        from_port = 22
        to_port=22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/24","20.0.0.16/28"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}



resource "aws_security_group" "oh-pvt-sg" {
    provider = aws.oh-region
    vpc_id = aws_vpc.oh-vpc.id
    name = "oh-private-sg"
    description = "allows ssh"
    tags = {
        Name = "oh-private-sg"
    }

    ingress {
        from_port = 22
        to_port=22
        protocol = "tcp"
        cidr_blocks = ["20.0.0.0/24","10.0.0.16/28"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}