# Arquivo leitura dos dados 
# Ricardo Soares Oliveira
# 11 de Setembro 2024

function importar_dados(arquivo::String)
   # Criar DataFrame para armazenar os dados
   df = DataFrame(CUST_NO = Int[], x = Float64[], y = Float64[], q = Int[], wa = Int[], wb = Int[])

   # Abrir e ler o arquivo
   open(arquivo, "r") do file
       start_reading = false
       for linha in eachline(file)
           # Ignorar até a seção CUSTOMER
           if occursin("CUSTOMER", linha)
               start_reading = true
               continue
           end
           
           # Processar linhas de dados
           if start_reading
               campos = split(linha)
               if length(campos) == 7  # Linhas com dados válidos
                   push!(df, (parse(Int, campos[1]),     # CUST NO.
                              parse(Float64, campos[2]), # XCOORD.
                              parse(Float64, campos[3]), # YCOORD.
                              parse(Int, campos[4]),     # DEMAND
                              parse(Int, campos[5]),     # READY TIME
                              parse(Int, campos[6])))    # DUE DATE
               end
           end
       end
   end
   return df
end
