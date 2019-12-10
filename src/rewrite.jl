using AbstractAlgebra

export rewrite;

function monomial(term::T)::T where {T<:AbstractAlgebra.MPolyElem}
	return collect(monomials(term))[1];
end

function rewrite(source::T, top::T)::T where {T<:AbstractAlgebra.MPolyElem}
	for term in terms(source)
		if !divides(term, lm(top))[1]
			println("AAA");
			continue;
		end
		termMonomial = monomial(term);
		shouldSkip = false;
		for innerTerm in terms(source - term)
			innerMonomial = monomial(innerTerm);
			if innerMonomial == termMonomial
				println(innerMonomial);
				println(termMonomial);
				shouldSkip = true;
				break;
			end
		end
		if shouldSkip
			continue;
		end
		return source - divexact(term, lm(top)) * top
	end
	error("No way to rewrite " * string(source) * " using " * string(top) * "!")
end
