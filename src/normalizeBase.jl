using AbstractAlgebra;

export normalizeBase;

function normalizeBase(ideal::Ideal{T})::Ideal{T} where {T<:AbstractAlgebra.MPolyElem}
	if ideal.is_normalized
		return ideal;
	end
	if !ideal.is_reduced
		error("Trying to normalize non-reduced basis ideal " * string(ideal));
	end
	generators = map(g -> divexact(g, lc(g)), collect(gens(ideal)));
	return Ideal(base_ring(ideal), Set(generators), true, true, true);
end
