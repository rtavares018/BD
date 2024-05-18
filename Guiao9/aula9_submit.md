# BD: Guião 9

## ​9.1

### _a)_

```
CREATE PROCEDURE RemoveEmployeeAndDependencies(@ssn CHAR(9))
AS
BEGIN
    DELETE FROM Dependents WHERE ssn = @ssn;
    DELETE FROM Works_on WHERE ssn = @ssn;
    DELETE FROM Employees WHERE ssn = @ssn;
END;


```

### _b)_

```
USE[master]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_dept_managers]

AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Managers TABLE (
    ssn int,
    yearsAsManag int
    )
            INSERT INTO @Managers (ssn, yearsAsManag)
                SELECT Employee.Ssn, DATEDIFF(Year, Company.Department.Mgr_Start_Date, GetDate()) FROM Company.Employee
                    INNER JOIN Company.Department ON Company.Employee.Ssn=Company.Department.Mgr_ssn
                    --ORDER BY Company.Department.Mgr_Start_Date
					WHERE Mgr_start_date = (SELECT MIN(Mgr_start_date) from Company.Department);

    SELECT * FROM @Managers
END
GO
```

### _c)_

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

### _d)_

```
USE[master]
GO

CREATE TRIGGER vencimento_inferior ON Company.Employee AFTER INSERT, UPDATE
AS
	BEGIN
		DECLARE @vencimento_employee AS INT;
        DECLARE @vencimento_manager AS INT;
        DECLARE @ssn AS INT;
		DECLARE @dno AS INT;


		SELECT @ssn=inserted.Ssn, @vencimento_employee=inserted.Salary, @dno=inserted.Dno FROM inserted;
		SELECT @vencimento_manager=Company.Employee.Salary FROM Company.Department
			INNER JOIN Company.Employee ON Company.Department.Mgr_Ssn=Company.Employee.Ssn
			WHERE @dno=Company.Department.Dnumber;

		IF @vencimento_employee > @vencimento_manager
		BEGIN
			UPDATE Company.Employee SET Company.Employee.Salary=@vencimento_manager-1
			WHERE Company.Employee.Ssn=@ssn
		END
	END

SELECT * FROM Company.Employee;
```

### _e)_

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

### _f)_

```
CREATE FUNCTION Company.empregados_mais_bem_pagos (@dno INT)
RETURNS @table TABLE (
    [ssn] INT,
    [fname] VARCHAR(15),
    [lname] VARCHAR(15)
)
AS
BEGIN
    INSERT INTO @table ([ssn], [fname], [lname])
    SELECT e.Ssn, e.Fname, e.Lname
    FROM Company.Employee e
    JOIN (
        SELECT Dno, AVG(Salary) AS avg_sal
        FROM Company.Department d
        JOIN Company.Employee e2 ON d.Dnumber = e2.Dno
        GROUP BY Dno
    ) AS dep_avg_sal ON dep_avg_sal.Dno = e.Dno AND e.Salary > dep_avg_sal.avg_sal
    WHERE e.Dno = @dno;

    RETURN;
END

SELECT Department.Dno, AVG(Employee.Salary) AS avg_sal
    FROM Company.Department
    JOIN Company.Employee ON Department.Dno = Employee.Dnumber
    GROUP BY Department.Dno;
SELECT * FROM Company.Employee;
SELECT * FROM Company.empregados_mais_bem_pagos(1);
SELECT * FROM Company.empregados_mais_bem_pagos(2);
SELECT * FROM Company.empregados_mais_bem_pagos(3);
```

### _g)_

```
... Write here your answer ...
```

### _h)_

```
----------------------------------------------trigger do tipo after---------------------------------------------------------
CREATE TRIGGER delete_to_table_after
ON Department
AFTER DELETE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'myschema' AND TABLE_NAME = 'mytable')
    BEGIN
        CREATE TABLE mytable (
            Dnumber INT,
            Dname VARCHAR(100),
            Mgr_ssn INT,
            Mgr_Start_Date DATE
        );
    END;

    INSERT INTO mytable (Dnumber, Dname, Mgr_ssn, Mgr_Start_Date)
    SELECT Dnumber, Dname, Mgr_ssn, Mgr_Start_Date
    FROM deleted;
END;

--------------------------------------------trigger do tipo instead of-------------------------------------------------------
CREATE TRIGGER delete_to_table_instead_of
ON Company.Department
INSTEAD OF DELETE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'myschema' AND TABLE_NAME = 'mytable')
    BEGIN
        CREATE TABLE mytable (
            Dnumber INT,
            Dname VARCHAR(100),
            Mgr_ssn INT,
            Mgr_Start_Date DATE
        );
    END;

    INSERT INTO mytable (Dnumber, Dname, Mgr_ssn, Mgr_Start_Date)
    SELECT Dnumber, Dname, Mgr_ssn, Mgr_Start_Date
    FROM deleted;

    DELETE FROM Department
    WHERE Dnumber IN (SELECT Dnumber FROM deleted);
END;

-------------------------------------------vantagens e desvantagens------------------------------------------------------------
No caso do trigger AFTER, este é acionado após a execução da instrução, como por exemplo, um DELETE na tabela Department. Portanto, se ocorrer algum erro durante a eliminação dos dados, o trigger não conseguirá impedir a remoção do departamento, o que representa uma desvantagem, pois o torna menos eficiente. No entanto, há várias vantagens associadas a este tipo de trigger: podem existir múltiplos triggers AFTER numa única tabela e eles podem ser usados para processos de validação de dados complexos que envolvam várias tabelas. Além disso, permitem a execução de instruções adicionais após a conclusão da instrução inicial.

Por outro lado, o trigger INSTEAD OF é executado antes da instrução DELETE na tabela Department, substituindo a instrução original. Desta forma, se ocorrer um erro durante o processo de eliminação, o trigger pode impedir que o departamento seja removido, assumindo o controle da execução ou não da instrução desejada. No entanto, este tipo de trigger é geralmente menos flexível do que o AFTER e pode levar a erros inesperados com mais facilidade.
```

### _i)_

````
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
````
