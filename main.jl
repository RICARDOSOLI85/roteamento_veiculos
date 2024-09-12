# Main Arquivo Principal 
# versao 11/10/23 
# modificacao:  13/10/2023, 14/10/2023, 17/10/2023 Inserindo a incerteza, Modelo e Impressão 
# Ricardo Soares Oliveira 



#========================================================================================#
#           Leitura dos dados e calculo da Matiz Distancias                             #
#=======================================================================================# 
# Importando os dados

include("dados.jl")
dados = importandoDados()

# Importando Dados com Cópia do Depósito

include("copia.jl")
dados = copiaDeposito(dados)

# Calculando a matriz das distâncias(e tempo)

include("distancias.jl")                # Inclua o arquivo distancias.jl
distancia = matrizDistancia(dados)         # Calculo da matriz das distância


# =====================================================================================================#
#                  Criando os Dados do Problema : Inserindo Parâmetros 
# =====================================================================================================#

# Arquivo tomadorDecisao Inserir os dados

include("tomadorDecisao.jl")
parametros = tomadorDecisao()  # parametros (nL,nK,nE, p1,p2,p3,Q)

# Calculo do Tempo de Serviço 

include("tempo.jl")
s = round.(matriz_tempo, digits=2)

# Função que Calcula as intâncias  deterministicas necessárias para o  modelo 

include("instancias.jl")
instancias = calcularInstancias(distancia,dados,parametros,s)

# Abrir os dados dos parametros 
include("unroll.jl")
n,nV,nN,nL,nK,nE, V, N, L, K, EN, p1, p2, p3, Q, q, wa, wb, d, t, M, E, s = unroll(instancias)

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
    for delta in Delta 
        #global modelo
        # Chama a função do Modelo 
        include("modelo.jl")
        restultados = minimizaModelo(delta,gama)
        
        #include("imprimir.jl")
            
        
    end 
end



# Imprimir os resultados 























# Incluindo os parametros Gama (Buget de Incerteza) e Delta (Probabilidade)

#include("incertezal.jl")
#parametrosIncerteza = incerteza()

# Incluir o modelo matemático 



# Lista para armazenar os resultados 

#=
resultados = []


function modeloIncerteza()
    #delta = [15,20,30]
    #gama = [0,1,2,3,4,5,6,7,8,9,10]
    Delta = [0] 
    Gama = [0] #,1,2,5] 

    for delta in Delta 
        for gama in Gama
            modelo = minimizaModelo(delta,gama)
            #valores = imprimirRotas(modelo)
            # Armazene os restuldos
            #push!(resultados,gama=gama, delta=delta)
            #return valores 
        end 
    end 
end 

=# 
#include("modelo.jl")
#modelo = minimizaModelo(delta,gama)

# -------------------------**********-------------
# Arquive os resultdos em um arquivo CSV

#using CSV
#using DataFrames 
#CSV.write("resultados.csv", DataFrame(resulatdos))

