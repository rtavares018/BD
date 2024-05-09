# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.488 | 552        | 451       |PK_WorkOrder_WorkOrderID  | Clustered Index Scan |    Pretendemos obter todas as rows         |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  |     1  |    0.003   |      278      |      36     |      PK_WorkOrder_WorkOrderID      |       Clustered Index Seek               |         foi mais rapido do que a #1 pois só quisemos obter apenas uma row   |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               |     11  |   0.003     |       278     |        41   |    PK_WorkOrder_WorkOrderID        |     Clustered Index Seek                 |      Obtivemos um tempo maior em relaçao ao anterioir pois aqui tivemos de retirar as rows desde a 10000 ate 10010      |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   |  72591     |  0.488     |    808        |   457       |      PK_WorkOrder_WorkOrderID      |       Clustered Index Seek  |        porqu ler 722591????    |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2012-05-14'                                          | 55      |0.522       | 812           | 97          |PK_WorkOrder_WorkOrderID  | Clustered Index Scan |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   |   9    |0.037       |302            |       53    |     IX_WorkOrder_ProductID       |   Non clusteres Index Seek                   |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              |   9    |  0.037     |      302      | 38          |      IX_WorkOrder_ProductID       |   Non clusteres Index Seek      |            |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              |72591       |  0.474      |  812          | 42          |       PK_WorkOrder_WorkOrderID  | Clustered Index Scan        |            |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04'            |    1   |      0.474 |    814        |    20       |    PK_WorkOrder_WorkOrderID  | Clustered Index Scan       |            |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04' |   1    |      0.474 |       814     | 24          |          PK_WorkOrder_WorkOrderID  | Clustered Index Scan                  |            |
| 8   | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04' |   1    |      0.474 |       814     | 24          |          PK_WorkOrder_WorkOrderID  | Clustered Index Scan                  |            |

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
... Write here your answer ...
```
