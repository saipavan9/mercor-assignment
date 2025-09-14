variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# EC2 Configuration
variable "instance_type" {
  description = "EC2 instance type for ECS cluster"
  type        = string
  default     = "t3.medium"
}

variable "min_size" {
  description = "Minimum number of EC2 instances in Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances in Auto Scaling Group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances in Auto Scaling Group"
  type        = number
  default     = 2
}

# VPC Configuration
variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

# Security Groups
variable "ecs_instances_security_group_id" {
  description = "Security group ID for ECS instances"
  type        = string
}

# IAM Roles
variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "codedeploy_role_arn" {
  description = "ARN of the CodeDeploy role"
  type        = string
}

variable "ecs_instance_profile_name" {
  description = "Name of the ECS instance profile"
  type        = string
}

# ECR Configuration
variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}

# Load Balancer Configuration
variable "blue_target_group_arn" {
  description = "ARN of the blue target group"
  type        = string
}

variable "blue_target_group_name" {
  description = "Name of the blue target group"
  type        = string
}

variable "green_target_group_arn" {
  description = "ARN of the green target group"
  type        = string
}

variable "green_target_group_name" {
  description = "Name of the green target group"
  type        = string
}

# Application Configuration
variable "container_port" {
  description = "Port exposed by the docker image"
  type        = number
  default     = 8000
}

variable "app_cpu" {
  description = "CPU units for the application"
  type        = number
  default     = 256
}

variable "app_memory" {
  description = "Memory in MiB for the application"
  type        = number
  default     = 512
}

variable "app_count" {
  description = "Number of docker containers to run"
  type        = number
  default     = 2
}

variable "app_version" {
  description = "Application version"
  type        = string
  default     = "v1.0.0"
}

variable "alb_listener_arn" {
  description = "ARN of the ALB listener"
  type        = string
}

# CloudWatch Configuration
variable "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
}

# Zero-downtime update configuration
variable "health_check_grace_period" {
  description = "Health check grace period for Auto Scaling Group"
  type        = number
  default     = 300
}

variable "instance_warmup" {
  description = "Instance warmup period for instance refresh"
  type        = number
  default     = 300
}

variable "min_healthy_percentage" {
  description = "Minimum healthy percentage during instance refresh"
  type        = number
  default     = 50
}

variable "service_health_check_grace_period" {
  description = "Health check grace period for ECS service"
  type        = number
  default     = 60
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 30
}

variable "root_volume_type" {
  description = "Type of the root volume"
  type        = string
  default     = "gp3"
}
