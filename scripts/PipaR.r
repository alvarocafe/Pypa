
# Inclua as bibliotecas para ler Excel e Programação Linear
library(Rglpk)
library(readxl)
library(Matrix)
library(optimbase)
library(tibble)

distancias <- read.delim("../dados/exemplo_distancias.txt", header=FALSE)
oferta <- read.delim("../dados/exemplo_oferta.txt", header=FALSE)
demanda <- read.delim("../dados/exemplo_demanda.txt", header=FALSE)

# Precisamos alocar as matrizes com os tamanhos da oferta e demanda
n_ofer <- nrow(oferta)
n_dema <- nrow(demanda)

distancias

# A função f é uma matriz de uma linha e n_oferta * n_demanda colunas
funcao_f <- matrix(nrow = 1 , ncol =  n_ofer*n_dema)
for (i in 1:n_dema){
  for (j in 1:n_ofer){
    funcao_f[(j+(i-1)*n_ofer)] <- distancias[i,j]
      #*demanda[i,1]
  }
}
funcao_f[is.na(funcao_f)] <- 0 # quando nan (Not A Number), substituir por zero
obj <- funcao_f # Definimos a função objetivo como f

funcao_f

funcao_A <- matrix(nrow = n_ofer, ncol = n_dema*n_ofer)
for (i in 1:n_ofer){
  for (j in 1:n_dema){        
      # Cada linha recebe os valores da demanda
    funcao_A[i,i+(j-1)*n_ofer] <- 1
      #as.matrix(demanda[j,1]) 
  }
}
funcao_A[is.na(funcao_A)] <- 0

funcao_A

funcao_Aeq <- matrix(nrow = n_dema, ncol = n_dema*n_ofer)
for (i in 1:n_dema){
    for (j in 1:n_ofer){
        # A função Aeq será sempre um ou zero
        funcao_Aeq[i,j+(i-1)*n_ofer] <- 1 
    }
}
funcao_Aeq[is.na(funcao_Aeq)] <- 0
#depois disso, juntar com A
funcao_A_Aeq <- rbind(funcao_A, funcao_Aeq) # Junta-se as duas matriz de igualdade e desigualdade
mat <- funcao_A_Aeq

funcao_Aeq

funcao_b <- matrix(nrow = 36, ncol = 1)
funcao_b <- oferta
funcao_b_final <- t(funcao_b)
funcao_b_final[is.na(funcao_b_final)] <- 0

funcao_b

funcao_beq <- matrix(nrow = n_dema, ncol = 1)
for (i in 1:n_dema){
    funcao_beq[i,1] <- as.matrix(demanda[i,1])
    #1
}
funcao_beq_final <- t(funcao_beq)
funcao_beq_final[is.na(funcao_beq_final)] <- 0

#depois disso, juntar com beq
funcao_b_beq <- cbind(funcao_b_final, funcao_beq_final)
rhs <- funcao_b_beq

funcao_beq

# Lower bound, limite inferior de zero e upper bound, limite superior igual a um
funcao_lb <- matrix(nrow = 1, ncol = n_dema*n_ofer) #matriz em linha só de zeros 
for (i in 1:n_ofer*n_dema){
    funcao_lb[i] <- 0
}                                        #funcao_lb_final <- t(funcao_lb)
funcao_lb[is.na(funcao_lb)] <- 0

funcao_ub <- matrix(nrow = 1, ncol = n_dema*n_ofer) #matriz em linha com numeros quaisquer
for (i in 1:n_ofer*n_dema){
    funcao_ub[i] <- 1
}
#depois disso, transpor
#funcao_ub_final <- t(funcao_ub)
funcao_ub[is.na(funcao_ub)] <- 1
bounds <- list(lower = funcao_lb, upper = funcao_ub )

dir <- c(rep('<=', n_ofer),rep('==', n_dema))

library(Rglpk)
solution <- Rglpk_solve_LP(obj, mat, dir, rhs, bounds , max = FALSE)

solution

val <- solution[['solution']]
iter=1
for (i in 1:n_dema){
    for (j in 1:n_ofer){
        if (val[iter] > 0)
        print(paste0('destino: ',i,', origem: ',j,', carros: ',val[iter]))
        iter=iter+1
    }
}



