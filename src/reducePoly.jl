using AbstractAlgebra

export reducePoly, reducePolyStar;

function monomial(term::T)::T where {T<:AbstractAlgebra.MPolyElem}
	return collect(monomials(term))[1];
end

function reducePoly(source::T, top::T)::Union{T, Nothing} where {T<:AbstractAlgebra.MPolyElem}
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

function reducePoly(source::T, top::Set{T})::Union{T, Nothing} where {T<:AbstractAlgebra.MPolyElem}
	for t in top
		ret = reducePoly(source, t);
		if !isnothing(ret)
			return ret;
		end
	end
	return nothing;
end

function reducePolyStar(source::T, top::Set{T})::T where {T<:AbstractAlgebra.MPolyElem}
	function terminatingCheck(source::T, top::Set{T}, encountered::Set{T})::T
		reduced = reducePoly(source, top);
		if reduced in encountered
			error("The reducing graph is not terminating");
		end
		if length(encountered)>100
			error("The reducing graph is not terminating");
		end
		if isnothing(reduced)
			return source;
		end
		push!(encountered, reduced);
		return terminatingCheck(reduced, top, encountered);
	end
	return terminatingCheck(source, top, Set{T}());
end
