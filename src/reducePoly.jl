using AbstractAlgebra

export reducePoly, reducePolyStar;

function reducePoly(source::T, top::T)::T where {T<:AbstractAlgebra.MPolyElem}
	return divrem(source, top)[2];
end

function reducePoly(source::T, top::Set{T}, encountered::Set{T} = Set([source]))::Union{T, Nothing} where {T<:AbstractAlgebra.MPolyElem}
	for t in top
		ret = reducePoly(source, t);
		if !isnothing(ret) && ret ∉ collect(encountered)
			return ret;
		end
	end
	return nothing;
end

function reducePolyStar(source::T, top::Set{T})::T where {T<:AbstractAlgebra.MPolyElem}
	function terminatingCheck(source::T, top::Set{T}, encountered::Set{T})::T
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
	return terminatingCheck(source, top, Set{T}([source]));
end
