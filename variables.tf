variable "name" {
  description = "Name prefix"
}

variable "internal" {
  description = "LB Internal or not"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "LB Type"
  default     = "application"
}

variable "subnets" {
  description = "List of Subnet IDs"
  type        = list(any)
  default     = []
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection or not"
  type        = bool
  default     = false
}

variable "ip_address_type" {
  description = "IP Address Type of the LB"
  default     = "ipv4"
}

variable "subnet_mapping" {
  description = "Subnet for the LB"
  type        = list(map(string))
  default     = []
}

variable "security_groups" {
  description = "Security Group for the ALB"
  type = list
  default = []
}