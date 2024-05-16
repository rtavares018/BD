# BD: Guião 9


## ​9.1
 
### *a)*

```
CREATE PROCEDURE RemoveEmployeeAndDependencies(@ssn CHAR(9))
AS
BEGIN
    DELETE FROM Dependents WHERE ssn = @ssn;
    DELETE FROM Works_on WHERE ssn = @ssn;
    DELETE FROM Employees WHERE ssn = @ssn;
END;


```

### *b)* 

```
... Write here your answer ...
```

### *c)* 

```
CREATE TRIGGER tr_check_manager_assignment
ON Company.Department
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT Mgr_ssn
        FROM Company.Department
        WHERE Mgr_ssn IN (
            SELECT Mgr_ssn
            FROM inserted
        )
        GROUP BY Mgr_ssn
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR ('Já é gestor de outro departamento.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;

```

### *d)* 

```
... Write here your answer ...
```

### *e)* 

```
CREATE FUNCTION GetEmployeeProjects(@ssn CHAR(9))
RETURNS TABLE
AS
RETURN (
    SELECT p.name, p.location
    FROM Projects p
    JOIN Works_on w ON p.Pnumber = w.Pno
    WHERE w.essn = @ssn
);

```

### *f)* 

```
... Write here your answer ...
```

### *g)* 

```
... Write here your answer ...
```

### *h)* 

```
... Write here your answer ...
```

### *i)* 

```
Stored Procedures (SP)
Mais-valias:

Extensibility (Extensibilidade):

As stored procedures são ótimas para abstrair e desacoplar a base de dados, encapsulando a lógica de negócio e fornecendo extensibilidade a longo prazo.
Performance (Desempenho):

Uma stored procedure bem escrita é a forma mais rápida de executar código SQL no servidor, mantendo a execução do código centrado nos dados, o que facilita a indexação e otimização da base de dados.

Usability (Usabilidade):

É mais fácil para os programadores de aplicações fazerem chamadas a stored procedures e consumir os resultados do que escrever SQL ad hoc.
Data Integrity (Integridade dos Dados):

Uma stored procedure desenvolvida por um DBA é menos propensa a conter erros de integridade de dados e é mais fácil de testar do que código SQL ad hoc.

Security (Segurança):

Proteger as tabelas e fornecer acesso apenas através de stored procedures é uma prática recomendada para o desenvolvimento de bases de dados.

Características:

Retorno: Podem retornar zero, um ou múltiplos valores.
Parâmetros: Aceitam parâmetros de entrada e saída.
Uso de SELECT/WHERE/HAVING: Não podem ser usadas diretamente em instruções SELECT, WHERE ou HAVING.
Chamada de SP: Podem chamar outras stored procedures.
Tratamento de Exceções: Suportam tratamento de exceções.
Transações: Suportam transações.

Exemplos de uso:

Quando temos várias aplicações escritas em diferentes linguagens, ou rodam em plataformas diferentes, porém executam a mesma função (no BD).

UDF:

Extensibility (Extensibilidade):

UDFs promovem a reutilização de lógica de consulta e são úteis para encapsular cálculos que podem ser usados em várias consultas.
Performance (Desempenho):

Podem melhorar o desempenho ao simplificar consultas complexas, embora em alguns casos específicos possam introduzir overhead.
Usability (Usabilidade):

Facilita a leitura e manutenção do código, pois encapsulam lógica comum que pode ser reutilizada.
Data Integrity (Integridade dos Dados):

Promovem a consistência ao garantir que cálculos e lógica de negócios são aplicados uniformemente.
Características:

Suporta: Escalares,Inline table-valued ,Multi-statement table-valued functions
Parâmetros: Aceitam apenas parâmetros de entrada.
Uso de SELECT/WHERE/HAVING: Podem ser usadas diretamente em instruções SELECT, WHERE ou HAVING.
Chamada de SP: Não podem chamar stored procedures.
Tratamento de Exceções: Não suportam tratamento de exceções de forma robusta.
Transações: Não suportam transações de forma robusta.
Exemplos de uso:

Cálculos que são reutilizados em várias consultas.
Simplificação de consultas complexas.
Implementação de regras de negócios simples e consistentes.


Comparação de SP versus UDF
SP:

Podem retornar zero, um ou múltiplos valores.
Aceitam parâmetros de entrada e saída.
Não podem ser usadas diretamente em SELECT, WHERE ou HAVING.
Podem chamar outras SPs.
Suportam tratamento de exceções.
Suportam transações.
UDF:

Retornam um único valor escalar ou uma tabela.
Aceitam apenas parâmetros de entrada.
Podem ser usadas diretamente em SELECT, WHERE ou HAVING.
Não podem chamar SPs.
Não suportam tratamento de exceções de forma robusta.
Não suportam transações de forma robusta.
Esta comparação destaca as diferentes capacidades e cenários de uso para SPs e UDFs, ajudando a escolher a ferramenta adequada para cada necessidade específica de desenvolvimento e manutenção de bases de dados.```
