provider aws {
    access_key = "AKIA47CR3IEQTKHN3BMM"
    secret_key = "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"
    region = "us-east-2"
}

resource "aws_instance" "ansible-machine" {
    ami = "ami-0cb91c7de36eed2cb"
    instance_type = "t2.micro"
    key_name = "oh-key"
    security_groups = ["default"]
    count = 1
    tags = {
        Name = "config_mgmt_machine-${(count.index)+1}"
    }
    user_data = <<-EOF
                    #!/bin/bash
                    sudo apt-get update
                    sudo apt-get install software-properties-common
                    sudo apt-add-repository --yes --update ppa:ansible/ansible
                    sudo apt-get install ansible -y
                EOF
}