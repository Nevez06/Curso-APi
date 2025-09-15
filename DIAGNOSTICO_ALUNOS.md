# 🔍 Diagnóstico: Problema ao Carregar Alunos

## 📋 Passos para Verificar se os Alunos Estão Sendo Cadastrados

### 1. 🗄️ **Verificar no pgAdmin**

#### A. Conectar ao PostgreSQL
1. Abra o **pgAdmin**
2. Conecte ao servidor PostgreSQL
3. Navegue até o banco **AlunosDB**

#### B. Executar Consultas SQL
```sql
-- Verificar se a tabela existe
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name = 'Alunos';

-- Contar alunos
SELECT COUNT(*) as total_alunos FROM "Alunos";

-- Listar todos os alunos
SELECT * FROM "Alunos" ORDER BY "Id";
```

### 2. 🚀 **Verificar se a API está Funcionando**

#### A. Testar a API diretamente
1. Abra o terminal na pasta `AlunosApi`
2. Execute: `dotnet run`
3. Acesse: `https://localhost:7278/swagger`
4. Teste o endpoint `GET /api/alunos`

#### B. Usar o arquivo de teste
1. Abra o arquivo `testar_api.http` no VS Code
2. Instale a extensão "REST Client"
3. Execute os testes clicando em "Send Request"

### 3. 🔧 **Verificar Configurações**

#### A. String de Conexão
Verifique se a string de conexão está correta em `appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Port=5432;Database=AlunosDB;Username=postgres;Password=123456"
  }
}
```

#### B. Migrações
Execute as migrações se necessário:
```bash
cd AlunosApi
dotnet ef database update
```

### 4. 🌐 **Verificar o Frontend**

#### A. URL da API
Verifique se a URL no `Alunos.js` está correta:
```javascript
const API_URL = "https://localhost:7278/api/alunos";
```

#### B. CORS
Verifique se o CORS está configurado no `Program.cs`:
```csharp
policy.WithOrigins("http://localhost:3000")
```

### 5. 🐛 **Possíveis Problemas e Soluções**

#### Problema: Erro de Conexão com o Banco
**Solução:**
- Verificar se o PostgreSQL está rodando
- Verificar usuário e senha
- Verificar se o banco `AlunosDB` existe

#### Problema: Erro de CORS
**Solução:**
- Verificar se o frontend está rodando na porta 3000
- Verificar configuração CORS no backend

#### Problema: Certificado SSL
**Solução:**
- Acessar `http://localhost:5000` em vez de `https://localhost:7278`
- Ou aceitar o certificado SSL no navegador

#### Problema: Tabela não existe
**Solução:**
```bash
cd AlunosApi
dotnet ef migrations add InitialCreate
dotnet ef database update
```

### 6. 📊 **Comandos Úteis para Diagnóstico**

```bash
# Verificar se o projeto compila
dotnet build

# Executar o projeto
dotnet run

# Verificar migrações
dotnet ef migrations list

# Aplicar migrações
dotnet ef database update

# Verificar logs detalhados
dotnet run --verbosity detailed
```

### 7. 🔍 **Logs para Verificar**

#### A. Logs do Backend
Verifique o console onde está rodando `dotnet run` para erros.

#### B. Logs do Frontend
Abra o DevTools do navegador (F12) e verifique:
- Console (erros JavaScript)
- Network (requisições HTTP)

### 8. ✅ **Teste Rápido**

Execute este comando para testar a API:
```bash
curl -k https://localhost:7278/api/alunos
```

Se retornar `[]` (array vazio), a API está funcionando mas não há alunos.
Se retornar erro, há problema de conexão.

---

## 🆘 **Se Nada Funcionar**

1. **Reiniciar tudo:**
   - Parar o backend (Ctrl+C)
   - Parar o frontend (Ctrl+C)
   - Reiniciar PostgreSQL
   - Executar `dotnet run` novamente
   - Executar `npm start` novamente

2. **Verificar logs detalhados:**
   - Backend: Console do `dotnet run`
   - Frontend: DevTools do navegador
   - PostgreSQL: Logs do servidor

3. **Testar com dados de exemplo:**
   - Usar o arquivo `testar_api.http`
   - Inserir dados diretamente no pgAdmin
