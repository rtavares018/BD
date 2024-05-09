# BD: Guião 8

## ​8.1. Complete a seguinte tabela.

Complete the following table.

| #   | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :-- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1   | SELECT \* from Production.WorkOrder                                                                        | 72591 | 0.484 | 531        | 1171      | …          | Clustered Index Scan |            |
| 2   | SELECT \* from Production.WorkOrder where WorkOrderID=1234                                                 |       |       |            |           |            |                      |            |
| 3.1 | SELECT \* FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                              |       |       |            |           |            |                      |            |
| 3.2 | SELECT \* FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                  |       |       |            |           |            |                      |            |
| 4   | SELECT \* FROM Production.WorkOrder WHERE StartDate = '2007-06-25'                                         |       |       |            |           |            |                      |            |
| 5   | SELECT \* FROM Production.WorkOrder WHERE ProductID = 757                                                  |       |       |            |           |            |                      |            |
| 6.1 | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              |       |       |            |           |            |                      |            |
| 6.2 | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              |       |       |            |           |            |                      |            |
| 6.3 | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04'            |       |       |            |           |            |                      |            |
| 7   | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' |       |       |            |           |            |                      |            |
| 8   | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' |       |       |            |           |            |                      |            |

## ​8.2.

### a)

```
CREATE TABLE mytemp (
    rid BIGINT /*IDENTITY (1, 1)*/ NOT NULL,
    at1 INT NULL,
    at2 INT NULL,
    at3 INT NULL,
    lixo varchar(100) NULL
    CONSTRAINT PK_mytemp PRIMARY KEY CLUSTERED (rid)
);
```

### b)

```
Tempo -  73036 milisegundos
Percentagem de fragmentação dos índices - 98,75%
Percentagem de ocupação das páginas dos índices - 68,75%
```

### c)

```
- WITH FILLFACTOR = 65:
Tempo: 76550 ms
- WITH FILLFACTOR = 80:
Tempo: 72496 ms
- WITH FILLFACTOR = 95:
Tempo: 75666 ms
```

### d)

```
Para esta alínea eliminei os fillfactors.

Tempo: 58616 ms
```

### e)

```
Para esta alínea eliminei os fillfactors e mantive o rid do tipo identity.
Tempo sem índices: 58616 ms
Tempo com índices: 101027 ms

Podemos concluir que com os índices o tempo de inserção aumenta significativamente.

Código final:
IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'mytemp') DROP TABLE mytemp

CREATE TABLE mytemp (
    rid BIGINT IDENTITY (1, 1) NOT NULL,
    at1 INT NULL,
    at2 INT NULL,
    at3 INT NULL,
    lixo varchar(100) NULL
    CONSTRAINT PK_mytemp PRIMARY KEY CLUSTERED (rid)
);

-- Criação dos índices
CREATE INDEX IX_mytemp_at1 ON mytemp (at1);
CREATE INDEX IX_mytemp_at2 ON mytemp (at2);
CREATE INDEX IX_mytemp_at3 ON mytemp (at3);
CREATE INDEX IX_mytemp_lixo ON mytemp (lixo);

	-- Record the Start Time
	DECLARE @start_time DATETIME, @end_time DATETIME;
	SET @start_time = GETDATE();
	PRINT @start_time

	-- Generate random records
	DECLARE @val as int = 1;
	DECLARE @nelem as int = 50000;

	SET nocount ON

	WHILE @val <= @nelem
	BEGIN
		DBCC DROPCLEANBUFFERS; -- need to be sysadmin
		INSERT INTO mytemp ( at1, at2, at3, lixo)
		SELECT CAST((RAND() * @nelem) AS INT),
           CAST((RAND() * @nelem) AS INT), CAST((RAND() * @nelem) AS INT),
           'lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo';
    SET @val = @val + 1;
	 END

	 PRINT 'Inserted ' + str(@nelem) + ' total records'
	-- Duration of Insertion Process
	SET @end_time = GETDATE();
	PRINT 'Milliseconds used: ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND,
@start_time, @end_time));
```

## ​8.3.

```
-- i)
CREATE UNIQUE CLUSTERED INDEX idx_employee_ssn ON employee(Ssn);

-- ii)
CREATE INDEX idx_employee_names ON employee(Lname, Fname);

-- iii)
CREATE INDEX idx_employee_dno ON employe(Dno);

-- iv)
CREATE CLUSTERED INDEX idx_works_on ON works_on(Essn, Pno);

-- v)
CREATE CLUSTERED INDEX idx_dependent_essn ON dependent(Essn);

--vi)
CREATE INDEX idx_project_dnum ON project(Dnum);
```

