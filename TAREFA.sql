USE Escola;

--Retornando maior nota de cada aluno
WITH MaiorNota AS (
   SELECT MATRICULA, MAX(NOTA) AS MEDIA
   FROM FREQUENTA
   GROUP BY MATRICULA
 ) SELECT A.NOME, M.MEDIA
 FROM ALUNO A
 INNER JOIN MaiorNota M 
     ON A.MATRICULA = M.MATRICULA

--Retornando MEDIA de cada aluno E MEDIA GERAL
WITH 
MediaAluno AS (
    SELECT MATRICULA, AVG(NOTA) AS MEDIA
    FROM FREQUENTA
    GROUP BY MATRICULA
),
MediaGeral AS (
    SELECT AVG(M.MEDIA) AS MEDIA_GERAL
    FROM MediaAluno M
)
SELECT * 
FROM MediaAluno, MediaGeral;


WITH QtdTurmas AS (
    SELECT 
        p.MATRICULA,
        p.NOME,
        COUNT(t.CODTURMA) AS total_turmas
    FROM PROFESSOR_BSB p
    INNER JOIN ENSINA e ON p.MATRICULA = e.MATRICULA
    INNER JOIN TURMA t ON e.CODTURMA = t.CODTURMA
    GROUP BY p.MATRICULA, p.NOME
)
SELECT 
    NOME, 
    total_turmas
FROM QtdTurmas
WHERE total_turmas > 2;

