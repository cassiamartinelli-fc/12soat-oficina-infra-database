# GitHub Actions Workflows

## 🚀 Terraform Workflow

Workflow para gerenciar infraestrutura do Neon Database via Terraform.

### Quando executa automaticamente

- **Pull Request**: Executa `terraform plan` e comenta o resultado no PR
- **Push na main**: Executa `terraform plan` para validação
- **Manual (workflow_dispatch)**: Permite escolher entre `plan`, `apply` ou `destroy`

### Como executar manualmente

1. Vá em **Actions** → **Terraform**
2. Clique em **Run workflow**
3. Selecione a ação:
   - **plan**: Visualizar mudanças sem aplicar
   - **apply**: Aplicar mudanças na infraestrutura (⚠️ apenas em main)
   - **destroy**: Destruir toda a infraestrutura (⚠️ use com extremo cuidado!)

### Secrets necessários

Configure em **Settings** → **Secrets and variables** → **Actions**:

| Secret | Descrição | Como obter |
|--------|-----------|------------|
| `NEON_API_KEY` | API Key do Neon | https://console.neon.tech/app/settings/api-keys |

### ⚠️ Segurança

- `NEON_API_KEY` é passada como variável de ambiente (`TF_VAR_neon_api_key`)
- Nunca é exposta nos logs
- Apenas branches `main` podem executar `apply` ou `destroy`
- PRs executam apenas `plan` (read-only)

### 📊 Artifacts

O workflow salva o plano do Terraform como artifact por 7 dias para auditoria.

### Exemplo de uso

#### Criar nova infraestrutura
```bash
# Via workflow manual
Actions → Terraform → Run workflow → apply
```

#### Destruir infraestrutura
```bash
# Via workflow manual (⚠️ CUIDADO!)
Actions → Terraform → Run workflow → destroy
```

#### Validar mudanças antes de merge
```bash
# Abra um PR - o plan será comentado automaticamente
```
