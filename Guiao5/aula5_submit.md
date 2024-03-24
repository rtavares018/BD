# BD: Guião 5

## ​Problema 5.1

### _a)_

```
π Fname,Lname,Ssn,Pname ((employee ⨝ Ssn=Essn works_on ) ⨝ Pnumber=Pno project )

```

### _b)_

```
carlos = ρ carlos_ssn←Ssn (π Ssn (σ Fname='Carlos' ∧ Minit='D' ∧ Lname='Gomes' (employee)))
funcionarios= π Fname,Lname,Ssn (carlos ⨝ carlos_ssn=Super_ssn employee )
funcionarios

```

### _c)_

```
funcionarios = π Fname,Lname,Ssn,Pname,Pnumber ((employee ⨝ Ssn=Essn works_on ) ⨝ Pnumber=Pno project )
tempo= γ  Pno;  sum(Hours)->Hours (works_on)
π Pname, Hours (tempo ⨝ Pno=Pnumber project)

```

### _d)_

```
funcionario= π Fname,Lname,Ssn,Pname,Dno ((employee ⨝ Ssn=Essn works_on ) ⨝ Pnumber=Pno project )
tempo= γ  Pno;  sum(Hours)->Hours (works_on)
projeto= π Pname (σ Pname='Aveiro Digital' (project))
π Fname,Lname (σ Dno=3 ∧ Hours>20 (funcionario⨝projeto⨝tempo))


```

### _e)_

```
π Fname,Lname, Pno (σ Pno=null (employee ⟕Ssn=Essn works_on))

```

### _f)_

```
fem= π Fname, Lname, Ssn, Sex, Dno (σ Sex='F' (employee))
salario= γ Dno; avg(Salary)->avgsalario (fem⨝employee)
π Dname, avgsalario (department⨝salario)


```

### _g)_

```
funcionario= employee ⨝Ssn=Essn dependent
n_dependentes= γ Ssn, Fname, Lname; count(Dependent_name)->dependentes (funcionario)
π Ssn,Fname,Lname (σ dependentes>2 (n_dependentes))

```

### _h)_

```
func_dep= employee⨝Ssn=Mgr_ssn department
π Ssn, Fname, Lname (σ dependent.Essn=null (func_dep ⟕Ssn=Essn dependent))

```

### _i)_

```
Proj_Aveiro = σ Plocation='Aveiro' (project)
Dept_Aveiro =  π Dnumber (σ Dlocation='Aveiro' (dept_location))
Dept_n_Aveiro = π Dnumber (department) - Dept_Aveiro
Func_proj_Aveiro = π Fname, Lname, Address, Dno (employee ⨝ (works_on ⨝Pnumber=Pno Proj_Aveiro))
π Fname, Lname, Address (Func_proj_Aveiro ⨝ Dno=Dnumber Dept_n_Aveiro)

```

## ​Problema 5.2

### _a)_

```
π nif,nome,fax,endereco,tipo,condpag (σ numero=null (fornecedor ⟕(nif=fornecedor) encomenda))
```

### _b)_

```
γ codProd;avg(unidades)->numUnidades item
```

### _c)_

```
γ numEnc;count(numEnc)-> numUnidades item
```

### _d)_

```
γ fornecedor.nome, produto.nome; sum(item.unidades)->quantidade (π fornecedor.nome, produto.nome,item.unidades (produto ⨝(codigo=codProd) (item ⨝(numEnc=numero) (fornecedor ⨝(nif=fornecedor) encomenda)))) 

```

## ​Problema 5.3

### _a)_

```
lista_pacientes = π numUtente (paciente)

lista_pacientes_com_presc = π numUtente (prescricao)

pacientes_sem_Presc = lista_pacientes - lista_pacientes_com_presc

paciente ⨝ (pacientes_sem_Presc)

```

### _b)_

```
 prescricao_medico=prescricao⨝ numMedico= numSNS medico

 γ especialidade; count(numPresc)-> presc (prescricao_medico)


```

### _c)_

```
 prescricao_farmacia=prescricao⨝ farmacia= nome farmacia

 γ nome; count(numPresc)-> presc (prescricao_farmacia)

```

### _d)_

```
(
	π farmaco.nome (
		σ farmaco.numRegFarm=906 (farmaco)
	)
) - (
	π presc_farmaco.nomeFarmaco (
		σ presc_farmaco.numRegFarm=906 (
			prescricao ⨝ prescricao.numPresc=presc_farmaco.numPresc (presc_farmaco)
		)
	)
)
```

### _e)_

```
γ prescricao.farmacia, farmaceutica.nome; count(presc_farmaco.numRegFarm)->farmacosVendidos (
	farmaceutica ⨝ farmaceutica.numReg=presc_farmaco.numRegFarm (
		presc_farmaco ⨝ presc_farmaco.numPresc=prescricao.numPresc (
			σ prescricao.farmacia!=null (prescricao)
		)
	)
)

```

### _f)_

```
σ numeroMedicosQuePrescreveram>1 (
	γ paciente.numUtente, paciente.nome; count(medico.numSNS)->numeroMedicosQuePrescreveram (
		medico ⨝ medico.numSNS=prescricao.numMedico (
			prescricao ⨝ prescricao.numUtente=paciente.numUtente (paciente)
		)
	)
)
```
