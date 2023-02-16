provider "aws" {
    region = "us-east-1"
    access_key="AKIA2AUI2DIT3SJ2IQVG"
    secret_key="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"
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