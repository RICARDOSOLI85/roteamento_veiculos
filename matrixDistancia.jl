# Calculo da Matrix das distâncias 
# versao: 11/10/23 
# modificacao:  

x=[1 2 7 5 9 2 4 6 1 5 3 9];
y=[5 6 5 4 4 3 2 2 1 1 0 0];

function matrixDistancia(x,y)
    n= length(x)
    c= zeros(n,n)
    for i=1:n
        for j=1:n
            d=(x[i]-x[j])^2 + (y[i] - y[j])^2
            c[i,j]=sqrt(d)
        end
    end
return c
end

