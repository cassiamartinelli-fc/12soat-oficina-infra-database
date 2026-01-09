# Terraform - Neon PostgreSQL Database

Este diretório contém a infraestrutura como código (IaC) para provisionar o banco de dados PostgreSQL no Neon.

## 📋 Pré-requisitos

1. **Terraform** instalado (>= 1.0)
   ```bash
   brew install terraform  # macOS
   ```

2. **Neon API Key**
   - Acesse: https://console.neon.tech/app/settings/api-keys
   - Clique em "Generate new API key"
   - Copie a chave gerada

## 🚀 Como usar

### 1. Configurar credenciais

Copie o arquivo de exemplo e preencha suas credenciais:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edite `terraform.tfvars` e adicione sua Neon API Key:

```hcl
neon_api_key = "sua-chave-aqui"
```

⚠️ **IMPORTANTE**: O arquivo `terraform.tfvars` está no `.gitignore` e **NÃO deve ser commitado**!

### 2. Inicializar Terraform

```bash
terraform init
```

### 3. Planejar mudanças

```bash
terraform plan
```

### 4. Aplicar infraestrutura

```bash
terraform apply
```

Digite `yes` quando solicitado.

### 5. Obter connection string

Após o apply, você pode obter a connection string:

```bash
terraform output -raw connection_uri
```

Copie esse valor e use como `NEON_DATABASE_URL` nos outros repositórios.

## 🗑️ Destruir infraestrutura

Para remover todos os recursos criados:

```bash
terraform destroy
```

⚠️ **ATENÇÃO**: Isso irá deletar o banco de dados e todos os dados! Use com cuidado.

## 📊 Recursos criados

- **Neon Project**: Projeto no Neon
- **Neon Database**: Banco de dados PostgreSQL
- **Neon Role**: Usuário com permissões no banco

## 🔒 Segurança

- ✅ API Key armazenada em `terraform.tfvars` (não commitado)
- ✅ Connection string marcada como `sensitive` no Terraform
- ✅ Para CI/CD, use GitHub Secrets: `NEON_API_KEY`

## 📝 Outputs disponíveis

| Output | Descrição |
|--------|-----------|
| `project_id` | ID do projeto no Neon |
| `database_host` | Host do banco de dados |
| `database_name` | Nome do banco de dados |
| `connection_uri` | URI completa de conexão (sensível) |
| `database_user` | Usuário do banco (sensível) |

## 🔄 Integração com CI/CD

Para usar no GitHub Actions, adicione o secret `NEON_API_KEY` e use:

```yaml
- name: Terraform Apply
  env:
    TF_VAR_neon_api_key: ${{ secrets.NEON_API_KEY }}
  run: |
    cd terraform
    terraform init
    terraform apply -auto-approve
```
