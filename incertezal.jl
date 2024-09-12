# Arquivo das incertezas do Modelo 
# versao 14/10/23 
# modificacao:  
# Ricardo Soares Oliveira 


function modeloIncerteza()
    #delta = [15,20,30]
    #gama = [0,1,2,3,4,5,6,7,8,9,10]
    Delta = [0] 
    Gama = [0] #,1,2,5] 

    for delta in Delta 
        for gama in Gama
            @show delta,gama
            return delta, gama 
        end 
    end 
end 

