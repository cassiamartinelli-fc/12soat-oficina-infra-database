# Oficina Mecânica - Banco de Dados Gerenciado

Infraestrutura do banco de dados PostgreSQL gerenciado com Neon (serverless).

## 🎯 Propósito

Provisionar e gerenciar o banco de dados PostgreSQL serverless para armazenar dados da aplicação com alta disponibilidade.

## 🛠️ Tecnologias

- **Neon PostgreSQL** - Banco serverless gerenciado
- **Terraform** - Infraestrutura como código
- **TypeORM** - Migrations gerenciadas pela aplicação NestJS
- **GitHub Actions** - CI/CD automático

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

> **Pré-requisito**: Criar conta gratuita no Neon → https://console.neon.tech

### **1. Provisionar Banco PostgreSQL**

Escolha **uma** das opções (ambas criam projeto PostgreSQL serverless com sua própria conta Neon):

#### **Opção A: Terraform (Automatizado)**

```bash
# 1. Obter sua API Key: https://console.neon.tech/app/settings/api-keys
# 2. Configurar localmente
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars: adicionar sua NEON_API_KEY

# 3. Criar infraestrutura
terraform init
terraform apply  # Cria projeto "oficina-mecanica" na SUA conta

# 4. Obter Connection String
terraform output -raw connection_uri
```

📖 [Documentação Terraform](terraform/README.md)

#### **Opção B: Console Web (Manual)**

1. https://console.neon.tech → **Create a project**
2. **Name**: `oficina-mecanica` | **Region**: US East
3. **Connect** → Copiar **Connection String**

---

### **2. Configurar Connection String**

Usar a connection string obtida no passo 1.

Adicionar em **Settings** → **Secrets** → **Actions** dos repositórios:

| Repositório | Secret | Valor |
|-------------|--------|-------|
| `12soat-oficina-app` | `NEON_DATABASE_URL` | Connection string obtida no passo 1 |
| `12soat-oficina-lambda-auth` | `NEON_DATABASE_URL` | Mesma connection string |

### **3. Criar Tabelas**

Tabelas são criadas automaticamente no primeiro deploy de `12soat-oficina-app` (TypeORM migrations).

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

- **Neon Console**: https://console.neon.tech
- **Docs Neon**: https://neon.tech/docs/introduction
- **GitHub Actions**: https://github.com/cassiamartinelli-fc/12soat-oficina-infra-database/actions

## 🧪 Teste (Opcional)

Verificação opcional do banco de dados isoladamente, sem precisar rodar a aplicação.

### **Opção 1: Via Neon Console**

1. Acesse: https://console.neon.tech
2. Selecione o projeto: `oficina-mecanica`
3. Vá em **SQL Editor** (menu lateral)
4. Execute queries SQL:
   ```sql
   -- Ver tabelas criadas (após aplicação rodar pela primeira vez)
   SELECT table_name FROM information_schema.tables
   WHERE table_schema = 'public';

   -- Ver dados de clientes
   SELECT * FROM clientes LIMIT 10;
   ```
5. Vá em **Monitoring** para ver uso de storage

### **Opção 2: Via psql (linha de comando)**

```bash
# Instalar psql (se não tiver) - macOS
brew install postgresql

# Conectar ao banco
psql $NEON_DATABASE_URL

# Comandos úteis:
\dt              # Listar tabelas
\d clientes      # Ver estrutura da tabela clientes
SELECT * FROM clientes;  # Ver dados
\q               # Sair
```

> **Nota**: As tabelas só existirão após a aplicação NestJS rodar pela primeira vez e criar o schema automaticamente.

## 📄 Licença

MIT - Tech Challenge 12SOAT Fase 3
