-- Script para verificar alunos no PostgreSQL
-- Execute este script no pgAdmin ou psql

-- 1. Conectar ao banco de dados AlunosDB
\c AlunosDB;

-- 2. Verificar se a tabela Alunos existe
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name = 'Alunos';

-- 3. Verificar a estrutura da tabela Alunos
\d "Alunos";

-- 4. Contar quantos alunos existem na tabela
SELECT COUNT(*) as total_alunos FROM "Alunos";

-- 5. Listar todos os alunos cadastrados
SELECT * FROM "Alunos" ORDER BY "Id";

-- 6. Verificar os últimos alunos cadastrados
SELECT * FROM "Alunos" ORDER BY "Id" DESC LIMIT 5;

-- 7. Verificar se há dados de exemplo
SELECT 
    "Id",
    "Nome", 
    "Email", 
    "Idade",
    'Cadastrado em: ' || NOW() as observacao
FROM "Alunos";

-- 8. Inserir um aluno de teste (opcional)
-- INSERT INTO "Alunos" ("Nome", "Email", "Idade") 
-- VALUES ('Aluno Teste', 'teste@email.com', 25);

-- 9. Verificar logs de erro (se houver)
-- SELECT * FROM pg_stat_activity WHERE datname = 'AlunosDB';
