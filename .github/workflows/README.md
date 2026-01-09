# GitHub Actions Workflows

## Workflows disponíveis

### 1. Terraform (`terraform.yml`)
Gerencia infraestrutura do banco Neon via Terraform.

**Executa automaticamente em:**
- PRs: `terraform plan` + comentário no PR
- Push na main: `terraform plan` (validação)

**Executar manualmente:**
```
Actions → Terraform → Run workflow → Escolher: plan/apply/destroy
```

### 2. Provision Database (`provision-db.yml`)
Provisiona banco e exibe connection string.

**Executar manualmente:**
```
Actions → Provision Database → Run workflow → Escolher: plan/apply/output
```

**Output:** Exibe connection string para configurar como secret `NEON_DATABASE_URL`.

## Secrets necessários

Configure em **Settings → Secrets → Actions**:

| Secret | Obter em |
|--------|----------|
| `NEON_API_KEY` | https://console.neon.tech/app/settings/api-keys |

## Segurança

- ✅ Secrets nunca expostos nos logs
- ✅ `apply` e `destroy` apenas em branch `main`
- ✅ PRs executam apenas `plan` (read-only)
