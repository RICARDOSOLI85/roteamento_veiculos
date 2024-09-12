# Arquivo principal para O PRVJTME
# Ricardo Soares Oliveira
# 11 de Setembro 2024

using DataFrames
using CSV 

#--------------------------------------------------------------------
# Parâmetros -> (Tomador de decisão)
#--------------------------------------------------------------------
arquivo = raw"instancias/R101.txt"
Gama = [0] # Γ  'gama' : controle da incerteza
Delta = [0] # δ 'delta': porcentagem de incerteza
# primeira impressões 
println("O arquivo que será implementado é: $arquivo")

#..............................................................#
# A : Leitura dos dados e cálculo das matrizes da distâncias
#..............................................................#
include("decisor.jl")
include("dados.jl") 
include("copia.jl")
include("matriz.jl")
include("tempo.jl")
include("instancias.jl")
include("unroll.jl")
include("modelo.jl")
# 0. leitura dos parametros 
df_parametros = dataframe_parametros(arquivo::String)

# 1.data frame original 
df = importar_dados(arquivo::String)

# 2.data framde df com a cópia 
df = copiar_dados(df::DataFrame)

# 3.matriz custo c 
c = calular_matriz(df::DataFrame)

# 4.matriz tempo 
matriz_tempo = calcular_matriz_tempo(c::Matrix{Float64},df::DataFrame,df_parametros::DataFrame)

# 5. instâncias 
instancias = calcular_instancias(c::Matrix{Float64},df::DataFrame,df_parametros::DataFrame,matriz_tempo::Matrix{Float64})



#---------------------------------------------------------------------------------
# B Implementar o modelo e Imprimir os resultados 
#--------------------------------------------------------------------------------

for gama in Gama 
    println("Testar com Gama  (Γ=$gama)")
    for delta in Delta
        println("Testar com delta (δ=$delta)")
        
         minimiza_robusto(delta::Int64,gama::Int64,instancias)
           
    end
       
end  

