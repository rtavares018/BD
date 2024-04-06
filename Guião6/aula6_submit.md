# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
SELECT * 
FROM authors;

```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
SELECT  au_fname, au_lname, phone 
FROM authors;
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
SELECT  au_fname, au_lname, phone 
FROM authors
ORDER BY au_fname, au_lname;

```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
SELECT  au_fname AS first_name, au_lname AS last_name, phone AS telephone
FROM authors
ORDER BY au_fname, au_lname;
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
SELECT  au_fname AS first_name, au_lname AS last_name, state , phone AS telephone
FROM authors
WHERE state='CA' AND au_lname<>'Ringer'
ORDER BY au_fname, au_lname;

```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
SELECT  *
FROM publishers
WHERE pub_name LIKE '%Bo%';
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
SELECT  DISTINCT pub_name
FROM publishers,titles
WHERE publishers.pub_id= titles.pub_id AND titles.type='business';

```

### *h)* Número total de vendas de cada editora; 

```
SELECT p.pub_name, SUM(s.qty) AS total_sales
FROM publishers p
JOIN titles t ON p.pub_id = t.pub_id
JOIN sales s ON t.title_id = s.title_id
GROUP BY p.pub_name;
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
SELECT p.pub_name, t.title, SUM(s.qty) AS total_sales
FROM publishers p
JOIN titles t ON p.pub_id = t.pub_id
JOIN sales s ON t.title_id = s.title_id
GROUP BY p.pub_name, t.title;
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
SELECT t.title ,stor_name
FROM titles t 
JOIN sales s ON t.title_id = s.title_id
JOIN stores st ON s.stor_id =st.stor_id
WHERE stor_name='Bookbeat'
GROUP BY t.title, st.stor_name

```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
SELECT a.au_id,a.au_fname, a.au_lname
FROM authors a
JOIN titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id = t.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
HAVING COUNT(DISTINCT t.type) > 1;


```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
SELECT t.type, t.pub_id, AVG(t.price) AS avg_price, SUM(s.qty) AS total_sales
FROM titles t
LEFT JOIN sales s ON t.title_id = s.title_id
GROUP BY t.type, t.pub_id;
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
SELECT t.type, MAX(t.advance) as max_advance, AVG(t.advance) AS avg_advance
FROM titles t
GROUP BY t.type
HAVING MAX(t.advance) > 1.5 * (SELECT AVG(advance) FROM titles WHERE type = t.type);
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
SELECT ti.title_id, ti.title, au.au_fname, au.au_lname, 
SUM(sa.qty * ti.price * ta.royaltyper / 100) AS royalties_earned
FROM authors au
JOIN titleauthor ta ON au.au_id = ta.au_id
JOIN titles ti ON ta.title_id = ti.title_id
JOIN sales sa ON ti.title_id = sa.title_id
GROUP BY ti.title_id, ti.title, au.au_fname, au.au_lname, ta.royaltyper;
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
... Write here your answer ...
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
SELECT t.title, t.ytd_sales, t.price * t.ytd_sales AS total_revenue, SUM(ta.royaltyper / 100 * t.price * t.ytd_sales) AS authors_revenue, (t.price * t.ytd_sales) - SUM(ta.royaltyper / 100 * t.price * t.ytd_sales) AS publisher_revenue
FROM titles t LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
GROUP BY  t.title_id, t.title, t.ytd_sales, t.price;
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
SELECT s.stor_id
FROM sales s
JOIN (SELECT title_id FROM sales GROUP BY title_id) as sold_titles ON s.title_id = sold_titles.title_id
GROUP BY s.stor_id
HAVING COUNT(DISTINCT s.title_id) = (SELECT COUNT(DISTINCT title_id) FROM sales);
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
SELECT s.stor_name
FROM stores s
JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_name
HAVING SUM(sa.qty) > (SELECT AVG(total_qty) FROM (SELECT SUM(qty) AS total_qty FROM sales GROUP BY stor_id) AS avg_sales);

```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

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

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

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

##### *a)*

```
... Write here your answer ...
```

##### *b)* 

```
... Write here your answer ...
```

##### *c)* 

```
... Write here your answer ...
```

##### *d)* 

```
... Write here your answer ...
```

##### *e)* 

```
... Write here your answer ...
```

##### *f)* 

```
... Write here your answer ...
```

##### *g)* 

```
... Write here your answer ...
```

##### *h)* 

```
... Write here your answer ...
```

##### *i)* 

```
... Write here your answer ...
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
... Write here your answer ...
```

##### *b)* 

```
... Write here your answer ...
```


##### *c)* 

```
... Write here your answer ...
```


##### *d)* 

```
... Write here your answer ...
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
... Write here your answer ...
```

##### *b)* 

```
... Write here your answer ...
```


##### *c)* 

```
... Write here your answer ...
```


##### *d)* 

```
... Write here your answer ...
```

##### *e)* 

```
... Write here your answer ...
```

##### *f)* 

```
... Write here your answer ...
```
