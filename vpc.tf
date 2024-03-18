#vpc

resource "aws_vpc" "main" {
  cidr_block       = var.B_cidr_block

  tags = {
    Name = var.A_Name
  }
}

#pri- subnet

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.D_cidr_block

  tags = {
    Name = var.C_Name
  }
}

#pub-subnet

resource "aws_subnet" "main1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.F_cidr_block

  tags = {
    Name = var.E_Name
  }
}

#internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.G_Name
  }
}

#route-table

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.I_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.H_Name
  }
}

#route table association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}
