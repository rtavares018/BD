# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.488 | 552        | 451       |PK_WorkOrder_WorkOrderID  | Clustered Index Scan |    Pretendemos obter todas as rows         |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  |     1  |    0.003   |      278      |      36     |      PK_WorkOrder_WorkOrderID      |       Clustered Index Seek               |         foi mais rapido do que a #1 pois só quisemos obter apenas uma row   |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               |     11  |   0.003     |       278     |        41   |    PK_WorkOrder_WorkOrderID        |     Clustered Index Seek                 |      Obtivemos um tempo maior em relaçao ao anterioir pois aqui tivemos de retirar as rows desde a 10000 ate 10010      |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   |  72591     |  0.488     |    808        |   457       |      PK_WorkOrder_WorkOrderID      |       Clustered Index Seek  |       Esta consulta pega todas as linhas da tabela WorkOrder (IDs de ordem de trabalho variam entre 1 e 72591). Isso explica a alta quantidade de leituras de página e o tempo mais longo de execução.  |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2012-05-14'                                          | 55      |0.522       | 812           | 97          |PK_WorkOrder_WorkOrderID  | Clustered Index Scan |    Obter todas as rows em que o trabalho começou a 2012-05-14   |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   |   9    |0.037       |302            |       53    |     IX_WorkOrder_ProductID       |   Non clusteres Index Seek                   |     Esta consulta mostra uma performance superior em comparação com as anteriores, graças ao uso do índice não clusterizado IX_WorkOrder_ProductID       |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              |   9    |  0.037     |      302      | 38          |      IX_WorkOrder_ProductID       |   Non clusteres Index Seek      |  Nesta com o mesmo numero paginas lidas ainda foi possivel ter menos tempo de execuçao          |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              |72591       |  0.474      |  812          | 42          |       PK_WorkOrder_WorkOrderID  | Clustered Index Scan        |       Apesar do alto numero de paginas lidas o tempo de execuçao é baixo    |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04'            |    1   |      0.474 |    814        |    20       |    PK_WorkOrder_WorkOrderID  | Clustered Index Scan       | tem muitas paginas lidas e o tempo é muito baixo xomparado aos anteriores           |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04' |   1    |      0.474 |       814     | 24          |          PK_WorkOrder_WorkOrderID  | Clustered Index Scan                  |    Esta consulta utiliza um "Clustered Index Scan" para buscar o WorkOrderID e StartDate         |
| 8   | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04' |   1    |      0.474 |       814     | 24          |          PK_WorkOrder_WorkOrderID  | Clustered Index Scan                  |   Esta consulta utiliza um "Clustered Index Scan" para buscar o WorkOrderID e StartDate          |

## ​8.2.

### a)

```
... Write here your answer ...
```

### b)

```
... Write here your answer ...
```

### c)

```
... Write here your answer ...
```

### d)

```
... Write here your answer ...
```

### e)

```
... Write here your answer ...
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

