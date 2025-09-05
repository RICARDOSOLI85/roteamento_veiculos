
# Distancias 
# Problema de Rotaeamento de Veículos Capacitao 
# Ricardo Soares Oliveira 
# 04/09/2025 

def calcula_matriz_distancias(dados):
    n = len(dados.x)
    distancias = [[0.0] * n for _ in range(n)]
    
    for i in range(n):
        for j in range(n):
            dx = dados.x[i] - dados.x[j]
            dy = dados.y[i] - dados.y[j]
            distancias[i][j] = (dx**2 + dy**2)**0.5
    
    return distancias  