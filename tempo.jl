
# Calcula o tempo de serviço  
# versao: 11/10/23 
# modificacao.


function g(distancia,dados)
    q = dados.q 
    wa = dados.wa 
    wb = dados.wb
    n = size(distancia,1)
    T= distancia 
    tempo = 0 
    D = fill(wb[end],n)
    rs = 2 
    for i in 1:n
        tempo = D - (max.(wa, T[:,1] - T[:,end]))
        tempo = min.(q[:,1]*rs, tempo[i])
    end 
    return tempo 

end 




vetor_tempo=g(distancia,dados)
# Inicalizar uma matriz para armazenar o resultado 

n = size(distancia,1)
nL = parametros.nL 
matriz_tempo = zeros(n,nL)

# Usar um loop for para dividir o vetor e preencher a matriz de resultados

for i in 1:n
    for j in 1:nL
        matriz_tempo[i,j] = vetor_tempo[i] / j 
    end 
end  

matriz_tempo
