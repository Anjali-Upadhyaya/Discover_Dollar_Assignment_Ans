provider "aws" {
    region = "us-east-1"
    access_key="AXXXXXXXXXXXXXXXXXXXX"
    secret_key="7XXXXXXXXXXXXXXXXXXXXXX"
}

resource "aws_instance" "public_inst_1"{
    ami="ami-0c1a7f89451184c8b"
    instance_type ="t2.micro"
    key_name="key11"
    count = 3 
    tags={
        Name="ec2instance"
    }
}
