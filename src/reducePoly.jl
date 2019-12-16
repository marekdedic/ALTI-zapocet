using AbstractAlgebra

export reducePoly, reducePolyStar;

function reducePoly(source::T, top::T)::T where {T<:AbstractAlgebra.MPolyElem}
	return divrem(source, top)[2];
end

function islessPoly(a::T, b::T)::Bool where {T<:AbstractAlgebra.MPolyElem}
	if lm(a) < lm(b)
		return true;
	end
	if lm(a) > lm(b)
		return false;
	end
	return islessPoly(a - lt(a), b - lt(b));
end

function reducePoly(source::T, top::Vector{T}, encountered::Vector{T} = [source])::Union{T, Nothing} where {T<:AbstractAlgebra.MPolyElem}
	for t in sort(top; lt = islessPoly)
		ret = reducePoly(source, t);
		if !isnothing(ret) && ret ∉ encountered
			println("reducPoly: ", t);
			return ret;
		end
	end
	return nothing;
end

function reducePolyStar(source::T, top::Vector{T})::T where {T<:AbstractAlgebra.MPolyElem}
	function terminatingCheck(source::T, top::Vector{T}, encountered::Vector{T})::T
		reduced = reducePoly(source, top, encountered);
		if length(encountered)>100
			error("The reducing graph is not terminating");
		end
		if isnothing(reduced)
			return source;
		end
		push!(encountered, reduced);
		return terminatingCheck(reduced, top, encountered);
	end
	return terminatingCheck(source, top, [source]);
end
