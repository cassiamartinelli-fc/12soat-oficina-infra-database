variable "neon_api_key" {
  description = "Neon API Key"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Nome do projeto no Neon"
  type        = string
  default     = "oficina-mecanica"
}

variable "database_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "oficina"
}

variable "database_owner" {
  description = "Nome do usuário owner do banco"
  type        = string
  default     = "oficina_user"
}

variable "region" {
  description = "Região do Neon (aws-us-east-2, aws-us-west-2, etc)"
  type        = string
  default     = "aws-us-east-2"
}
