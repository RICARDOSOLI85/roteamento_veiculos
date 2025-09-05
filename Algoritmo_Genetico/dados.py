# Algoritmo Genético 
# Problema de Rotaeamento de Veículos Capacitao 
# Ricardo Soares Oliveira 
# 04/09/2025 

from collections import namedtuple

def importar_dados(arquivo):
    """
    Função para importar dados do arquivo de entrada do problema de roteamento de veículos
    """
    # Inicialize listas para cada coluna
    x = []
    y = []
    q = []
    wa = []
    wb = []
    
    try:
        with open(arquivo, 'r') as inn:
            # Pule as primeiras 9 linhas (cabeçalho)
            for _ in range(9):
                inn.readline()
            
            # Leia os dados dos clientes
            for line in inn:
                parts = line.split()
                if len(parts) >= 7:
                    try:
                        # Extrai os dados das colunas
                        x.append(float(parts[1]))  # XCOORD.
                        y.append(float(parts[2]))  # YCOORD.
                        q.append(float(parts[3]))  # DEMAND
                        wa.append(int(parts[4]))   # READY TIME
                        wb.append(int(parts[5]))   # DUE DATE
                    except (ValueError, IndexError):
                        # Pula linhas com problemas de formatação
                        continue
        
        # Cria uma estrutura nomeada para os dados
        Dados = namedtuple('Dados', ['x', 'y', 'q', 'wa', 'wb'])
        dados = Dados(x=x, y=y, q=q, wa=wa, wb=wb)
        
        return dados
        
    except FileNotFoundError:
        print(f"Erro: Arquivo '{arquivo}' não encontrado!")
        return None
    except Exception as e:
        print(f"Erro ao ler o arquivo: {e}")
        return None

def obter_info_veiculos(arquivo):
    """
    Função para obter informações sobre os veículos do arquivo
    """
    try:
        with open(arquivo, 'r') as inn:
            linhas = inn.readlines()
            
            # Procura pela seção VEHICLE
            for i, linha in enumerate(linhas):
                if "VEHICLE" in linha.upper():
                    # A próxima linha deve ser o cabeçalho e a seguinte os dados
                    if i + 2 < len(linhas):
                        dados_veiculo = linhas[i + 2].split()
                        if len(dados_veiculo) >= 2:
                            return {
                                'quantidade': int(dados_veiculo[0]),
                                'capacidade': int(dados_veiculo[1])
                            }
        
        print("Informações de veículo não encontradas no arquivo")
        return None
        
    except FileNotFoundError:
        print(f"Erro: Arquivo '{arquivo}' não encontrado!")
        return None

def copia_deposito(dados):
    """
    Função para copiar os dados do depósito (primeira linha) para o final dos vetores
    
    Args:
        dados (namedtuple): Dados originais contendo x, y, q, wa, wb
        
    Returns:
        namedtuple: Dados com o depósito copiado no final
    """
    # Acessando os dados dos vetores x, y, q, wa, wb
    x = dados.x.copy()        # Coordenadas da distância x
    y = dados.y.copy()        # Coordenadas da distância y
    q = dados.q.copy()        # Demanda de cada cliente
    wa = dados.wa.copy()      # Janela de tempo a
    wb = dados.wb.copy()      # Janela de tempo b
    
    # Obtenha os elementos da primeira linha (depósito)
    primeiro_x = x[0] 
    primeiro_y = y[0]
    primeiro_q = q[0]
    primeiro_wa = wa[0]
    primeiro_wb = wb[0]
    
    # Anexe os elementos da primeira linha no final dos vetores x, y, q, wa, wb
    x.append(primeiro_x)
    y.append(primeiro_y)
    q.append(primeiro_q)
    wa.append(primeiro_wa)
    wb.append(primeiro_wb)
    
    # Cria uma nova namedtuple com os dados atualizados
    Dados = namedtuple('Dados', ['x', 'y', 'q', 'wa', 'wb'])
    novos_dados = Dados(x=x, y=y, q=q, wa=wa, wb=wb)
    
    return novos_dados