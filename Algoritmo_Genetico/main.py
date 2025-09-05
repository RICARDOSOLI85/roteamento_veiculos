# Algoritmo Genético 
# Problema de Rotaeamento de Veículos Capacitao 
# Ricardo Soares Oliveira 
# 04/09/2025 

from dados import importar_dados, obter_info_veiculos, copia_deposito
from distancias import calcula_matriz_distancias  
from tempo import calcular_tempo

def main():
    # Nome do arquivo de entrada
    arquivo = "C101.txt"
    
    print("=== SISTEMA DE PROCESSAMENTO DE DADOS DE ROTEAMENTO ===")
    
    # Importa informações dos veículos
    print("\n1. IMPORTANDO INFORMAÇÕES DOS VEÍCULOS")
    info_veiculos = obter_info_veiculos(arquivo)
    
    if info_veiculos:
        print(f"   Quantidade de veículos: {info_veiculos['quantidade']}")
        print(f"   Capacidade por veículo: {info_veiculos['capacidade']}")
    else:
        print("   Não foi possível obter informações dos veículos")
    
    # Importa dados dos clientes
    print("\n2. IMPORTANDO DADOS DOS CLIENTES")
    dados = importar_dados(arquivo)
    
    if dados:
        print(f"   Total de clientes processados: {len(dados.x)}")
        
        # Exibe informações do depósito (cliente 0)
        print(f"\n   DEPÓSITO (Cliente 0):")
        print(f"   Coordenadas: ({dados.x[0]}, {dados.y[0]})")
        print(f"   Demanda: {dados.q[0]}")
        print(f"   Janela de tempo: [{dados.wa[0]}, {dados.wb[0]}]")
        
        # Copia o depósito para o final
        print(f"\n3. COPIANDO DEPÓSITO PARA O FINAL")
        dados_com_copia = copia_deposito(dados)
        
        print(f"   Total de clientes após cópia: {len(dados_com_copia.x)}")
        print(f"   Último cliente (cópia do depósito):")
        print(f"   Coordenadas: ({dados_com_copia.x[-1]}, {dados_com_copia.y[-1]})")
        print(f"   Demanda: {dados_com_copia.q[-1]}")
        print(f"   Janela de tempo: [{dados_com_copia.wa[-1]}, {dados_com_copia.wb[-1]}]")
        
        # Calcular matriz de distâncias
        print(f"\n4. CALCULANDO MATRIZ DE DISTÂNCIAS")
        matriz_distancias = calcula_matriz_distancias(dados_com_copia)
        
        print(f"   Dimensão da matriz: {len(matriz_distancias)}x{len(matriz_distancias[0])}")
        print(f"   Distância depósito→cliente1: {matriz_distancias[0][1]:.2f}")
        print(f"   Distância cliente1→cliente2: {matriz_distancias[1][2]:.2f}")
        
        # Calcular matriz de tempo
        print(f"\n5. CALCULANDO MATRIZ DE TEMPO")
        matriz_tempo = calcular_tempo(matriz_distancias, dados_com_copia)
        
        print(f"   Dimensão da matriz de tempo: {matriz_tempo.shape[0]}x{matriz_tempo.shape[1]}")
        print(f"   Amostra da matriz de tempo (5 primeiras linhas, 3 primeiras colunas):")
        
        # Mostrar amostra da matriz de tempo
        for i in range(min(5, len(matriz_tempo))):
            for j in range(min(3, len(matriz_tempo[0]))):
                print(f"   t[{i}][{j}] = {matriz_tempo[i][j]:.2f}")
            print()
        
        print(f"\n6. PROCESSAMENTO CONCLUÍDO COM SUCESSO!")
        
    else:
        print("   Erro ao importar dados dos clientes")

# ISSO É ESSENCIAL PARA EXECUTAR O PROGRAMA
if __name__ == "__main__":
    main()