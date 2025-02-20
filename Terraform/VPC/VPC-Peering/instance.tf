#public instance

resource "aws_instance" "pub-nv-ec2" {
    provider = aws.nv-region
    tags = {
        Name = "pub-nv-ec2-${(count.index)+1}"
    }
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    key_name = "nv-key"
    subnet_id = aws_subnet.nv-pub-sub.id
    security_groups = [aws_security_group.nv-pub-sg.id]
    associate_public_ip_address = true
    count = 1
}


resource "aws_instance" "pub-oh-ec2" {
    provider = aws.oh-region
    ami = "ami-0cb91c7de36eed2cb"
    instance_type = "t2.micro"
    key_name =  "oh-key"
    subnet_id = aws_subnet.oh-pub-sub.id
    security_groups = [aws_security_group.oh-pub-sg.id]
    associate_public_ip_address = true
    count = 1
    tags = {
        Name = "pub-oh-ec2-${(count.index)+1}"
    }
}


#private instance

resource "aws_instance" "pvt-nv-ec2" {
    provider = aws.nv-region
    tags = {
        Name = "pvt-nv-ec2-${(count.index)+1}"
    }
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    key_name = "nv-key"
    subnet_id = aws_subnet.nv-pvt-sub.id
    security_groups = [aws_security_group.nv-pvt-sg.id]
    associate_public_ip_address = true
    count = 1
}


resource "aws_instance" "pvt-oh-ec2" {
    provider = aws.oh-region
    ami = "ami-0cb91c7de36eed2cb"
    instance_type = "t2.micro"
    key_name =  "oh-key"
    subnet_id = aws_subnet.oh-pvt-sub.id
    security_groups = [aws_security_group.oh-pvt-sg.id]
    associate_public_ip_address = true
    count = 1
    tags = {
        Name = "oh-instance-${(count.index)+1}"
    }
}