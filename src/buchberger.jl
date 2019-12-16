using AbstractAlgebra;

export buchberger;

function buchberger(ideal::Ideal{T})::Ideal{T} where {T<:AbstractAlgebra.MPolyElem}
	if ideal.is_groebner
		return ideal;
	end
	generators = deepcopy(gens(ideal));
	for (i, g1) in enumerate(generators)
		for (j, g2) in enumerate(generators[i + 1:end])
			println(string(i) * ", " * string(i + j));
			println();
			reduced = reducePolyStar(SPolynomial(g1, g2), generators);
			if reduced != zero(ideal)
				println(generators);
				println(g1);
				println(g2);
				println(SPolynomial(g1, g2));
				println(reduced);
				println();
				push!(generators, reduced);
				return buchberger(Ideal(base_ring(ideal), generators, false));
			end
		end
	end
	return Ideal(base_ring(ideal), generators, true);
end
