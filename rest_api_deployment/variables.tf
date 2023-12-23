variable "VPC_CIDR" {
  type = string
  description = "CIDR range for VPC"
  default = "10.0.0.0/16"
}

variable "vpc_public_subnet_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
  default     = "10.0.1.0/24"
}

variable "vpc_private_subnet_cidr" {
  type        = string
  description = "Private Subnet CIDR values"
  default     = "10.0.3.0/24"
}

variable "vpc_subnet_zone_ap_south_1a" {
  type        = string
  description = "Public Subnet Availability zone"
  default     = "ap-south-1a"
}

variable "vpc_subnet_zone_ap_south_1b" {
  type        = string
  description = "Public Subnet Availability zone"
  default     = "ap-south-1b"
}

variable "vpc_subnet_zone_ap_south_1c" {
  type        = string
  description = "Public Subnet Availability zone"
  default     = "ap-south-1c"
}