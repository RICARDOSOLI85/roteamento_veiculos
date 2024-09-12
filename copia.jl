
# Adicionar na ultima linha a primeira para cópia depósito 
# versao: 11/10/23 
# modificacao:  



function copiaDeposito(dados)
    # Acessando os dados dos vetores x,y,d,wa,wb 

    x = dados.x;        # Coordenadas da distância x
    y = dados.y;        # Coordenadas da distância y
    q = dados.q;        # Demanda de cada cliente 
    wa = dados.wa;      # Janela de tempo a
    wb = dados.wb;      # Janela de tempo b 

    # Obtenha os elementos da primeira linha 

    primeiro_x = x[1] 
    primeiro_y = y[1]
    primeiro_q = q[1]
    primeiro_wa = wa[1]
    primeiro_wb= wb[1] 

    # Anexe os elementos da primeira linha no final dos vetores x,y,d,wa,wb
    
    push!(x, primeiro_x)
    push!(y, primeiro_y)
    push!(q, primeiro_q)
    push!(wa, primeiro_wa)
    push!(wb, primeiro_wb) 

    # Retorne os dados copia em um dicionario 

    #ados = Dict("x" => x, "y" => y, "q" => q, "wa" => wa, "wb" => wb)
    dados = (x = x, y = y, q = q, wa = wa, wb = wb)

   return dados

end 