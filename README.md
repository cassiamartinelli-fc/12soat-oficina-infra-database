# Oficina Mecânica - Banco de Dados Gerenciado

Infraestrutura do banco de dados PostgreSQL serverless (Neon) para a aplicação Oficina Mecânica.

## 🎯 Propósito

Provisionar e gerenciar o banco de dados PostgreSQL serverless para armazenar dados da aplicação com alta disponibilidade.

## 🛠️ Tecnologias

- **Neon PostgreSQL** - Banco serverless gerenciado
- **Terraform** - Infraestrutura como código
- **TypeORM** - Migrations gerenciadas pela aplicação NestJS
- **GitHub Actions** - CI/CD para provisionamento

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

### **Opção A: Usar banco em produção (Recomendado para avaliação)**

O banco já está criado e configurado. Secrets `NEON_DATABASE_URL` já estão nos repositórios `oficina-app` e `lambda-auth`.

```bash
# 1. Clonar repositórios
git clone https://github.com/cassiamartinelli-fc/12soat-oficina-app
git clone https://github.com/cassiamartinelli-fc/12soat-oficina-lambda-auth
git clone https://github.com/cassiamartinelli-fc/12soat-oficina-infra-k8s

# 2. Deploy da aplicação (ver README de cada repo)
cd 12soat-oficina-app
kubectl apply -f k8s/

# 3. Aplicação conecta automaticamente ao banco Neon em produção
```

### **Opção B: Criar próprio banco Neon**

Para replicar o ambiente em sua própria conta Neon:

```bash
# 1. Criar conta gratuita: https://console.neon.tech
# 2. Obter API Key: https://console.neon.tech/app/settings/api-keys

# 3. Provisionar via Terraform
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars: adicionar NEON_API_KEY

terraform init
terraform apply

# 4. Obter connection string
terraform output -raw connection_uri

# 5. Configurar secrets nos repos oficina-app e lambda-auth
# Settings → Secrets → Actions → Add: NEON_DATABASE_URL
```

📖 [Documentação Terraform](terraform/README.md)

## 📄 Arquitetura

```
┌─────────────────────────────────────┐
│   Neon PostgreSQL (Serverless)      │
│   Region: us-east-1                 │
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

## 🧪 Validação

```bash
# Instalar psql (se não tiver) - macOS
brew install postgresql

# Conectar ao banco
psql "postgresql://neondb_owner:npg_rSLf9wQDRcb8@ep-summer-mountain-ad4oe55j-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require"

# Comandos úteis:
\dt              # Listar tabelas
\d clientes      # Ver estrutura da tabela clientes
SELECT * FROM clientes;  # Ver dados
\q               # Sair
```

---

## 📄 Licença

MIT - Tech Challenge 12SOAT Fase 3
