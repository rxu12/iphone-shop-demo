// Naming
variable "app_name" {
  type        = string
  description = "Location of the azure resource group."
  default     = "iphone-search"
}

variable "app_acr_name" {
  type        = string
  description = "name of the azure container registry."
  default     = "iphone-search"
}

variable "location" {
  type        = string
  description = "Location of the azure resource group."
  default     = "EastUS"
}

variable "acr_link" {
  type        = string
  description = "acr link"
}

variable "docker_image_tag" {
  type        = string
  description = "version tag of the image"
  default     = "latest"
}
