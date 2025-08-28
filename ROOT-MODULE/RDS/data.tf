# data "aws_vpc" "vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["3-tier"]
#   }
# }

# data "aws_subnet" "db_subnet_1" {
#   filter {
#     name   = "tag:Name"
#     values = ["3-tier-Private-subnet-Database-1"]
#   }

#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.vpc.id]
#   }
# }

# data "aws_subnet" "db_subnet_2" {
#   filter {
#     name   = "tag:Name"
#     values = ["3-tier-Private-subnet-Database-2"]
#   }

#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.vpc.id]
#   }
# }