# Oficina Mecânica — Infraestrutura do Banco de Dados

Provisionamento automatizado do banco de dados PostgreSQL serverless (Neon) via Terraform e GitHub Actions.

## 🎯 Propósito

Provisionar e gerenciar banco de dados PostgreSQL serverless com Terraform, integrando CI/CD para deploy automatizado da infraestrutura de dados.

## 🛠️ Tecnologias

- **Neon PostgreSQL** — Banco serverless gerenciado (free tier)
- **Terraform** — Infraestrutura como código
- **GitHub Actions** — CI/CD para provisionamento
- **TypeORM** — Migrations gerenciadas pela aplicação NestJS

## 📁 Estrutura do Banco

```
Schema: oficina_mecanica

Tabelas:
├── clientes             - Dados cadastrais (CPF/CNPJ, nome, telefone)
├── veiculos             - Veículos dos clientes (placa, modelo, marca, ano)
├── servicos             - Serviços oferecidos (nome, preço, tempo estimado)
├── pecas                - Peças disponíveis (nome, preço, estoque)
├── ordens_servico       - Ordens de serviço (status, valores, datas)
├── item_ordem_servico   - Serviços de uma OS (quantidade, valor)
└── peca_ordem_servico   - Peças de uma OS (quantidade, valor)
```

## 🚀 Setup

O banco de dados **já está criado e rodando em produção**. Secrets `NEON_DATABASE_URL` já estão configurados nos repositórios `oficina-app` e `lambda-auth`.

**Para usar o banco existente:**
```bash
# 1. Clonar repositórios
git clone https://github.com/cassiamartinelli-fc/12soat-oficina-app
git clone https://github.com/cassiamartinelli-fc/12soat-oficina-lambda-auth
git clone https://github.com/cassiamartinelli-fc/12soat-oficina-infra-k8s

# 2. Seguir instruções de deploy de cada repositório
# A aplicação conecta automaticamente ao banco Neon em produção
```

## ⚙️ Workflow (GitHub Actions)

⚠️ **IMPORTANTE:** Este workflow executa contra o banco de **produção existente**. Use com cuidado!

### Terraform

```
Actions → Terraform → Run workflow
Escolher: plan | apply | output | destroy
```

- ✅ **plan** — Seguro. Visualiza mudanças sem aplicá-las
- ⚠️ **apply** — **MODIFICA** o banco de produção
- ✅ **output** — Seguro. Exibe connection string
- ⚠️ **destroy** — **DELETA PERMANENTEMENTE** o banco e todos os dados

Para replicar ambiente em sua própria conta Neon:

📖 Ver [Documentação Terraform](terraform/README.md)

## 📄 Arquitetura

```
┌─────────────────────────────────────┐
│   Neon PostgreSQL (Serverless)      │
│   Region: aws-us-east-1             │
│   Database: neondb                  │
└──────────┬──────────────────────────┘
           │
           ├─── oficina-app (NestJS + TypeORM)
           └─── lambda-auth (validação CPF)
```

## 📊 Diagrama ER

```
┌─────────────┐
│  clientes   │
└──────┬──────┘
       │ 1:N
       ▼
┌─────────────┐       ┌──────────────────┐
│  veiculos   │──────▶│ ordens_servico   │
└─────────────┘  1:N  └────────┬─────────┘
                               │ 1:N
                     ┌─────────┴─────────┐
                     │                   │
                     ▼                   ▼
            ┌──────────────────┐  ┌──────────────────┐
            │ item_ordem_srv   │  │ peca_ordem_srv   │
            └────────┬─────────┘  └────────┬─────────┘
                     │ N:1                 │ N:1
                     ▼                     ▼
            ┌──────────────┐      ┌──────────────┐
            │  servicos    │      │    pecas     │
            └──────────────┘      └──────────────┘
```

## 🔗 Recursos

- **Banco em produção**: https://console.neon.tech (projeto `oficina-mecanica`)
- **GitHub Actions**: https://github.com/cassiamartinelli-fc/12soat-oficina-infra-database/actions
- **Repositórios relacionados**:
  - [12soat-oficina-app](https://github.com/cassiamartinelli-fc/12soat-oficina-app)
  - [12soat-oficina-lambda-auth](https://github.com/cassiamartinelli-fc/12soat-oficina-lambda-auth)
  - [12soat-oficina-infra-k8s](https://github.com/cassiamartinelli-fc/12soat-oficina-infra-k8s)

## 🔐 CI/CD — Secrets e permissões

**Secrets necessários (Settings → Secrets → Actions):**
- `NEON_API_KEY` — API Key do Neon para provisionar recursos: https://console.neon.tech/app/settings/api-keys
- `NEON_ORG_ID` — Organization ID do Neon: https://console.neon.tech/app/settings/profile


## 🧪 Validação

```bash
# 1. Obter connection string após terraform apply
cd terraform
terraform output -raw connection_uri

# 2. Conectar ao banco (substituir pela connection string real)
psql "<connection_string_obtida_no_passo_1>"

# 3. Comandos úteis:
\dt                      # Listar tabelas
\d clientes              # Ver estrutura da tabela
SELECT * FROM clientes;  # Ver dados
\q                       # Sair
```

## 📄 Licença

MIT — Tech Challenge 12SOAT Fase 3
