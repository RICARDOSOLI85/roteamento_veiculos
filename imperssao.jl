# Imppressão dos resultados 
# versao 13/10/23 
# modificacao:  


function imprimir(modelo)

    fo = objetive_value(modelo)
    println("Função Objetivo é $fo")
    
end

#=
function imprimirRotas(modelo)
    println(" Desenho das rotas ")
    fim=n 
    conta = 0 
    
    for j=2:fim
        for l in 1:nL
            if round(JuMP.value(x[1,j,l])) > 0 
                soma = d[1,j]
                conta += 1 
                print("Rota $conta: ")
                print(1)
                inicio=j 
                while inicio < fim 
                    for k=1:fim
                        for p=1:nE
                            if (k!=inicio) && (round(JuMP.value(x[inicio,k,l]))>0) && (inicio!=fim)
                                print(" -> $inicio")
                                soma+=d[inicio,k]
                                inicio=k
                            end 
                        end 
                    end
                end 
                println(" --> $fim")
                println("Custo: $soma")
                println()
            end
        end
    end 
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