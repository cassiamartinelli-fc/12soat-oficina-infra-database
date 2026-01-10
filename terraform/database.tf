# Projeto Neon existente (importado)
# O Neon cria automaticamente:
# - Database padrão: neondb
# - Role padrão: neondb_owner
# - Branch padrão: production
resource "neon_project" "oficina_mecanica" {
  name      = var.project_name
  region_id = var.region
  org_id    = var.neon_org_id

  # Configurações do branch principal
  branch {
    name = "production"
  }

  # Configurações de compute (auto-scaling)
  default_endpoint_settings {
    autoscaling_limit_min_cu = 0.25
    autoscaling_limit_max_cu = 2
    suspend_timeout_seconds  = 0
  }

  # Ajuste: não pedir retenção de histórico maior que o máximo permitido (21600s = 6h)
  requested_history_retention_seconds = 21600

  # Ignora mudanças em atributos gerenciados pelo Neon
  lifecycle {
    ignore_changes = [
      org_id,
      history_retention_seconds,
      pg_version,
      compute_provisioner
    ]
  }
}
