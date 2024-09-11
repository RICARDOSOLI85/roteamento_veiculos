# Arquivo principal para O PRVJTME
# Ricardo Soares Oliveira
# 11 de Setembro 2024

using DataFrames
using CSV 

#--------------------------------------------------------------------
# Parâmetros -> (Tomador de decisão)
#--------------------------------------------------------------------
arquivo = raw"instancias/R101.txt"

# primeira impressões 
println("O arquivo que será implementado é: $arquivo")

#--------------------------------------------------------------------
#..............................................................#
# 1. Leitura dos dados e cálculo das matrizes da distâncias
#..............................................................#
include("decisor.jl")
include("dados.jl") 
include("copia.jl")
include("matriz.jl")
include("tempo.jl")
include("instancias.jl")

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
instancias = calcular_instancias(c::Matrix{Float64}, 
df::DataFrame,
df_parametros::DataFrame,
matriz_tempo::Matrix{Float64})