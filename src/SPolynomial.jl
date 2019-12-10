using AbstractAlgebra;

export SPolynomial;

function SPolynomial(r1::T, r2::T)::T where {T<:AbstractAlgebra.MPolyElem}
	t = lcm(lt(r1), lt(r2));
	h1 = rewrite(t, r1);
	h2 = rewrite(t, r2);
	return h1 - h2;
end
