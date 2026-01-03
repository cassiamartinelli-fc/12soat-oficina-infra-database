# 12SOAT - Oficina Mecânica - Database Infrastructure

Infraestrutura do banco de dados gerenciado (Neon PostgreSQL).

## Stack
- Neon PostgreSQL (Free Tier - 512MB)
- Terraform

## Estrutura
```
terraform/           - Infraestrutura como código
.github/workflows/   - CI/CD
```

## Setup

### 1. Criar Banco no Neon

1. Acesse https://neon.tech e crie uma conta
2. Crie um novo projeto chamado "oficina-mecanica"
3. Copie a connection string
4. Adicione ao GitHub Secrets:
   - Nome: `NEON_DATABASE_URL`
   - Valor: `postgresql://user:password@host/database`

### 2. Deploy (Futuro)

```bash
cd terraform
terraform init
terraform apply
```

## Secrets Necessários

- `NEON_DATABASE_URL` - Connection string do Neon PostgreSQL

## Informações do Neon Free Tier

- **Storage**: 512MB (permanente)
- **Conexões**: Ilimitadas
- **Backup**: Automático
- **Custo**: $0 (free tier permanente)
- **Estimativa de uso**: ~17MB inicial, ~65MB após 1 ano

## Schema do Banco

O schema será migrado do repositório atual:
- `clientes`
- `veiculos`
- `servicos`
- `pecas`
- `ordens_servico`
- `item_ordem_servico`
- `peca_ordem_servico`
