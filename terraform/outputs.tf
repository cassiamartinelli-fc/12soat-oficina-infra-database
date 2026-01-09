output "project_id" {
  description = "ID do projeto no Neon"
  value       = neon_project.oficina_mecanica.id
}

output "database_host" {
  description = "Host do banco de dados"
  value       = neon_project.oficina_mecanica.database_host
}

output "database_name" {
  description = "Nome do banco de dados (padrão criado pelo Neon)"
  value       = neon_project.oficina_mecanica.database_name
}

output "database_user" {
  description = "Usuário do banco de dados"
  value       = neon_project.oficina_mecanica.database_user
  sensitive   = true
}

output "connection_uri" {
  description = "URI completa de conexão (use para NEON_DATABASE_URL)"
  value       = neon_project.oficina_mecanica.connection_uri
  sensitive   = true
}
