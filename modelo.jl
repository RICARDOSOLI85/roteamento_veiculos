# Modelo Matemático Robusto VRPTWMD
# versao 15/10/23 
# modificacao:  #mudei o Ga para gama Mudei Nq para q na penultima restrição 
#14/julho/2024
# Ricardo Soares Oliveira

using JuMP
using LinearAlgebra 
using Gurobi 


#function minimizaModelo(delta,gama, n,nV,nN,nL,nK,nE, V, N, L, K, EN, p1, p2, p3, Q, q, wa, wb, d, t, M, E, s)
function minimizaModelo(delta,gama)

  
  # Numero de Vértices 
  #n = nV
  #Nq = q                    # Demanda Nominal 
  #Dq = (delta*Nq)/100       # Desvio na demanda
  Desvio = (delta*q)/100

  modelo = Model(Gurobi.Optimizer)
  # atribuindo limite de tempo 
  
  set_optimizer_attribute(modelo, "TimeLimit", 3600) 
  # Variáveis
  @variable(modelo,x[i=1:n,j=1:n,l=1:nL],Bin)  #Rota modo l que visita o cliente j imediatamente após cliente i
  @variable(modelo,w[i=1:n,l=1:nL]>=0)        #Tempo exato quando o serviço em i começa modo l 
  @variable(modelo,y[k=1:nK,l=1:nL],Bin)       #Se a rota k é no modo l 
  @variable(modelo,z[i=1:n,k=1:nK,l=1:nL],Bin) #Cliente i associado a rota k no modo l 
  #Variáveis de decisão Alfa e Beta do Modelo 
  @variable(modelo,alfa[i=2:n,k=1:nK,l=1:nL] >=0) 
  @variable(modelo,beta[k=1:nK,l=1:nL]>=0)
  num_variables(modelo)
  #Objective 
  @objective(modelo,Min,
        p1*sum(y[k,l] for k in K  for l in L)  +                 #Números de rotas         
        p2*sum(l*y[k,l] for k in K for l in L) +                 #Número de entregdores
        p3*sum(d[i,j]*x[i,j,l] for i in V for j in V for l in L) #Distancia Total
    )
 #Constraints 
    #cada cliente dever pertencer a uma única rota com l entregadores (restriçẽos de fluxo)
    @constraint(modelo,cons1[j in N], sum(x[i,j,l] for i in 1:n-1 for l in L) ==1)
    @constraint(modelo,cons2[i in N], sum(x[i,j,l] for j in 2:n   for l in L) ==1)
    @constraint(modelo,cons3[i in N, l in L], sum(x[i,j,l] for j in 2:n) == sum(x[j,i,l] for j in 1:n-1))
    #garantem a consistência temporal, se o veículo que os visita, operando no modo l, sai de i e vai imediatamente para j 
    @constraint(modelo,cons4[i in V,j in V, i!=j,l in L], w[j,l] >= w[i,l] + (t[i,j] + s[i,l])*x[i,j,l] - max.(wb[i] - wa[j],0)*(1-x[i,j,l])) 
    #início do serviço nos clientes dentro da janela de tempo 
    @constraint(modelo,cons5[i in V, l in L],wa[i] <= w[i,l] <= wb[i])
    #expressam as disponibilidades a serem respeitadas de veículos e entregadores
    @constraint(modelo,cons6, sum(y[k,l] for k in K for l in L)<=M)
    @constraint(modelo,cons7,sum(l*y[k,l] for k in K for l in L)<=E)
    #acoplam x e y, indicando que todos os clientes devem ser visitados imediatamente após o veículo
    #sair do depósito 1 no modo l, devem ser partes de rotas distintas no mesmo modo 
    @constraint(modelo,cons8[l in L], sum(x[1,j,l] for j in N) == sum(y[k,l] for k in K))
    #garante que uma rota k opere em um unico modo l 
    @constraint(modelo,cons9[k in K],sum(y[k,l] for l in L)<=1)
    #se existe um rota k operando no modo l ele deve ter no mínimo um cliente e no máximo |N| clientes
    @constraint(modelo,cons10[k in K,l in L], sum(z[i,k,l] for i in N) >= y[k,l])
    @constraint(modelo,cons11[k in K,l in L], sum(z[i,k,l] for i in N) <=EN*y[k,l])
    #se existir um roteiro com l entregadores passando pelo cliente i, que o cliente pertenca a uma unica rota k
    #essa rota deve conter os mesmos l entregadores no roteiro 
    @constraint(modelo,cons12[i in N, l in L], sum(z[i,k,l] for k in K) <= sum(x[i,j,l] for j in 2:n))
    #se os clientes i e j pertem ao mesmo roteiro modo l, então devem ser atribuídos a mesma rota
    #designação de clientes a rota 
    @constraint(modelo,cons13[i in N, j in N, i!=j, k in K, l in L], 1 - x[i,j,l] - x[j,i,l] >= z[i,k,l] - z[j,k,l])
    #cada cliente i deve pertencer a uma unica rota k modulo l 
    @constraint(modelo,cons14[i in N], sum(z[i,k,l] for k in K for l in L) ==1)
    ##Carga Máxima de Cada Rota
    ##@constraint(modelo,cons15[k in K, l in L], sum(q[i]*z[i,k,l] for i in N) <= Q*y[k,l]) # " Deterministico "
    #Parte de incerteza do Modelo 
    @constraint(modelo,cons15[k in K,l in L], sum(q[i]*z[i,k,l] for i in N) + sum(alfa[i,k,l] for i in N) + gama*beta[k,l] <= Q*y[k,l])
    @constraint(modelo,cons16[i in N,k in K,l in L], alfa[i,k,l] + beta[k,l] >= Desvio[i]*z[i,k,l])
    

  
  # Resovler o modelo 
  optimize!(modelo)

  # Impressão
  # println(modelo)
  println(".....................................")
  println(" Imprimindo a solução do  Modelo     ")
  println("......................................")
  
  FO = JuMP.objective_value(modelo)
  status = termination_status(modelo)
  relativo_Gap = relative_gap(modelo)
  tempo = solve_time(modelo)
  

  println(" Função Objetivo (FO) = ", round(FO,digits=4))
  println(" Status é : ", status)
  println(" Gap Relativo = ", round(relativo_Gap,digits=4))
  println(" Tempo de solução (t) = ", round(tempo,digits=2))
  println(" ")

  println("      Fim do Teste                   ")
  println("......................................")
  



#-------------Desenho das rotas--------------------------
println(".....................................")
println(" Desenhando as rotas do Modelo     ")
println("......................................")

fim=n 
conta = 0 
# Adicional 
entregadores = 0 
distancia = 0
rota = 0  
for j=2:fim
    for l in 1:nL
        if round(JuMP.value(x[1,j,l])) > 0 
            soma = d[1,j]
            conta += 1
            entregadores += l     # entregadores
            print("Entr. l : $l\n") 
            print("Rota $conta: ")
            print(1)
            inicio=j 
            while inicio < fim 
                for k=1:fim
                    for p=1:nE
                        if (k!=inicio) && (round(JuMP.value(x[inicio,k,l]))>0) && (inicio!=fim)
                            print(" -> $inicio")
                            soma+=d[inicio,k]
                            inicio=k
                        end 
                    end 
                end
            end 
            # Imprimindo os resultados 
            distancia += soma  

            println(" --> $fim")
            println("Custo: $soma")
            # Resultados 
            println()
            # Número de Rotas 
            println("N. Rotas(NR) = $conta \n")
            # Número de Entregadores 
            print("N. Entregadores(ND) = $entregadores \n")
            # Distância 
            println("Distância = $distancia")
                   
        
            println()
            

                      
        end
    end
end

println(".....................................")
println(" Calculando as métricas do Modelo     ")
println("......................................")
# para distinguir entre as duas 
rotas = conta 
entre = entregadores
dist = distancia
println("N. Rotas (NR) = ", rotas)
println("N. Entregadores(ND) = ",entre)
println("Distância = ", dist)
println(" ")
println("      Fim dos Cálculos               ")
println("......................................")

 
 
 return modelo, rotas, entre, dist 
  
  
end