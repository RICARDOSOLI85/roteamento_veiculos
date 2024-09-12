# Função para ler os paramtros 
# versao 12/10/23 
# modificacao:  
# Ricardo Soares Oliveira


function unroll(instancias::NamedTuple)
     # Lendo os arquivos dos parametros
  n = instancias.nV 
  nV =instancias.nV 
  nN = instancias.nN
  nL = instancias. nL 
  nK = instancias.nK 
  nE = instancias.nE
  # Conjuntos 
  V = instancias.V   # Vértices 
  N = instancias.N   # Cópias 
  L = instancias.L   # Entregadores por veículo 
  K = instancias.K   # Veículos 
  EN = instancias.EN 
  
  # Parametros do decisor 
  p1 = instancias.p1 # 
  p2 = instancias.p2 # 
  p3 = instancias.p3 
  # Capacidade 
  Q = instancias.Q # Capacidade 
  q = instancias.q # Parâmetros 
  # Parametros (janela de tempo, distancia, tempo)
  wa = instancias.wa # Janela de tempo Começo 
  wb = instancias.wb # Janela de tempo Fim 
  d = instancias.d   # Matriz da distância 
  t = instancias.t   # Matriz do Tempo
  M = instancias.M   # Número de veículos 
  E = instancias.E   # Numero de entregadores 
  # Tempo de servico 
  s = instancias.s 
 
  return n, nV,nN,nL,nK,nE, V, N, L, K, EN, p1, p2, p3, Q, q, wa, wb, d, t, M, E, s
end