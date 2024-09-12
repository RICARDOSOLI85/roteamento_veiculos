# Main Arquivo Principal 
# versao 11/10/23 
# modificacao:  13/10/2023, 14/10/2023, 17/10/2023 Inserindo a incerteza, Modelo e Impressão 
# 12/setembro/2024 Atualizando para pasto do git hub e atualizando impressão 
# Ricardo Soares Oliveira 



#========================================================================================#
#           Leitura dos dados e calculo da Matiz Distancias                             #
#=======================================================================================# 
# Importando os dados

include("dados.jl")
arquivo = "R101.txt"
dados = importando_dados(arquivo::String)

# Importando Dados com Cópia do Depósito

include("copia.jl")
dados = copia_deposito(dados::NamedTuple)

# Calculando a matriz das distâncias(e tempo)

include("distancias.jl")                # Inclua o arquivo distancias.jl
distancia = matriz_distancia(dados::NamedTuple)         # Calculo da matriz das distância


# =====================================================================================================#
#                  Criando os Dados do Problema : Inserindo Parâmetros 
# =====================================================================================================#

# Arquivo tomadorDecisao Inserir os dados

include("tomadorDecisao.jl")
parametros = tomador_decisao(arquivo::String)  # parametros (nL,nK,nE, p1,p2,p3,Q)

# Calculo do Tempo de Serviço 

include("tempo.jl")
s = round.(matriz_tempo, digits=2)

# Função que Calcula as intâncias  deterministicas necessárias para o  modelo 

include("instancias.jl")
instancias = calcular_instancias(distancia::Matrix{Float64},
                                 dados::NamedTuple,
                                 parametros::NamedTuple,
                                 s::Matrix{Float64})

# Abrir os dados dos parametros 
include("unroll.jl")
n,nV,nN,nL,nK,nE, V, N, L, K, EN, p1, p2, p3, Q, q, wa, wb, d, t, M, E, s = unroll(instancias::NamedTuple)

# Criar arquivo DataFrame para construir as tabelas de testes
resultados = DataFrame()

# ========================================================================
#         Incerteza do Modelo 
# =========================================================================


# implementar a automatizacão dos testes 
#Tabela 1,2,3 
#Delta= [15]                    # Variação da demanda 1
#Gama = [0,1,2,5]               # Buget de incerteza  1
#Delta= [15,20,30]             # Variação da demanda  2 
#Gama = [1,2,3,4,5,6,7,8,9,10] # Buget de incerteza   2 
#Delta= [20]             # Variação da demanda  3 
#Gama = [0,2,5] # Buget de incerteza   3 


Delta = 0 
Gama =  0 
for gama in Gama 
    println("Testando para gama (Γ=$gama)")
    for delta in Delta
        println("Testando para delta (δ=$delta)") 
        
        # implementando o modelo 
        include("modelo.jl")
        modelo, rotas, entre, dist  = minimizaModelo(delta,gama)

        # imprimindo e salvando os dados 
        include("metricas.jl")
        metricas = calcular_metricas(modelo::Model,rotas::Int64, entre::Int64, dist::Float64, 
        delta::Int64,gama::Int64,arquivo::String) 
        
        # Verificar e atualizar tabela de resultados para o Modelo 1
        global resultados
        if typeof(metricas) == DataFrame
           resultados = vcat(resultados, metricas)
        else
            println("Erro: `metricas` não é um DataFrame válido.")
        end
        
            
        
    end 
end

CSV.write("resultados_$arquivo.csv", resultados)