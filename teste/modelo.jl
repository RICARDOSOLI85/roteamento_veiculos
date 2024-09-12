# Arquivo calcular os valores das instancias 
# Ricardo Soares Oliveira
# 11 de Setembro 2024

using JuMP
using LinearAlgebra
using Gurobi

"""
    minimiza_robusto(delta::Vector{Int64},gama::Vector{Int64},instancias::String)

TBW
"""
function minimiza_robusto(delta::Int64,gama::Int64,instancias)

    # desenrolar 
    include("unroll.jl")
    n, nV,nN,nL,nK,nE, V, N, L, K, EN, p1, p2, p3, Q, q, wa, wb, d, t, M, E, s = unroll(instancias)
    
    
    # numero de Vértices 
    #n = nV
    #Nq = q                    # Demanda Nominal 
    #Dq = (delta*Nq)/100       # Desvio na demanda
    Desvio = (delta*q)/100

   
    #...................................................................
    # Iniciar a implementação do modelo Robusto 
    #..................................................................
    println("Iniciar a implementação do modelo Robusto")

    # construção do modelo 
    modelo = Model(Gurobi.Optimizer)

    # atribuindo limite de tempo
    set_optimizer_attribute(modelo, "TimeLimit",3600)
    
    # variáveis de decisão 
    @variables(modelo,
    begin
        x[i=1:n,j=1:n,l=1:nL],Bin      # Rota no modo (L) que visita o cliente 'j' após cliente 'i'
        w[i=1:n, l=1:nL]>=0            # Tempo em que o serviço em 'i' começa no modo 'l'
        y[k=1:nK,l=1:nL], Bin          # Se a rota 'k' é no modo 'l'
        z[i=1:n,k=1:nK,l=1:nL], Bin    # Var. Bin. se o cliente 'i' é associado a rota 'k' modo 'l' 
        alfa[i=1:n,k=1:nK,l=1:nL] >= 0 # Variáveis de decisão α alpha do modelo Robusto 
        beta[k=1:nK, l=1:nL] >= 0      # Variáveis de decisão β beta do modelo Robusto 
    end)
    println(" Numero de Variáveis =  ", num_variables(modelo))
    println(" n ", n, " nL ", nL, "nk ", nK)

    # função objetivo 
    @objective(modelo, Min,
    p1 * sum(y[k,l] for k in K for l in L)  +                      # numero de rotas 
    p2 * sum(l*y[k,l] for k in K for l in L) +                     # numero de entregadores 
    p3 * sum(d[i,j] * x[i,j,l] for i in V for j in V for l in L)   # distância total 
    )

    # restrições
    
    @constraints(modelo, begin
        # cada cliente deve pertecer a uma única rota com l entregadores (rest. de fluxo)
        cons1[j in N], sum(x[i,j,l] for i in 1:n-1 for l in L) ==  1
        cons2[i in N], sum(x[i,j,l] for j in 2:n for l in L) == 1 
        cons3[i in N, l in L], sum(x[i,j,l] for j in 2:n) == sum(x[i,j,l] for j in 1:n-1)
        
        # garante a consistencia temporal: veículo visita no modo 'l' saindo de 'i' para 'j'
        cons4[i in V, j in V, i!=j, l in L], w[j,l] >= w[i,l] + (t[i,j] + s[i,l]) * x[i,j,l] - max.(wb[i] - wa[j], 0)*(1 - x[i,j,l])
        
        
        # inicia o servico ao cliente dentro da janela de tempo 
        cons5[i in V, l in L], wa[i] <= w[i,l] <= wb[i]
        
        # expressa com respeito a disponibilidade dos veículos M e entregadores E 
        cons6, sum(y[k,l] for k in K for l in L) <= M
        cons7, sum(l*y[k,l] for k in K for l in L) <= E 
        
        # acoplam 'x' e 'y', indicando que todos os clientes devem ser visitados imediatamente após 
        # o veículo sair do depósito 1 no modo l 
        cons8[l in L], sum(x[1,j,l] for j in N) == sum(y[k,l] for k in K)

        # garante que uma rota 'k' opere em um único modo 'l'
        cons9[k in K], sum(y[k,l] for l in L) <= 1 
        
        # se existe uma rota 'k' no modo 'l' ela deve ter no mínimo 1 cliente e no máximo |N| clientes 
        cons10[k in K, l in L], sum(z[i,k,l] for i in N) >= y[k,l]
        cons11[k in K, l in L], sum(z[i,k,l] for i in N) <= EN * y[k,l]
        
        # se existir uma rota com l entregadores passando pelo cliente i, que o cliente pertenca a uma unica 
        # rota k essa rota deve conter os mesmos 'l' entregadores
        cons12[i in N, l in L], sum(z[i,k,l] for k in K) <= sum(x[i,j,l] for j in 2:n)
        
        # se os clientes i e j pertencem a mesma rota k modo 'l', então devem ser atriubuídos 
        # a mesma designação de rota 
        cons13[i in N, j in N, i!=j, k in K, l in L], 1- x[i,j,l] - x[j,i,l] >= z[i,k,l] - z[j,k,l]
        
        # cada cliente i deve pertencer a uma única rota 'k' modulo 'l'
        cons14[i in N], sum(z[i,k,l] for k in K for l in L) == 1
    
        # Determinisitico (not) 
        #cons15[k in K, l in L], sum(q[i]*z[i,k,l] for i in N) <= Q * y[k,l]

        # parte de incerteza do modelo robusto 
        #cons15[k in K, l in L], sum(q[i]*z[i,k,l] for i in N)  + sum(alfa[i,k,l] for i in N) + gama*beta[k,l] <= Q * y[k,l]
        cons16[i in N, k in K, l in L], alfa[i,k,l] + beta[k,l] >= Desvio[i] * z[i,k,l]
    end)
    

    # Resolver o modelo
    optimize!(modelo) 

    # imprimir resultado
    println("......................................")
    println(" Solução do Modelo Robusto PRVJTME    ")
    println(" Gama (Γ) = $gama e Delta (δ) = $delta")
    println("......................................")
    status = JuMP.termination_status(modelo)

    if status == MOI.OPTIMAL
        obj_value = JuMP.objective_value(modelo)
        println("Objective Value: ", obj_value)
    else
         println("Model was not solved to optimality. Status: ", status)
    end
    FO = JuMP.objective_value(modelo)
    status = termination_status(modelo)
    num_var = num_variables(modelo)
    time = round(solve_time(modelo), digits=4)
    #gap_relativo = relative_gap(modelo)



    println(modelo)
    println("Função Objetivo (FO) = ", FO)
    println("Tempo (t) =", time)
    #println(" Gap relativo = ", gap_relativo)
    println("Status = ", status)
    #println("Num Variaveis  = ", num_var)
    #println("Has_values = ", has_values(modelo))
    #println("Raw_Status = ", raw_status(modelo))   


    return FO , time, modelo 

    
end