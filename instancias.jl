# Calcula os parametros usados no modelo 
# versao: 11/10/23 
# modificacao:  12/09/2024 apenas na função de entrada arquivo 



function calcular_instancias(distancia::Matrix{Float64},
    dados::NamedTuple,
    parametros::NamedTuple,
    s::Matrix{Float64})

    n = size(distancia,1)  # Obtém o tamanho da matriz assumindo ser quadrada
    # Dados do problema 
    nV = size(distancia,1)      # Número de vértices V = {1,...,n}
    nN = n-1                    # Número de Clientes N = V\{1,n} 
    nL = parametros.nL          # Número de Entregadores 
    nK = parametros.nK          # Número de Veículos 
    nE = parametros.nE          # Número de Entregadores no Depósito 
    
    #Conjuntos do Problema
    V = (1:nV)         # Conjunto de Vértices 
    N = (2:nN)         # Conjunto de Clientes
    L = (1:nL)         # Conjunto de Entregadores por veículo
    K = (1:nK)         # Conjunto de Veículos no Depósito 
    # Tamanho do conjunto de clientes 
    EN = length(N)
    

    # Tomador de Decisão 
    p1 = parametros.p1
    p2 = parametros.p2 
    p3 = parametros.p3
    Q  =  parametros.Q

    # Parametros 
    q =  dados.q    # Demanda 
    wa = dados.wa  # Janela de Tempo Começo 
    wb = dados.wb  # Janela de Tempo Final 
    d  = distancia # Distância entre os Vértices
    t =  distancia # Tempo de viagem 
    M =  nK         # Número de veículos 
    E =  nE         # Número de Entregadores 
    s =  s          # Tempo de Servico 

    instancias = (nV=nV,nN=nN,nL=nL,nK=nK,nE=nE, V=V, N=N, L=L, K=K, EN=EN, p1=p1, p2=p2, p3=p3, Q=Q, q=q, wa=wa, wb=wb,d=d,t=d,M=M,E=E, s=s )

    return instancias
end