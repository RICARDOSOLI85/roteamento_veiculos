# Arquivo calcular as instancias
# Ricardo Soares Oliveira
# 11 de Setembro 2024

function calcular_instancias(c::Matrix{Float64}, 
    df::DataFrame,
    df_parametros::DataFrame,
    matriz_tempo::Matrix{Float64})

    # obtém o tamanho da matriz 
    n = size(c,1) 

    # dados do problema 
    nV = size(c,1)         # Numero de vertices V = {1,...n}
    nN = n-1               # Numero de clientes N = V\{1,n}
    nL = df_parametros.nL[1]  # Numero de Entregadores 
    nK = df_parametros.nK[1]  # Numero de Veiculos 
    nE = df_parametros.nE[1]  # Numero de Entregadores disponiveis 
       
    # Conjuntos do Problema:  
    V = 1:nV              # Vertices 
    N = 1:nN             # Clientes 
    L = 1:nL             # Entregadores por Veiculos
    K = 1:nK             # Veiculos no deposito 
    EN = length(N)          # dim conjunto de clientes 

    # Tomador de decisão 
    p1 = df_parametros.p1[1]
    p2 = df_parametros.p2[1]
    p3 = df_parametros.p3[1]
    Q  = df_parametros.Q[1]
        
    # Parâmetros 
    q = df.q            # demanda 
    wa = df.wa          # Janela de tempo inicial
    wb = df.wb          # Janela de tempo final 
    d = c               # matriz das distâncias 
    t = c               # matriz tempo de viagem 
    M = nK              # numero de veiculos 
    E = nE              # numero de entregadores 
    s = matriz_tempo    # tempo de servico  
    
    instancias = (
        nV = nV,
        nN = nN, 
        nL = nL,
        nK = nK, 
        nE = nE, 
        V = V,
        N = N,
        L = L, 
        K = K,
        EN = EN,
        p1 = p1,
        p2 = p2, 
        p3 = p3, 
        Q = Q, 
        q = q,
        wa =wa, 
        wb = wb,
        d = d, 
        t = t, 
        M = M,
        E = E,
        s =s
    )

    return instancias

end