# Modelo Matemático Robusto VRPTWMD
# versao 12/10/23 
# modificacao:  12/09/2024 apenas na função de entrada arquivo 
# Ricardo Soares Oliveira


# =====================================================================================================#
#                  Criando os Dados do Problema : Inserindo Parâmetros 
# =====================================================================================================#


function tomador_decisao(arquivo::String)
    println("O arquivo que será implementado é :", arquivo)
    # Dados de Entrada do Tomador de Decisão 
    nL = 3    # Numero de Entregadores por veículo
    nK = 15   # Número de Veículos no depósito
    nE = 20   # Número de Entregadores no depósito
    
    # Pesos definem os cutos unitário da:
    p1 = 1.0     # Rota
    p2 = 0.1    # Entregador
    p3 = 0.0001  # Distância

    # Capacidade Muda de Acordo com o Arquivo
    
    Q = 50 # Capacidade do Veículo 50--> R101,80,200--> C101  
    
    #parametros = Dict("nL"=> nL, "nK"=> nK, "nE"=>nE, "p1"=>p1,"p2"=>p2,"p3"=>p3,"Q"=>Q)
    parametros = (nL= nL, nK=nK, nE=nE, p1=p1,p2=p2,p3=p3,Q=Q)
    
    println("Entregadores = ", nL, " Veículos = ", nK, " , Entregadores Deposito= ", nE, " , Capacidade Q = ", Q)
    return parametros
    
end