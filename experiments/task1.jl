using GroebnerBasis;
using AbstractAlgebra;

R, (x, y) = PolynomialRing(QQ, ["x", "y"], ordering = :lex);

f = x*y + 2; # Originaly was x*y + 1
g = x^2 + x - 2y;

I = Ideal(R, [f, g]);

I2 = buchberger(I)
I3 = reduceBase(I2)
I4 = normalizeBase(I3)
