function imprimir(modelo,Gama,delta)
    

 #--------------------------------------
  #      Função para salvar os resultados 
  #------------------------------------

  function salvar_resultados(resultados,arquivo_resultados)
    resultado_arquivo = open(arquivo_resultados, "a")
    println(resultado_arquivo, resultados)
    close(resultado_arquivo)    
  end

  #--------------------------------------
  #      Impressão dos resultados 
  #------------------------------------

  # Armazenar o valor da função Objetivo
  println("***--- Impressão dos resultado ---***")
  println("Resultados para Gama = $gama e Delta = $Delta")
  println("-----Status da Solução-----------")
  println("Valor da função objetivo = ", JuMP.objective_value(modelo))
  println("Status = ", termination_status(modelo))
  println("relativo_gap = ", relative_gap(modelo))
  println("solve_time = ", solve_time(modelo))
  println("Has_values = ", has_values(modelo))
  println("Raw_Status = ", raw_status(modelo))
  
  # Armazenar os valores no arquivo txt 
  resultados="***--- Impressão dos resultado ---***\n" 
  resultados = " Resultados para Gama = $gama e Delta = $Delta \n"
  resultados *= "Distância = $distancia \n"                     ##
  resultados *= "N. Entregadores(ND): $entregadores \n"         ##  
  resultados *= "-----Status da Solução-----------\n"
  resultados *= "Valor da função objetivo =  $(JuMP.objective_value(modelo))\n"
  resultados *= "Status =  $(termination_status(modelo))\n"
  resultados *= "Gap realativo =  $(relative_gap(modelo))\n" 
  resultados *= "Tempo Solução  = $(solve_time(modelo))\n" 





  


#-------------Desenho das rotas--------------------------
println(" Desenho das rotas \n")
resultados *= "Desenho das rotas \n"
fim=n 
conta = 0 
# Adicional 
entregadores = 0 
distancia = 0
rota = 0  
for j=2:fim
    for l in 1:nL
        if round(JuMP.value(x[1,j,l])) > 0 
            soma = d[1,j]
            conta += 1
            entregadores += l     # entregadores
            print("Entr. l : $l\n") 
            print("Rota $conta: ")
            resultados *= "Entregadores : $l\n"
            resultados *= "Rota : $conta" # add 
            print(1)
            inicio=j 
            while inicio < fim 
                for k=1:fim
                    for p=1:nE
                        if (k!=inicio) && (round(JuMP.value(x[inicio,k,l]))>0) && (inicio!=fim)
                            print(" -> $inicio")
                            resultados *= " -> $inicio  "
                            soma+=d[inicio,k]
                            inicio=k
                        end 
                    end 
                end
            end 
            # Imprimindo os resultados 
            distancia += soma  

            println(" --> $fim")
            resultados *= " -->$fim \n"
            println("Custo: $soma")
            resultados *= " custos : $soma \n"
            # Resultados 
            println()
            # Número de Rotas 
            println("N. Rotas(NR) = $conta \n")
            resultados *= " N. Rotas(NDR): $conta \n" 
            # Número de Entregadores 
            print("N. Entregadores(ND) = $entregadores \n")
            resultados *= " N. Entregadores(ND): $entregadores \n"
            # Distância 
            println("Distância = $distancia")
            resultados *= "Distância : $distancia \n"
            
            println()
          
        end
    end
end
# printar a funçã objetivo, Gap e Tempo 
 println("***-------Impressão dos resultado------------***")
 println("Resultados para Gama = $gama e Delta = $Delta")
 println("N. Entregadores(ND) = $entregadores \n") ##
 println("Distância = $distancia")                 ## 
 println("Valor da função objetivo = ", round.(JuMP.objective_value(modelo), digits=4))
 println("relativo_gap = ", round.(relative_gap(modelo),digits=4))
 println("solve_time = ", solve_time(modelo))
 println("Status = ",termination_status(modelo) )
 println("------------ Fim do resultado Teste n --------")
 println()

 # salvar no arquivo de texto 
 resultados *=" ------------------------------------------------------------\n"
 resultados="***--- Impressão dos resultado ---***\n" 
 resultados = " Resultados para Gama = $gama e Delta = $Delta \n"
 resultados *= "Distância = $distancia \n"                     ##
 resultados *= "N. Entregadores(ND): $entregadores \n"         ##            
 resultados *= "Valor da função objetivo =  $(round.(JuMP.objective_value(modelo), digits=4))\n"
 resultados *= "Status =  $(termination_status(modelo))\n"
 resultados *= "Gap realativo =  $(round.(relative_gap(modelo), digits=4))\n" 
 resultados *= "Tempo Solução  = $(solve_time(modelo))\n" 
 resultados *= " Fim do resultados do Teste \n "
 resultados *= "------------------------------------------------------------\n"
 
 
   
  
  salvar_resultados(resultados, "resultados/testar_impressao.txt")

end
