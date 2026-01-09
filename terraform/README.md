# Terraform - Neon PostgreSQL

Infraestrutura como código para provisionar banco PostgreSQL serverless no Neon.

## 🚀 Uso Local

### 1. Configurar credenciais

```bash
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars: adicionar NEON_API_KEY
```

**Obter API Key:** https://console.neon.tech/app/settings/api-keys

⚠️ `terraform.tfvars` está no `.gitignore` - **nunca commitá-lo!**

### 2. Executar

```bash
terraform init
terraform plan              # Ver mudanças
terraform apply             # Aplicar mudanças
terraform output -raw connection_uri  # Ver connection string
```

### 3. Destruir (se necessário)

```bash
terraform destroy  # ⚠️ Deleta o banco!
```

## 📦 Recursos Criados

- **Neon Project**: Projeto PostgreSQL serverless
- **Database**: `neondb` (criado automaticamente pelo Neon)
- **Role**: `neondb_owner` (criado automaticamente)

## 🔧 Outputs

| Output | Descrição |
|--------|-----------|
| `project_id` | ID do projeto Neon |
| `database_host` | Host do banco |
| `database_name` | Nome do database |
| `connection_uri` | Connection string completa (sensitive) |

## 🔄 CI/CD

Para usar via GitHub Actions, configure secret `NEON_API_KEY` e execute workflow **Terraform** ou **Provision Database**.

Veja [../.github/workflows/README.md](../.github/workflows/README.md)
