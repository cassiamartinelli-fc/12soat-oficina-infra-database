# Terraform - Neon PostgreSQL

Infraestrutura como código para provisionar banco PostgreSQL serverless no Neon.

⚠️ **IMPORTANTE:** O banco de produção **já está criado e rodando**. Este Terraform serve apenas para:
- Documentar a infraestrutura existente
- Permitir replicar o ambiente em outra conta Neon (para testes/desenvolvimento)

## 🚀 Replicar ambiente (criar novo banco)

### 1. Criar conta Neon e obter credenciais

- Criar conta gratuita: https://console.neon.tech
- Obter API Key: https://console.neon.tech/app/settings/api-keys
- Obter Org ID: https://console.neon.tech/app/settings/profile

### 2. Configurar variáveis

```bash
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars: adicionar NEON_API_KEY e NEON_ORG_ID
```

⚠️ `terraform.tfvars` está no `.gitignore` - **nunca commitá-lo!**

### 3. Provisionar

```bash
terraform init
terraform plan              # ✅ Sempre execute plan primeiro!
terraform apply             # ⚠️ Cria novo banco (cobra recursos)
terraform output -raw connection_uri  # Copiar connection string
```

### 4. Destruir (quando não precisar mais)

```bash
terraform destroy  # ⚠️ DELETA o banco e TODOS OS DADOS permanentemente!
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

## 🔄 CI/CD via GitHub Actions

⚠️ **ATENÇÃO:** O workflow **Terraform** executa contra o banco de **produção existente**!

- ✅ **plan** — Seguro. Apenas visualiza mudanças sem aplicar
- ⚠️ **apply** — **MODIFICA** o banco de produção (use com cuidado!)
- ✅ **output** — Seguro. Apenas exibe connection string
- ⚠️ **destroy** — **DELETA PERMANENTEMENTE** o banco de produção (NÃO USE!)

**Para replicar ambiente em nova conta:**
1. Configure secrets `NEON_API_KEY` e `NEON_ORG_ID` da sua conta
2. Execute workflow **Terraform** → **apply**
3. Copie connection string do output
