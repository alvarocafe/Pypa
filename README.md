# Jupypa
## Otimização para gerenciamento dos carros-pipa no Nordeste Brasileiro
----
### Implementações em Octave/MATLAB, Julia, Python e R (Jupyter).
Autores: Reinaldo, Ana, Diogo e Luiz
----
Uma implementação do problema de otimização de distribuição de água utilizando carros-pipa em Octave/MATLAB, Julia, Python e R.

As implementações foram realizadas por professores, alunos da graduação e pós graduação do Departamento de Engenharia de Produção e Engenharia Mecânica da Universidade de Brasília em colaboração com o CENAD.

## Instalação
----
Para utilizar todos os programas, é necessário ter os seguintes programas instalados no computador:

- MATLAB 2018
- Julia 1.0
- Python 3
- R 3.5

Implementações em Julia, Python e R foram desenvolvidas para expandir a base de usuários e incentivar o uso de software livre e Open Source em projetos educacionais e governamentais.

Para utilizar o pipa em Julia, ou JuPipa, é necessário adicionar a biblioteca JuMP:

`using JuMP `

Para utilizar o pipa em Python, ou Pypa, é necessário adicionar as bibliotecas numpy, pandas, matplotlib e pulp:

`import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from pulp import * `

E para utilizar em R, ou PipaR, as bibliotecas Rglpk, readtxt e readxl:

`library(Rglpk)

library(readxl)

library(readtxt)`

No caso da JuPipa, o pacote JuMP está disponível no repositório do Julia 1.0 e pode ser instalada com o comando
`] add JuMP`

No caso da Pypa, as bibliotecas podem ser instaladas utilizando o pip ou o conda. Em distribuições como o Anaconda, as bibliotecas já estão inclusas e podem ser apenas chamadas.

No caso do R, em distribuições como o RStudio já estão disponíveis no repositório local. Para instalar em outros casos, é possível obter as bibliotecas pelo CRAN.

## Testes
----
Para facilitar a manutenção do programa, dados de teste são disponibilizados assim como scripts de teste em MATLAB, Julia, Python e R.

## License
---
This project is currently licensed under GNU GPL v.3
