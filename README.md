# Oficina Mecânica - Banco de Dados Gerenciado

Infraestrutura do banco de dados PostgreSQL gerenciado com Neon (serverless).

---

## 🎯 Propósito

Provisionar e gerenciar o banco de dados PostgreSQL serverless para armazenar dados da aplicação com alta disponibilidade.

---

## 🛠️ Tecnologias

- **Neon PostgreSQL** - Banco serverless gerenciado
- **Terraform** - Infraestrutura como código
- **TypeORM** - Migrations gerenciadas pela aplicação NestJS
- **GitHub Actions** - CI/CD automático

---

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

---

## 🚀 Setup

### **1. Criar Banco no Neon**

1. Acesse: https://console.neon.tech
2. Faça login ou crie uma conta (gratuita)
3. Clique em **"Create a project"**
4. Configure:
   - **Project name**: `oficina-mecanica`
   - **Database name**: `oficina_mecanica`
   - **Region**: US East (Ohio) ou sua preferência
5. Clique em **"Create project"**
6. Na tela do projeto, clique em **"Connect"** (no topo)
7. Copie a **Connection String** (formato: `postgres://...`):
   ```
   postgresql://user:password@ep-xxx.us-east-2.aws.neon.tech/oficina_mecanica?sslmode=require
   ```
   > **Importante**: Guarde essa string, você vai precisar dela nos próximos passos!

### **2. Configurar Secrets**

Adicione o secret no GitHub nos repositórios que **usam o banco de dados**:

- **12soat-oficina-app** (aplicação principal)
- **12soat-oficina-lambda-auth** (autenticação consulta clientes)

Em cada repositório, vá em **Settings → Secrets → Actions** e adicione:

| Secret | Valor |
|--------|-------|
| `NEON_DATABASE_URL` | Connection string copiada do Neon |

### **3. Criação das Tabelas**

As tabelas são criadas **automaticamente** quando a aplicação NestJS inicia pela primeira vez.

---

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

---

## 🔗 Recursos

- **Neon Console**: https://console.neon.tech
- **Docs Neon**: https://neon.tech/docs/introduction
- **GitHub Actions**: https://github.com/<usuario>/12soat-oficina-infra-database/actions

---

## 🧪 Teste (Opcional)

Verificação **opcional** do banco de dados isoladamente, sem precisar rodar a aplicação.

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

---

## 📄 Licença

MIT - Tech Challenge 12SOAT Fase 3
