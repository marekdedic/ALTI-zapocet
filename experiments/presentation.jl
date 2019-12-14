using GroebnerBasis;
using AbstractAlgebra;

R, (x, y) = PolynomialRing(QQ, ["x", "y"], ordering = :lex);

g1 = x^2 + 2x*y^2;
g2 = x*y + 2y^3 - 1;

I = Ideal(R, [g1, g2]);

I2 = buchberger(I)
I3 = reduceBase(I2)
I4 = normalizeBase(I3)
