output "vpc_id" {
  value = aws_vpc.shot_it_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.shot_it_vpc.cidr_block
}

output "subnets_ids" {
  value = aws_subnet.shot_it_subnets[*].id
}

output "ssh_security_group_id" {
  value = aws_security_group.ssh_cluster.id
}