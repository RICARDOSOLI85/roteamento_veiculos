
# Algoritmo Genético 
# Problema de Rotaeamento de Veículos Capacitao 
# Ricardo Soares Oliveira 
# 04/09/2025 

import numpy as np

def calcular_tempo(distancia, dados, nL=5):
    """
    Calcula o tempo baseado na distância e dados dos clientes usando NumPy
    
    Args:
        distancia: matriz n x n de distâncias
        dados: namedtuple com q, wa, wb
        nL: número de níveis (padrão = 5)
        
    Returns:
        matriz_tempo: matriz n x nL com os tempos calculados
    """
    # Converte para arrays NumPy
    q = np.array(dados.q)
    wa = np.array(dados.wa)
    wb = np.array(dados.wb)
    T = np.array(distancia)
    
    n = len(distancia)
    rs = 2  # taxa de serviço
    
    # Inicializar vetor D (preenche com o último valor de wb)
    D = np.full(n, wb[-1])
    
    # Calcular termo1 = max.(wa, T[:,1] - T[:,end])
    termo1 = np.maximum(wa, T[:, 0] - T[:, -1])
    
    # Calcular termo2 = D - termo1
    termo2 = D - termo1
    
    # CORREÇÃO: Usar a demanda de cada cliente (q[i]), não apenas do depósito (q[0])
    tempo = np.minimum(q * rs, termo2)
    
    # Criar matriz dividindo por 1 até nL
    j_values = np.arange(1, nL + 1)
    matriz_tempo = tempo[:, np.newaxis] / j_values
    
    return matriz_tempo

def debug_calculo(distancia, dados):
    """
    Função para debug do cálculo
    """
    print("=== DEBUG DO CÁLCULO ===")
    
    q = np.array(dados.q)
    wa = np.array(dados.wa)
    wb = np.array(dados.wb)
    T = np.array(distancia)
    n = len(distancia)
    rs = 2
    
    print(f"q (demandas - primeiros 5): {q[:5]}")
    print(f"wa (ready times - primeiros 5): {wa[:5]}")
    print(f"wb (due dates - primeiros 5): {wb[:5]}")
    print(f"wb[-1] (último due date): {wb[-1]}")
    
    # Cálculos intermediários
    D = np.full(n, wb[-1])
    diff = T[:, 0] - T[:, -1]
    termo1 = np.maximum(wa, diff)
    termo2 = D - termo1
    
    print(f"T[:, 0] - T[:, -1] (primeiros 5): {diff[:5]}")
    print(f"max(wa, diff) (primeiros 5): {termo1[:5]}")
    print(f"D - termo1 (primeiros 5): {termo2[:5]}")
    print(f"q * rs (primeiros 5): {q[:5] * rs}")
    
    tempo = np.minimum(q * rs, termo2)
    print(f"min(q*rs, termo2) (primeiros 5): {tempo[:5]}")
    
    return tempo