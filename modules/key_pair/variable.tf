variable "key_name" {
  type        = string
  default     = "wordpress-key"
  description = "Name for the SSH key pair"
}

variable "private_key_output_path" {
  type        = string
  default     = "mykey.pem"
  description = "Local path to save the private key"
}
