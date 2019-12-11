using GroebnerBasis;
using AbstractAlgebra;

R, (x, y) = PolynomialRing(ZZ, ["x", "y"], ordering = :lex);

f = x*y + 1;
g = x^2 + x - 2y;

I = Ideal(R, [f, g]);

buchberger(I);
