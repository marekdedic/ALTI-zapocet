using GroebnerBasis;
using AbstractAlgebra;

R, (x, y, z) = PolynomialRing(QQ, ["x", "y", "z"], ordering = :lex);

x > y
y > z

g1 = 2x + y + 4z - 1;
g2 = x - y - z - 1;
g3 = 2x - y + z + 1;

I = Ideal(R, [g1, g2, g3]);

I2 = buchberger(I)
I3 = reduceBase(I2)
I4 = normalizeBase(I3)
