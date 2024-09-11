# Arquivo calcular a matriz das distâncias 
# Ricardo Soares Oliveira
# 11 de Setembro 2024

function calular_matriz(df::DataFrame)
    x = df.x
    y = df.y
    n = length(x)
    c = zeros(n,n)
    for i=1:n
        for j=1:n
            d = (x[i] - x[j])^2 + (y[i] - y[j])^2 
            c[i,j] = sqrt(d)
        end 
    end 
    return c     
end