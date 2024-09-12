# Importando dados para Modelo Tese Doutorado 
# versao 11/10/23 
# 12/09/2024 Modificando a entreada do arquivo leitura 
# modificacao:  


function importando_dados(arquivo::String)
    # Abre o arquivo para leitura 
    inn = open("R101.txt", "r")
    
    # Pule as primeiras 9 linhas 
    for _ in 1:9 
        readline(inn)
    end 

    # Inicialize vetores varios para cada coluna 

    x = Float64[]
    y = Float64[]
    q = Float64[]
    wa = Int[]
    wb = Int[]

  
       # Leia o arquivo linha a linha 

    for line in eachline(inn)
        # Divida a linha em partes usando separadores 
        parts = split(line)

        # Verifique se há pelo menos 5 partes na linha 
        if length(parts) >= 5
            push!(x, parse(Float64, parts[2]))
            push!(y, parse(Float64, parts[3]))
            push!(q, parse(Float64, parts[4]))
            push!(wa, parse(Float64, parts[5]))
            push!(wb, parse(Float64, parts[6]))
        end 
    end 

    # Crie uma tupla para ler os dados 
    
    #dadosEntrada = Dict("x" => x, "y" =>y, "q"=>q, "wa"=>wa , "wb"=> wb)
    dados = (x = x, y =y, q=q, wa=wa , wb= wb)

    # Feche o arquivo 
    close(inn)

    # Retorne a tupla com os dados 

    return dados 

    # Imprimiir o primeiro valor de cada coluna 
    println("x[1]:  ", x[1])
    println("y[1]:  ", y[1])
    println("q[1]:  ", q[1])
    println("wa[1]: ", wa[1])
    println("wb[1]: ", wb[1])
    
end
