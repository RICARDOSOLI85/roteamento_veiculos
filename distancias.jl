# Calculo da Matrix das distâncias 
# versao: 11/10/23 
# modificacao:  12/09/2024 apenas na função de entrada 


function matriz_distancia(dados::NamedTuple)
    x = dados.x
    y = dados.y
    n= length(x)
    c= zeros(n,n)
    for i=1:n
        for j=1:n
            d=(x[i]-x[j])^2 + (y[i] - y[j])^2
            c[i,j]=sqrt(d)
            c = round.(c,digits=2) # Arredondamento com duas casas 
        end
    end
return c
end

