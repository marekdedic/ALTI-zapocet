using AbstractAlgebra;

export buchberger;

function buchberger(ideal::Ideal{T})::Ideal{T} where {T<:AbstractAlgebra.MPolyElem}
	if ideal.is_groebner
		return ideal;
	end
	generators = gens(ideal);
	for (i, g1) in enumerate(collect(generators))
		for g2 in collect(generators)[i + 1:end]
			reduced = reducePolyStar(SPolynomial(g1, g2), generators);
			if reduced != zero(ideal)
				push!(generators, reduced);
				return buchberger(Ideal(base_ring(ideal), generators, false));
			end
		end
	end
	return Ideal(base_ring(ideal), generators, true);
end
