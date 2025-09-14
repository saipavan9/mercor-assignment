project_name = "mercor-ecs-app"

aws_region = "us-east-1"

vpc_cidr = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]
public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
enable_nat_gateway = true

container_port = 8000
app_cpu = 256
app_memory = 512
app_count = 2
health_check_path = "/health"

# EC2 Configuration
instance_type = "t2.micro"
min_size = 1
max_size = 3
desired_capacity = 2

health_check_grace_period = 300
instance_warmup = 100
min_healthy_percentage = 50

tags = {
  Project     = "mercor-ecs-app"
  ManagedBy   = "terraform"
}
