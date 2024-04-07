# BD: Guião 6

## Problema 6.1

### _a)_ Todos os tuplos da tabela autores (authors);

```
SELECT *
FROM authors;

```

### _b)_ O primeiro nome, o último nome e o telefone dos autores;

```
SELECT  au_fname, au_lname, phone
FROM authors;
```

### _c)_ Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente);

```
SELECT  au_fname, au_lname, phone
FROM authors
ORDER BY au_fname, au_lname;

```

### _d)_ Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone);

```
SELECT  au_fname AS first_name, au_lname AS last_name, phone AS telephone
FROM authors
ORDER BY au_fname, au_lname;
```

### _e)_ Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’;

```
SELECT  au_fname AS first_name, au_lname AS last_name, state , phone AS telephone
FROM authors
WHERE state='CA' AND au_lname<>'Ringer'
ORDER BY au_fname, au_lname;

```

### _f)_ Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome;

```
SELECT  *
FROM publishers
WHERE pub_name LIKE '%Bo%';
```

### _g)_ Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’;

```
SELECT  DISTINCT pub_name
FROM publishers,titles
WHERE publishers.pub_id= titles.pub_id AND titles.type='business';

```

### _h)_ Número total de vendas de cada editora;

```
SELECT p.pub_name, SUM(s.qty) AS total_sales
FROM publishers p
JOIN titles t ON p.pub_id = t.pub_id
JOIN sales s ON t.title_id = s.title_id
GROUP BY p.pub_name;
```

### _i)_ Número total de vendas de cada editora agrupado por título;

```
SELECT p.pub_name, t.title, SUM(s.qty) AS total_sales
FROM publishers p
JOIN titles t ON p.pub_id = t.pub_id
JOIN sales s ON t.title_id = s.title_id
GROUP BY p.pub_name, t.title;
```

### _j)_ Nome dos títulos vendidos pela loja ‘Bookbeat’;

```
SELECT t.title ,stor_name
FROM titles t
JOIN sales s ON t.title_id = s.title_id
JOIN stores st ON s.stor_id =st.stor_id
WHERE stor_name='Bookbeat'
GROUP BY t.title, st.stor_name

```

### _k)_ Nome de autores que tenham publicações de tipos diferentes;

```
SELECT a.au_id,a.au_fname, a.au_lname
FROM authors a
JOIN titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id = t.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
HAVING COUNT(DISTINCT t.type) > 1;


```

### _l)_ Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
SELECT t.type, t.pub_id, AVG(t.price) AS avg_price, SUM(s.qty) AS total_sales
FROM titles t
LEFT JOIN sales s ON t.title_id = s.title_id
GROUP BY t.type, t.pub_id;
```

### _m)_ Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
SELECT t.type, MAX(t.advance) as max_advance, AVG(t.advance) AS avg_advance
FROM titles t
GROUP BY t.type
HAVING MAX(t.advance) > 1.5 * (SELECT AVG(advance) FROM titles WHERE type = t.type);
```

### _n)_ Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
SELECT ti.title_id, ti.title, au.au_fname, au.au_lname,
SUM(sa.qty * ti.price * ta.royaltyper / 100) AS royalties_earned
FROM authors au
JOIN titleauthor ta ON au.au_id = ta.au_id
JOIN titles ti ON ta.title_id = ti.title_id
JOIN sales sa ON ti.title_id = sa.title_id
GROUP BY ti.title_id, ti.title, au.au_fname, au.au_lname, ta.royaltyper;
```

### _o)_ Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
... Write here your answer ...
```

### _p)_ Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
SELECT t.title, t.ytd_sales, t.price * t.ytd_sales AS total_revenue, SUM(ta.royaltyper / 100 * t.price * t.ytd_sales) AS authors_revenue, (t.price * t.ytd_sales) - SUM(ta.royaltyper / 100 * t.price * t.ytd_sales) AS publisher_revenue
FROM titles t LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
GROUP BY  t.title_id, t.title, t.ytd_sales, t.price;
```

### _q)_ Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
SELECT s.stor_id
FROM sales s
JOIN (SELECT title_id FROM sales GROUP BY title_id) as sold_titles ON s.title_id = sold_titles.title_id
GROUP BY s.stor_id
HAVING COUNT(DISTINCT s.title_id) = (SELECT COUNT(DISTINCT title_id) FROM sales);
```

### _r)_ Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
SELECT s.stor_name
FROM stores s
JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_name
HAVING SUM(sa.qty) > (SELECT AVG(total_qty) FROM (SELECT SUM(qty) AS total_qty FROM sales GROUP BY stor_id) AS avg_sales);

```

### _s)_ Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
SELECT t.title
FROM titles t
WHERE t.title_id NOT IN (
  SELECT s.title_id
  FROM sales s
  JOIN stores st ON s.stor_id = st.stor_id
  WHERE st.stor_name = 'Bookbeat'
)
```

### _t)_ Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora;

```
SELECT p.pub_name, s.stor_name
FROM publishers p
CROSS JOIN stores s
WHERE NOT EXISTS (
    SELECT 1
    FROM sales sa
    JOIN titles t ON sa.title_id = t.title_id AND t.pub_id = p.pub_id
    WHERE sa.stor_id = s.stor_id
)
ORDER BY p.pub_name, s.stor_name;
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script

[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### _a)_

```
SELECT employee.Ssn, employee.Fname, employee.Minit, employee.Lname, works_on.Pno
FROM Company.Employee
JOIN Company.Works_on ON employee.Ssn = works_on.Essn;
```

##### _b)_

```
SELECT E.Fname, E.Minit, E.Lname
FROM Company.Employee AS E
JOIN Company.Employee AS S ON E.Super_ssn = S.Ssn
WHERE S.Fname = 'António' AND S.Minit = 'J' AND S.Lname = 'Santos';
```

##### _c)_

```
SELECT project.Pname, SUM(works_on.Hours) AS TotalH
FROM Company.Project
JOIN Company.Works_on ON project.Pnumber = works_on.Pno
GROUP BY project.Pname;
```

##### _d)_

```
SELECT employee.Fname, employee.Minit, employee.Lname
FROM (Company.Project
      JOIN Company.Works_on ON project.Pnumber = works_on.Pno)
     JOIN Company.Employee ON employee.Ssn = works_on.Essn
WHERE works_on.Hours > 20 AND employee.Dno = 3 AND project.Pname = 'Campanha Publicitária';
```

##### _e)_

```
SELECT employee.Fname, employee.Minit, employee.Lname
FROM (Company.Project
      JOIN Company.Works_on ON project.Pnumber = works_on.Pno)
     JOIN Company.Employee ON employee.Ssn = works_on.Essn
WHERE works_on.Hours > 20 AND employee.Dno = 3 AND project.Pname = 'Campanha Publicitária';
```

##### _f)_

```
SELECT department.Dname, AVG(employee.Salary) AS Avg_salary
FROM Company.Department
JOIN Company.Employee ON department.Dnumber = employee.Dno
WHERE employee.Sex = 'F'
GROUP BY department.Dname;
```

##### _g)_

```
SELECT employee.Fname, employee.Minit, employee.Lname, COUNT(dependent.Dependent_name) AS DepNumb
FROM Company.Employee
JOIN Company.Dependent ON employee.Ssn = dependent.Essn
GROUP BY employee.Fname, employee.Minit, employee.Lname
HAVING COUNT(dependent.Dependent_name) > 2;
```

##### _h)_

```
SELECT employee.Fname, employee.Minit, employee.Lname
FROM (Company.Employee
      JOIN Company.Department ON employee.Ssn = department.Mgr_ssn)
     LEFT OUTER JOIN Company.Dependent ON employee.Ssn = dependent.Essn
WHERE dependent.Essn IS NULL;
```

##### _i)_

```
SELECT DISTINCT employee.Fname, employee.Minit, employee.Lname, employee.Address
FROM (((Company.Works_on
         JOIN Company.Employee ON works_on.Essn = employee.Ssn)
        JOIN Company.Project ON works_on.Pno = project.Pnumber)
       JOIN Company.Dept_location ON project.Dnum = dept_location.Dnumber)
WHERE project.Plocation = 'Lisboa' AND dept_location.Dlocation != 'Edifício E';
```

### 5.2

#### a) SQL DDL Script

[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### _a)_

```
... Write here your answer ...
```

##### _b)_

```
... Write here your answer ...
```

##### _c)_

```
... Write here your answer ...
```

##### _d)_

```
... Write here your answer ...
```

### 5.3

#### a) SQL DDL Script

[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### _a)_

```
... Write here your answer ...
```

##### _b)_

```
... Write here your answer ...
```

##### _c)_

```
... Write here your answer ...
```

##### _d)_

```
... Write here your answer ...
```

##### _e)_

```
... Write here your answer ...
```

##### _f)_

```
... Write here your answer ...
```
