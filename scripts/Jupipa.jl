
using JuMP, DelimitedFiles, GLPK

oferta = readdlm("../dados/exemplo_oferta.txt");
demanda = readdlm("../dados/exemplo_demanda.txt");
Distancias = readdlm("../dados/exemplo_distancias.txt");
noferta = size(oferta,1)
ndemanda = size(demanda,1);

Distancias

#MODEL CONSTRUCTION
LpModel = Model(with_optimizer(GLPK.Optimizer)) 
#VARIABLES
@variable(LpModel, x[1:ndemanda*noferta] >= 0) # Models x >=0
#OBJECTIVE
@objective(LpModel, Min,sum(Distancias[i,j]*x[j+(i-1)*noferta] for i in 1:ndemanda for j in 1:noferta));

#CONSTRAINTS
#demanda e oferta
for i in 1:ndemanda
    @constraint(LpModel, sum(x[j+(i-1)*noferta] for j in 1:noferta) == demanda[i]) # the ith row 
end 
for j in 1:noferta
    @constraint(LpModel, sum(x[j+(i-1)*noferta] for i in 1:ndemanda) <= oferta[j]) # the ith row 
end

LpModel

#SOLVE IT
# finally optimize the model
@time begin
status = JuMP.optimize!(LpModel) # solves the model
end
# TEST SOLVER STATUSES
@show JuMP.has_values(LpModel)
@show JuMP.termination_status(LpModel)
@show JuMP.primal_status(LpModel) == MOI.FEASIBLE_POINT;

# DISPLAY THE RESULTS
#-------------------------------- 
println("Objective value: ", JuMP.objective_value(LpModel)) # JuMP.objectivevalue(model_name) gives the optimum objective value
#println("Optimal solution is x = \n", JuMP.value.(x)) # JuMP.resultvalue(decision_variable) will give the optimum value 

[println("destino: ",i,", origem: ",j,", carros: ",JuMP.value.(x)[j+(i-1)*noferta]) for i in 1:ndemanda for j in 1:noferta if JuMP.value.(x)[j+(i-1)*noferta] >0];


