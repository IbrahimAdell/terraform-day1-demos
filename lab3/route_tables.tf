# public route table 
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.rt-cide
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.public-rt-name
  }

}

# assigning the public route tables to the public subnet
resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.subnet["public-subnet"].id
  route_table_id = aws_route_table.public-rt.id

}

# private route table 
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.rt-cide
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = var.private-rt-name
  }
}

# assigning the private route tables to the private subnet
resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.subnet["private-subnet"].id
  route_table_id = aws_route_table.private-rt.id

}
