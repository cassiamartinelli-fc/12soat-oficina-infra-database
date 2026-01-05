# Oficina Mecânica - Banco de Dados Gerenciado

Infraestrutura do banco de dados PostgreSQL gerenciado com Neon (serverless).

---

## 🎯 Propósito

Provisionar e gerenciar o banco de dados PostgreSQL serverless (Neon) para armazenar dados da aplicação com alta disponibilidade e backups automáticos.

---

## 🛠️ Tecnologias

- **Neon PostgreSQL** - Banco serverless gerenciado (free tier)
- **Terraform** - Infraestrutura como código (planejado)
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
2. Crie um projeto: `oficina-mecanica`
3. Copie a **Connection String**:
   ```
   postgresql://user:password@ep-xxx.us-east-2.aws.neon.tech/oficina_mecanica
   ```

### **2. Configurar Secrets**

Adicione no GitHub de **todos os repositórios** que usam o banco:

**Settings → Secrets → Actions**

| Secret | Valor |
|--------|-------|
| `NEON_DATABASE_URL` | Connection string copiada do Neon |

### **3. Migrations (Automático)**

As tabelas são criadas automaticamente pela aplicação NestJS via TypeORM:

```typescript
// TypeORM configurado com synchronize: true (dev)
// Produção: usar migrations manuais
```

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

## 🔐 Secrets Necessários

Configure em **todos os repositórios** que usam o banco:

| Secret | Descrição |
|--------|-----------|
| `NEON_DATABASE_URL` | Connection string PostgreSQL do Neon |

---

## 🧪 Como Testar

### **Conectar ao Banco (psql)**

```bash
# Instalar psql
brew install postgresql

# Conectar
psql $NEON_DATABASE_URL

# Verificar tabelas
\dt

# Ver dados
SELECT * FROM clientes;
```

### **Verificar via Neon Console**

1. Acesse: https://console.neon.tech
2. Projeto: `oficina-mecanica`
3. **SQL Editor** → execute queries
4. **Monitoring** → veja uso de storage

---

## 🔗 Recursos

- **Neon Console**: https://console.neon.tech
- **Docs Neon**: https://neon.tech/docs/introduction
- **GitHub Actions**: https://github.com/<usuario>/12soat-oficina-infra-database/actions

---

## 📄 Licença

MIT - Tech Challenge 12SOAT Fase 3
