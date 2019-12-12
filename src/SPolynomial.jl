using AbstractAlgebra;

export SPolynomial;

function SPolynomial(r1::T, r2::T)::Union{T, Nothing} where {T<:AbstractAlgebra.MPolyElem}
	m1 = lt(r1);
	m2 = lt(r2);
	l = lcm(m1, m2);
	return divexact(l, m1) * r1 - divexact(l, m2) * r2;
end
