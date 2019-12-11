using AbstractAlgebra;

export buchberger;

function buchberger(i::Ideal{T})::Ideal{T} where {T<:AbstractAlgebra.MPolyElem}
	if i.is_groebner
		return i;
	end
	generators = gens(i);
	for (i, g1) in enumerate(collect(generators))
		for g2 in collect(generators)[i + 1:end]
			reduced = reducePolyStar(SPolynomial(g1, g2), generators);
			if reduced != zero(i)
				push!(generators, reduced);
				return buchberger(Ideal(base_ring(i), generators, false));
			end
		end
	end
	return Ideal(base_ring(i), generators, true);
end
