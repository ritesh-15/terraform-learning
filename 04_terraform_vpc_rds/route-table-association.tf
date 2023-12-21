resource "aws_route_table_association" "TfRoutePublicAssociation" {
  subnet_id      = aws_subnet.TfPublicSubnet.id
  route_table_id = aws_route_table.TfRouteTablePublic.id
  depends_on = [ aws_subnet.TfPublicSubnet, aws_route_table.TfRouteTablePublic ]
}

resource "aws_route_table_association" "TfRoutePrivateAssociation" {
  subnet_id      = aws_subnet.TfPrivateSubnet.id
  route_table_id = aws_route_table.TfRouteTablePrivate.id
  depends_on = [ aws_subnet.TfPrivateSubnet ,aws_route_table.TfRouteTablePrivate ]
}