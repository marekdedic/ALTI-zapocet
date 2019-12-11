using AbstractAlgebra

export rewrite;

function monomial(term::T)::T where {T<:AbstractAlgebra.MPolyElem}
	return collect(monomials(term))[1];
end

function reduce(source::T, top::T)::Union{T, Nothing} where {T<:AbstractAlgebra.MPolyElem}
	for term in terms(source)
		if !divides(term, lm(top))[1]
			continue;
		end
		termMonomial = monomial(term);
		termChecks = map(t -> monomial(t) == termMonomial, terms(source - term));
		if !isempty(termChecks) && maximum(termChecks);
			continue;
		end
		return source - divexact(term, lm(top)) * top;
	end
	return nothing;
end

