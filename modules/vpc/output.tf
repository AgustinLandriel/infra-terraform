output "vpc_id" {
  value = module.vpc.id
}

output "public_subnet" {
  value = module.vpc.public_subnets
}

output "private_subnet" {
  value = module.vpc.private_subnets
}
