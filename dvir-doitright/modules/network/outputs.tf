output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.tr_vpc.id
}

output "subnets" {
  description = "ID of project subnet"
  value       = tolist(aws_subnet.pub-sub[*].id)
}



