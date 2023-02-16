provider "aws" {
    region = "us-east-1"
    access_key="AKIA2AUI2DIT3SJ2IQVG"
    secret_key="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"
}

# creating VPC,name,CIDR and tags
resource "aws_vpc" "tom" {
    cidr_block         = "10.0.0.0/16"
    instance_tenancy   = "default"
    enable_dns_support = "true"
    enable_dns_hostname= "true"
    enable_classiclink = "false"
    tags={
        Name="tom"
    }
}

#creating Public Subnets in VPC
resource "aws_subnet" "tom-public-1"{
    vpc_id                  = aws_vpc.tom.vpc_id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-1a"
    tags={
        Name="tom-public-1"
    }
}

resource "aws_subnet" "tom-public-2"{
    vpc_id                  = aws_vpc.tom.vpc_id
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-1b"
    tags={
        Name="tom-public-2"
    }
}

#creating internet gateway in AWS VPC
resource "aws_internet_gateway" "tom-gw"{
    vpc_id = aws_vpc.tom.id
    
    tags={
        Name="tom"
    }
}
# creating route table for internet gateway
resource "aws_route_table" "tom-public"{
    vpc_id = aws_vpc.tom.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id = aws_internet_gateway.tom-gw.id
    }
    tags={
        Name="tom-public-1"
    }
}

#creating Route Associations public subnets
resource "aws_route_table_association" "tom-public-1-a"{
    subnet_id = aws_subnet.tom-public-1.id
    route_table_id =aws_route_table.tom-public.id
}

resource "aws_route_table_association" "tom-public-2-a"{
    subnet_id = aws_subnet.tom-public-2.id
    route_table_id =aws_route_table.tom-public.id
}

# creating EC2 instances in  public subnets
resource "aws_instance" "public_inst_1"{
    ami="ami-0c1a7f89451184c8b"
    instance_type ="t2.micro"
    subnet_id="${aws_subnet.tom-public-1.id}"
    key_name="key11"
    tags={
        Name="public_inst_1"
    }
}

resource "aws_instance" "public_inst_1"{
    ami="ami-0c1a7f89451184c8b"
    instance_type ="t2.micro"
    subnet_id="${aws_subnet.tom-public-2.id}"
    key_name="key11"
    tags={
        Name="public_inst_2"
    }
}

