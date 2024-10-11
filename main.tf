provider "aws" {
    region     = "eu-north-1"
    access_key = "xxxxxxxxxxxx" 
    secret_key =  "xxxxxxxxxx"
}

resource "aws_instance" "my_instance" {
    ami                    = "ami-08eb150f611ca277f"
    instance_type         = "t3.large"
    vpc_security_group_ids = [aws_security_group.my_security.id]
    key_name              = "finalprojectkey"
    user_data             = file("${path.module}/userdata.sh")
    tags = {
      Name = "Instance_from_Terraform"
    }
    root_block_device {
      volume_size = 30
    }
}

resource "aws_security_group" "my_security" {
    name = "new_security_group"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress {
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 27017
        to_port     = 27017
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



 output "public_ip" {
    value = aws_instance.my_instance.public_ip
}
