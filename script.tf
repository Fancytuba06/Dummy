terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "pub-sub" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "pub-sub-s1"
  }
}

resource "aws_subnet" "pri-sub-s2" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "pri-sub-s2"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "my-rt"
  }
}

resource "aws_route_table_association" "my-rt-ass" {
  subnet_id      = aws_subnet.pub-sub.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_security_group" "sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.dev.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  key_name      = "demo" // Replace "your_key_pair_name" with the actual name of your key pair
  vpc_security_group_ids = [
    aws_security_group.sg.id,  // Attach existing security group named "allow_tls"
     
    
  ]
  subnet_id = aws_subnet.pub-sub.id

  tags = {
    Name = "HelloWorld"
  }
}


