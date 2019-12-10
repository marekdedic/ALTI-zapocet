using AbstractAlgebra;

export buchberger;

function buchberger(generators::Set{T})::Set{T} where {T<:AbstractAlgebra.RingElem}
end

function buchberger(i::Ideal{T})::Ideal{T} where {T<:AbstractAlgebra.RingElem}
	if i.is_groebner
		return i;
	end
	return Ideal(base_ring(i), buchberger(gens(i)), true);
end
