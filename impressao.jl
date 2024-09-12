# Imppressão dos resultados 
# versao 13/10/23 
# modificacao:  

using JuMP

function imprimir(modelo)  
    println("Função Objetivo é ", objective_value(modelo))
    return fo 
end 

#=
function imprimirRotas(modelo)
   
    println(" Valor de x:Rota modo l que visita o cliente j imediatamente após cliente i ")
    for i in V
        for j in V
            for l in L 
                if JuMP.value(x[i,j,l])>0
                println("x[$i,$j,$l] = ", JuMP.value(x[i,j,l]))
                #println("w[$i,$l] = ", JuMP.value(w[i,l]))    
                end 
            end 
        end 
    end
        
    println("Tempo exato quando o serviço em i começa modo l ")
    for i in V
        for l in L 
                if (JuMP.value(w[i,l]) >= 0) #&& (JuMP.value(w[i,l])> wa[i])
                h = JuMP.value(w[i,l])
                println("w[$i,$l] =   ", round.(h, digits=2))         
                end 
        end 
    end 
    println(" #Cliente i associado a rota k no modo l ")
    for i in V 
        for k in K 
            for l in L 
                if (JuMP.value(z[i,k,l])>0)
                   println("z[$i,$k,$l] = ", JuMP.value(z[i,k,l]))
                end 
            end 
        end
    end 
    println(" #Se a rota k é no modo l ")
    for k in K
        for l in L 
                if (JuMP.value(l*y[k,l])> 0)
                println("$l*y[$k,$l] =   ", JuMP.value(l*y[k,l])> 0)         
                end 
        end 
    end 

    
    


    
end

=# 