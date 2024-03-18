#instance ec2


resource "aws_instance" "example" {
  ami           = var.J_ami  
  instance_type = var.K_instance_type               
  key_name      = var.L_key_name
  vpc_security_group_ids = [
    aws_security_group.example.id 
    ]
    subnet_id = aws_subnet.main.id      

    tags = {
    Name = var.P_Name
}
}

#security group



resource "aws_security_group" "example" {
  name        = "sg"  # Change to your desired security group name
  description = "Example security group for EC2 instances"
  vpc_id      = "${aws_vpc.main.id}"    # Provide the ID of your existing VPC

  // Inbound rule allowing all traffic on port 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.M_cidr_blocks
  }

  // Inbound rule allowing all traffic on port 80 (HTTP)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.N_cidr_blocks
  }

  // Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.O_cidr_blocks
  }
}

