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
funcionario= π Fname,Lname,Ssn,Pname,Dno ((employee ⨝ Ssn=Essn works_on ) ⨝ Pnumber=Pno project )
tempo= γ  Pno;  sum(Hours)->Hours (works_on)
projeto= π Pname (σ Pname='Aveiro Digital' (project))
π Fname,Lname (σ Dno=3 ∧ Hours>20 (funcionario⨝projeto⨝tempo))


```


### *e)* 

```
π Fname,Lname, Pno (σ Pno=null (employee ⟕Ssn=Essn works_on))

```


### *f)* 

```
fem= π Fname, Lname, Ssn, Sex, Dno (σ Sex='F' (employee))
salario= γ Dno; avg(Salary)->avgsalario (fem⨝employee)
π Dname, avgsalario (department⨝salario)


```


### *g)* 

```
funcionario= employee ⨝Ssn=Essn dependent
n_dependentes= γ Ssn, Fname, Lname; count(Dependent_name)->dependentes (funcionario)
π Ssn,Fname,Lname (σ dependentes>2 (n_dependentes))

```


### *h)* 

```
func_dep= employee⨝Ssn=Mgr_ssn department
π Ssn, Fname, Lname (σ dependent.Essn=null (func_dep ⟕Ssn=Essn dependent))

```


### *i)* 

```
Proj_Aveiro = σ Plocation='Aveiro' (project)
Dept_Aveiro =  π Dnumber (σ Dlocation='Aveiro' (dept_location))
Dept_n_Aveiro = π Dnumber (department) - Dept_Aveiro
Func_proj_Aveiro = π Fname, Lname, Address, Dno (employee ⨝ (works_on ⨝Pnumber=Pno Proj_Aveiro))
π Fname, Lname, Address (Func_proj_Aveiro ⨝ Dno=Dnumber Dept_n_Aveiro)

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
lista_pacientes = π numUtente (paciente)

lista_pacientes_com_presc = π numUtente (prescricao)

pacientes_sem_Presc = lista_pacientes - lista_pacientes_com_presc

paciente ⨝ (pacientes_sem_Presc)

```

### *b)* 

```
 prescricao_medico=prescricao⨝ numMedico= numSNS medico
 
 γ especialidade; count(numPresc)-> presc (prescricao_medico)
 

```


### *c)* 

```
 prescricao_farmacia=prescricao⨝ farmacia= nome farmacia
 
 γ nome; count(numPresc)-> presc (prescricao_farmacia)
 
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
