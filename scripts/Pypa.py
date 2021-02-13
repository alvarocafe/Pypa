#!/usr/bin/env python
# coding: utf-8

# # Pypa - Modelo de otimização de rotas de carros-pipa utilizando Python
# 
# Para construir o modelo do problema de otimização, busca-se minimizar uma função objetivo $f(x)$, 
# 
# $min(f^T \cdot x) $
# 
# sujeito a restrições do tipo
# 
# $A \cdot x \leq b$
# 
# sendo que $x = [x_1,x_2,...,x_n]$ são as variáveis do problema, $f = [c_1,c_2,...c_n]$ são os coeficientes da função objetivo, $A$ é uma matriz $n \times m$ e $b=[b_1,b_2,...,b_m]$ com $b_j \geq 0$. 
# 
# Caso em que cada destino pode receber apenas de uma origem.

# In[1]:


from pulp import *


# In[2]:


# Os arquivos eles estão na mesma na mesma pasta que os cadernos
ofertatxt = open('../dados/quixada_oferta.txt','r')
demandatxt = open('../dados/quixada_demanda.txt','r')
distanciastxt = open('../dados/quixada_distancias.txt','r')


# In[3]:


mOferta = list(map(int,ofertatxt.read().split()))
mDemanda = list(map(int,demandatxt.read().split()))


# In[4]:


mDistancias = list(distanciastxt.read().split())
for i in range(len(mDistancias)):
    mDistancias[i] = int(round(float(mDistancias[i].replace('.','').replace(',','.'))))


# In[5]:


mDistancias


# In[6]:


# Agora vamos construir a matriz de distâncias
cont = 0
ldemanda = []
Distancias =[]
# Os valores serão adicionados linha a linha
for i in range(len(mDemanda)):
    for j in range(len(mOferta)):
        ldemanda.append(mDistancias[cont])
        cont += 1
    Distancias.append(ldemanda)
    ldemanda = []
ofertatxt.close()
demandatxt.close()
distanciastxt.close()


# In[7]:


Distancias


# In[8]:


prob = LpProblem("mainPulp",LpMinimize)


# In[9]:


Varx = LpVariable.dicts("Varx",[(i,j) for i in range(len(mDemanda)) for j in range(len(mOferta))],0,None,LpInteger)


# In[10]:


# Objetivo
# Demanda[i][1]*
prob += lpSum(Distancias[i][j] * Varx[(i,j)] for i in range(len(mDemanda)) for j in range(len(mOferta)))


# In[11]:


prob


# In[12]:


for i in range(len(mDemanda)):
    prob += lpSum(Varx[(i,j)] for j in range(len(mOferta))) == mDemanda[i]


# In[13]:


for i in range(len(mOferta)):
    # Demanda[j][1]*
    prob += lpSum(Varx[(j,i)] for j in range(len(mDemanda))) <= mOferta[i]         


# In[14]:


prob.solve()


# In[15]:


for i in prob.variables():
    if i.varValue > 0:
        print(i.name,' carros = ',i.varValue)


# In[ ]:




