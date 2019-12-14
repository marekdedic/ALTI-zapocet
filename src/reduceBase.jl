using AbstractAlgebra;

export reduceBase;

function reduceBase(ideal::Ideal{T})::Ideal{T} where {T<:AbstractAlgebra.MPolyElem}
	if ideal.is_reduced
		return ideal;
	end
	if !ideal.is_groebner
		error("Trying to reduce non-Groebner basis ideal " * string(ideal));
	end
	generators = gens(ideal);
	for (i, g1) in enumerate(collect(generators))
		for g2 in collect(generators)[i + 1:end]
			if divides(lm(g2), lm(g1))[1]
				delete!(generators, g2);
				return reduceBase(Ideal(base_ring(ideal), generators, true));
			end
			reduced = reducePoly(g2, g1);
			println(g2);
			println(reduced);
			println();
			if !iszero(reduced) && g2 != reduced
				delete!(generators, g2);
				push!(generators, reduced);
				return reduceBase(Ideal(base_ring(ideal), generators, true));
			end
		end
	end
	return Ideal(base_ring(ideal), generators, true, true);
end
