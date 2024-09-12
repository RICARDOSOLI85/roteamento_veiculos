# Métricas para o resultado do modelo
# Nome: Ricardo Soares Oliveira
# Data 12/10/2024

using DataFrames
using JuMP

"""
    calcular_metricas(modelo::Model,delta::Int64,gama::Int64)

TBW
"""
function calcular_metricas(modelo::Model,rotas::Int64, entre::Int64, dist::Float64, 
         delta::Int64,gama::Int64,arquivo::String) 
    

    # Status da Solução
    println("...............................................")
    println(" Imprimindo  a  solução do   Modelo $arquivo")
    println("Parâmetros: Gama(Γ = $gama) e delta(δ = $delta)")
    println("................................................")
    # Status da Solução
    
    FO = JuMP.objective_value(modelo)
    status = termination_status(modelo)
    relativo_Gap = relative_gap(modelo)
    tempo = solve_time(modelo)
    nv = num_variables(modelo)
    

    println("Função Objetivo (FO) = ",round(FO,digits=4))
    println("Status é             : ", status)
    println("Gap Relativo         = ",round(relativo_Gap,digits=4))
    println("Tempo de solução (t) = ", round(tempo,digits=2))
    println("N variáveis          = ", nv)

   

    println(".....................................")
    println(" Calculando as métricas do Modelo     ")
    println("......................................")
    println("N. Rotas (NR)       = ", rotas)
    println("N. Entregadores(ND) = ",entre) 
    println("Distância           = ", dist)
    println(" ")
    println("      Fim dos Cálculos               ")    
    println("......................................")


    # Salvar em um arquivo TXT 
    # definindo o diretorio 
    diretorio = "resultados $arquivo" 

    # cirando o diretório
    mkpath(diretorio)
    filename = joinpath(diretorio, "Resultados: Modelo$arquivo (Γ = $gama) delta(δ = $delta)")
   
    open(filename, "w") do file
        println(file,"...............................................")
        println(file," Imprimindo  a  solução do   Modelo $arquivo")
        println(file,"Parâmetros: Gama(Γ = $gama) e delta(δ = $delta)")
        println(file,"................................................")
        println(file,"Função Objetivo (FO) = ", round(FO,digits=4))
        println(file,"Status é             : ", status)
        println(file,"Gap Relativo         = ",  round(relativo_Gap,digits=4))
        println(file,"Tempo de solução (t) = ", round(tempo,digits=2)) 
        println(file,"N variáveis          = ", nv)
        println(file,".....................................")
        println(file," Calculando as métricas do Modelo     ")
        println(file,"......................................")
        println(file,"N. Rotas (NR)       = ", rotas)
        println(file,"N. Entregadores(ND) = ",entre)
        println(file,"Distância           = ", dist)
        println(file," ")
        println(file,"      Fim dos Cálculos               ")
        println(file,"......................................")
    end

    FO = round(FO,digits=4)
    relativo_gap = round(relativo_Gap,digits=4)
    tempo =  round(tempo,digits=2)
    

     # Função Interna para construir o DataFrame das métricas
     function construir_dataframe_metricas()
        return DataFrame(
            #....Instancia 
            instancia = arquivo,
            gama = gama,
            delta = delta,
            #..Metricas do Modelo 
            FunObj = FO,
            NR = rotas,
            ND = entre, 
            dist = dist,
            gap = relativo_gap,
            # Otimização  
            status = string(status),
            tempo = tempo,
            NV  = nv, 
                        
        )
        
    end
    
    # construir e retornar o DataFrame
    metricas = construir_dataframe_metricas()

    return metricas 
    
end