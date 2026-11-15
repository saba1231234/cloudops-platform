variable "aws_region" {
  description = "AWS region for CloudOps infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "ssh_allowed_ip" {
  description = "Public IP address allowed to connect through SSH"
  type        = string
}