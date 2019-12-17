using GroebnerBasis;
using AbstractAlgebra;

R, (x, y) = PolynomialRing(QQ, ["x", "y"], ordering = :deglex);

x > y

g1 = x^2 - 2y^2;
g2 = x*y - 3;
f = 2y^4 - 2y^3 - x + 3;

I = Ideal(R, [g1, g2]);

I2 = buchberger(I)
I3 = reduceBase(I2)
I4 = normalizeBase(I3)

f ∈ I4
