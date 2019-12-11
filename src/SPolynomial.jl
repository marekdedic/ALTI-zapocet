using AbstractAlgebra;

export SPolynomial;

function SPolynomial(r1::T, r2::T)::Union{T, Nothing} where {T<:AbstractAlgebra.MPolyElem}
	t = lcm(lt(r1), lt(r2));
	h1 = reducePoly(t, r1);
	h2 = reducePoly(t, r2);
	if isnothing(h1) || isnothing(h2)
		return nothing;
	end
	return h1 - h2;
end
