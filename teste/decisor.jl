# Arquivo para o tomador de decisão 
# Ricardo Soares Oliveira
# 11 de Setembro 2024



"""
    dataframe_parametros(arquivo::String, nL::Int64, nK::Int64, nE::Int64, p1::Float64, p2::Float64, p3::Float64, Q::Float64)

TBW
"""
function dataframe_parametros(arquivo::String)

       # capacidade de acordo com arquivo 
       Q = 50;    # capacidade para o veículo R --> 50 
       #Q = 200;  # capacidade para o veículo C --> 80,200 

       # dados de entrada do tomardo de decisão
       nL = 3;  # número de Entregadores por veículo 
       nK = 15; # número de Veículos no depósito
       nE = 20; # Número de Entregadores no depósito

       # pesos para os custos unitários 
       p1 = 1.0;   # rota 
       p2 = 0.1;   # entregador 
       p3 = 0.001; # distância
    
    # Criar um DataFrame com os parâmetros
    df_parametros = DataFrame(
        Arquivo = [arquivo],
        nL = [nL],
        nK = [nK],
        nE = [nE],
        p1 = [p1],
        p2  = [p2],
        p3  = [p3],
        Q = [Q]
    )
    println("Entregadores = ", nL, "; Veículos = ", nK, "; Entregadores Deposito = ", nE, "; Capacidade Q = ", Q,".")

    
    return df_parametros
end