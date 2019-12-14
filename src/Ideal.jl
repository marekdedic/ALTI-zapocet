using AbstractAlgebra;

import Base: show, zero, in;
import AbstractAlgebra: base_ring, gens;

export Ideal, base_ring, gens, show, in;

abstract type IdealType<:AbstractAlgebra.Ring end

abstract type IdealElem<:RingElem end

mutable struct Ideal{T<:AbstractAlgebra.RingElem}<:IdealType
	base_ring::AbstractAlgebra.Ring;
	generators::Set{T};
	is_groebner::Bool;
	is_reduced::Bool;
	is_normalized::Bool;

	function Ideal(base_ring::AbstractAlgebra.Ring, generators::Set{T}, is_groebner::Bool = false, is_reduced::Bool = false, is_normalized::Bool = false)::Ideal where {T<:AbstractAlgebra.RingElem}
		return new{T}(base_ring, Set(base_ring.(generators)), is_groebner, is_groebner && is_reduced, is_groebner && is_reduced && is_normalized);
	end
end

function Ideal(base_ring::AbstractAlgebra.Ring, generators::Vector{T})::Ideal where {T<:AbstractAlgebra.RingElem}
	return Ideal(base_ring, Set(generators));
end

function Ideal(base_ring::AbstractAlgebra.Ring, generator::T)::Ideal where {T<:AbstractAlgebra.RingElem}
	return Ideal(base_ring, Set([generator]));
end

function base_ring(a::Ideal)::AbstractAlgebra.Ring
	return a.base_ring;
end

function gens(a::Ideal{T})::Set{T} where {T<:AbstractAlgebra.RingElem}
	return a.generators;
end

function zero(a::Ideal{T})::T where {T<:AbstractAlgebra.RingElem}
	return zero(base_ring(a));
end

function show(io::IO, a::Ideal)
	print(IOContext(io, :compat => true), "Ideal of ", base_ring(a), " with generators ", gens(a));
end

function in(item::T, ideal::Ideal{T})::Bool where {T<:AbstractAlgebra.MPolyElem}
	if !ideal.is_groebner
		error("Cannot determine if an item is a member of an Ideal with a non-Groebner basis.");
	end
	reduced = reducePolyStar(item, gens(ideal));
	return iszero(reduced);
end
