# Parametros para Modelo Tese Doutorado 
# versao 11/10/23 
# modificacao:  




function parametrosEntrada()
    print("Entre com Número Entregadores: ")
    nL = parse(Int, readline()) # Numero de Entregadores
    print("Entre com Número de Veiculos deposito: ") 
    nK = parse(Int, readline()) # Numero de Veiculos 
    print("Entre com Número de Entregadores deposito: ")  
    nE = parse(Int,readline())
     

    dados_entrada = (nL = nL, nK = nK, nE=nE)

    return dados_entrada
end 