# Arquivo para copia dos dados na ultima linha 
# Ricardo Soares Oliveira
# 11 de Setembro 2024

function copiar_dados(df::DataFrame)

   # Obter a primeira linha
   primeira_linha = df[1, :]
    
   # Adicionar a cópia da primeira linha ao final do DataFrame
   push!(df, primeira_linha)
   
   return df
    
    
end