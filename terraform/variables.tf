variable "aws_region" {
  type        = string
  description = "The name of the AWS region"
  default     = "ap-northeast-1"
}

variable "profile" {
  type        = string
  description = "The name of the AWS profile"
  default     = "terraform-cloud-user"
}

# frontend server variables
variable "frontend_instance_config" {
  type = object({
    frontend_instance_name = string
    frontend_instance_type = string
    frontend_environment   = string
  })
  description = "Instance configuration"

  default = {
    frontend_instance_name = "express-frontend"
    frontend_instance_type = "t2.micro"
    frontend_environment   = "staging"
  }

  validation {
    condition     = length(var.frontend_instance_config.frontend_instance_name) > 5 && length(var.frontend_instance_config.frontend_instance_name) < 20
    error_message = "The character length of the frontend instance name should be between 5 and 30"
  }

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t2.medium", "t3.medium"], var.frontend_instance_config.frontend_instance_type)
    error_message = "The allowed frontend instance types are t2.micro and t3.micro and t2.medium and t3.medium"
  }

  validation {
    condition     = contains(["dev", "staging", "prod"], var.frontend_instance_config.frontend_environment)
    error_message = "The allowed frontend environments are dev and staging and prod"
  }
}

# backend server variables
variable "backend_instance_config" {
  type = object({
    backend_instance_name = string
    backend_instance_type = string
    backend_environment   = string
  })
  description = "Instance configuration"

  default = {
    backend_instance_name = "react-backend"
    backend_instance_type = "t2.micro"
    backend_environment   = "staging"
  }

  validation {
    condition     = length(var.backend_instance_config.backend_instance_name) > 5 && length(var.backend_instance_config.backend_instance_name) < 20
    error_message = "The character length of the backend instance name should be between 5 and 30"
  }

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t2.medium", "t3.medium"], var.backend_instance_config.backend_instance_type)
    error_message = "The allowed backend instance types are t2.micro and t3.micro and t2.medium and t3.medium"
  }

  validation {
    condition     = contains(["dev", "staging", "prod"], var.backend_instance_config.backend_environment)
    error_message = "The allowed backend environments are dev and staging and prod"
  }
}

variable "create_instances" {
  type        = bool
  description = "Whether to create instances or not"
  default     = true
}

variable "instance_count" {
  type        = number
  description = "Number of instances to create"
  default     = 1
  validation {
    condition     = var.instance_count > 0 && var.instance_count < 10
    error_message = "The instance count should be between 1 and 10"
  }
}

variable "run_number" {
  description = "GitHub Actions run number"
  type        = string
}

##### frontend asg variables ######

variable "asg_frontend_min_size" {
  type        = number
  description = "The minimum size of the Auto Scaling Group"
  default     = 1
  validation {
    condition     = var.asg_frontend_min_size >= 1 && var.asg_frontend_min_size <= 3
    error_message = "The minimum size of the Auto Scaling Group should be between 1 and 3"
  }
}

variable "asg_frontend_max_size" {
  type        = number
  description = "The maximum size of the Auto Scaling Group"
  default     = 2
  validation {
    condition     = var.asg_frontend_max_size >= 2 && var.asg_frontend_max_size <= 8
    error_message = "The maximum size of the Auto Scaling Group should be between 2 and 8"
  }
}

variable "asg_frontend_desired_capacity" {
  type        = number
  description = "The desired capacity of the Auto Scaling Group"
  default     = 1
  validation {
    condition     = var.asg_frontend_desired_capacity >= 1 && var.asg_frontend_desired_capacity <= 3
    error_message = "The desired capacity of the Auto Scaling Group should be between 1 and 3"
  }
}

variable "frontend_cpu_utilization_threshold_percentage" {
  type        = number
  description = "The CPU utilization threshold for scaling out"
  default     = 70
  validation {
    condition     = var.frontend_cpu_utilization_threshold_percentage >= 60.0 && var.frontend_cpu_utilization_threshold_percentage <= 90.0
    error_message = "The CPU utilization threshold for scaling out should be between 60 and 90"
  }
}

##### backend asg variables ######

variable "asg_backend_min_size" {
  type        = number
  description = "The minimum size of the Auto Scaling Group"
  default     = 1
  validation {
    condition     = var.asg_backend_min_size >= 1 && var.asg_backend_min_size <= 3
    error_message = "The minimum size of the Auto Scaling Group should be between 1 and 3"
  }
}

variable "asg_backend_max_size" {
  type        = number
  description = "The maximum size of the Auto Scaling Group"
  default     = 2
  validation {
    condition     = var.asg_backend_max_size >= 2 && var.asg_backend_max_size <= 8
    error_message = "The maximum size of the Auto Scaling Group should be between 2 and 8"
  }
}

variable "asg_backend_desired_capacity" {
  type        = number
  description = "The desired capacity of the Auto Scaling Group"
  default     = 1
  validation {
    condition     = var.asg_backend_desired_capacity >= 1 && var.asg_backend_desired_capacity <= 3
    error_message = "The desired capacity of the Auto Scaling Group should be between 1 and 3"
  }
}

variable "backend_cpu_utilization_threshold_percentage" {
  type        = number
  description = "The CPU utilization threshold for scaling out"
  default     = 70
  validation {
    condition     = var.backend_cpu_utilization_threshold_percentage >= 60.0 && var.backend_cpu_utilization_threshold_percentage <= 90.0
    error_message = "The CPU utilization threshold for scaling out should be between 60 and 90"
  }
}