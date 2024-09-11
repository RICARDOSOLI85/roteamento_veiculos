# Arquivo calcular o tempo 
# Ricardo Soares Oliveira
# 11 de Setembro 2024


function g(c::Matrix{Float64},df::DataFrame)
    q =  df.q 
    wa = df.wa 
    wb = df.wb
    n = size(c,1)
    T= c
    tempo = zeros(Float64,n)
    D = fill(wb[end],n)
    rs = 2                  # parametro de ajuste 
    for i in 1:n
        tempo = D - (max.(wa, T[:,1] - T[:,end]))
        tempo = min.(q[:,1]*rs, tempo[i])
    end 
    return tempo 

end 


# Uso da função ``g'' 

function calcular_matriz_tempo(c::Matrix{Float64},df::DataFrame,df_parametros::DataFrame)
    n = size(c,1)
    nL = df_parametros.nL[1]
    vetor_tempo=g(c, df)
    matriz_tempo = zeros(Float64, n, nL)

    # inicializar a matriz de resultados
    for i in 1:n
        for j in 1:nL
            matriz_tempo[i,j] = vetor_tempo[i] / j 
        end 
    end
    
    return matriz_tempo   
    
end

