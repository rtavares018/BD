# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
π Fname,Lname,Ssn,Pname ((employee ⨝ Ssn=Essn works_on ) ⨝ Pnumber=Pno project )

```


### *b)* 

```
carlos = ρ carlos_ssn←Ssn (π Ssn (σ Fname='Carlos' ∧ Minit='D' ∧ Lname='Gomes' (employee)))
funcionarios= π Fname,Lname,Ssn (carlos ⨝ carlos_ssn=Super_ssn employee )
funcionarios

```


### *c)* 

```
funcionarios = π Fname,Lname,Ssn,Pname,Pnumber ((employee ⨝ Ssn=Essn works_on ) ⨝ Pnumber=Pno project )
tempo= γ  Pno;  sum(Hours)->Hours (works_on)
π Pname, Hours (tempo ⨝ Pno=Pnumber project)

```


### *d)* 

```
... Write here your answer ...
```


### *e)* 

```
... Write here your answer ...
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
... Write here your answer ...
```


## ​Problema 5.2

### *a)*

```
... Write here your answer ...
```

### *b)* 

```
... Write here your answer ...
```


### *c)* 

```
... Write here your answer ...
```


### *d)* 

```
... Write here your answer ...
```


## ​Problema 5.3

### *a)*

```
... Write here your answer ...
```

### *b)* 

```
... Write here your answer ...
```


### *c)* 

```
... Write here your answer ...
```


### *d)* 

```
... Write here your answer ...
```

### *e)* 

```
... Write here your answer ...
```

### *f)* 

```
... Write here your answer ...
```
