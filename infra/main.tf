module "vpc" {
  source = "./modules/vpc"

  name_prefix        = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway

  tags = merge(var.tags, {
    Project     = var.project_name
    ManagedBy   = "terraform"
  })
}

module "alb" {
  source = "./modules/alb"

  name_prefix        = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  container_port     = var.container_port
  health_check_path  = var.health_check_path

  tags = merge(var.tags, {
    Project     = var.project_name
    ManagedBy   = "terraform"
  })

  depends_on = [module.vpc]
}

module "security_groups" {
  source = "./modules/security-groups"

  name_prefix              = var.project_name
  vpc_id                   = module.vpc.vpc_id
  vpc_cidr                 = var.vpc_cidr
  container_port           = var.container_port
  alb_security_group_id    = module.alb.alb_security_group_id

  tags = merge(var.tags, {
    Project     = var.project_name
    ManagedBy   = "terraform"
  })

  depends_on = [module.vpc, module.alb]
}

module "ecs" {
  source = "./modules/ecs"

  name_prefix              = var.project_name
  aws_region               = var.aws_region
  private_subnet_ids       = module.vpc.private_subnet_ids
  ecs_instances_security_group_id = module.security_groups.ecs_instances_security_group_id
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn
  codedeploy_role_arn      = aws_iam_role.codedeploy.arn
  ecs_instance_profile_name = aws_iam_instance_profile.ecs_instance.name
  ecr_repository_url       = aws_ecr_repository.app.repository_url
  blue_target_group_arn    = module.alb.blue_target_group_arn
  blue_target_group_name   = module.alb.blue_target_group_name
  green_target_group_arn   = module.alb.green_target_group_arn
  green_target_group_name  = module.alb.green_target_group_name
  alb_listener_arn = module.alb.listener_arn


  cloudwatch_log_group_name = aws_cloudwatch_log_group.app.name

  # EC2 Configuration
  instance_type    = var.instance_type
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  health_check_grace_period         = var.health_check_grace_period
  instance_warmup                   = var.instance_warmup
  min_healthy_percentage            = var.min_healthy_percentage
  service_health_check_grace_period = var.service_health_check_grace_period
  root_volume_size                  = var.root_volume_size
  root_volume_type                  = var.root_volume_type

  # Application Configuration
  container_port = var.container_port
  app_cpu        = var.app_cpu
  app_memory     = var.app_memory
  app_count      = var.app_count

  tags = merge(var.tags, {
    Project     = var.project_name
    ManagedBy   = "terraform"
  })

  depends_on = [
    module.vpc,
    module.alb,
    module.security_groups,
    aws_iam_role.ecs_task_execution,
    aws_iam_role.ecs_task,
    aws_iam_role.codedeploy,
    aws_iam_instance_profile.ecs_instance,
    aws_ecr_repository.app,
    aws_cloudwatch_log_group.app
  ]
}

# ECR Repository
resource "aws_ecr_repository" "app" {
  name                 = "${var.project_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-ecr"
  })
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 30

  tags = merge(var.tags, {
    Name = "${var.project_name}-log-group"
  })
}





