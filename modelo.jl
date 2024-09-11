# Arquivo calcular os valores das instancias 
# Ricardo Soares Oliveira
# 11 de Setembro 2024

using JuMP
using LinearAlgebra
using Gurobi

"""
    minimiza_robusto(delta::Vector{Int64},gama::Vector{Int64},instancias::String)

TBW
"""
function minimiza_robusto(delta::Int64,gama::Int64,instancias::NamedTuple)
    
    # extrair os valores dos Data Frames 
    include("unroll.jl")
    unroll(instancias)
    n, nV,nN,nL,nK,nE, V, N, L, K, EN, p1, p2, p3, Q, q, wa, wb, d, t, M, E, s =  unroll(instancias::NamedTuple)
    # Aqui você pode continuar com a lógica do modelo de otimização
    println("Número de vértices: $nV")
    println("Delta: $delta, Gama: $gama")
    return n, nV,nN,nL,nK,nE, V, N, L, K, EN, p1, p2, p3, Q, q, wa, wb, d, t, M, E, s
end