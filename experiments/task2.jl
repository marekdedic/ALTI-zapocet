using GroebnerBasis;
using AbstractAlgebra;

R, (y, x) = PolynomialRing(QQ, ["y", "x"], ordering = :lex);

x < y

g1 = x*y - x^3 - x^2;
g2 = x^4 + x^3 + x;
f = x^4*y^4 + x^3*y^3;

I = Ideal(R, [g1, g2]);

I2 = buchberger(I)
I3 = reduceBase(I2)
I4 = normalizeBase(I3)

f ∈ I4
