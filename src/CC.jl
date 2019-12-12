using AbstractAlgebra;

import Base: show, gcd, div, rem;
import AbstractAlgebra: elem_type, parent_type, parent, needs_parentheses, displayed_with_minus_in_front, canonical_unit, divexact, mul!, addeq!, zero!, one, divides;

export CC, elem_type, parent_type, parent, show, needs_parentheses, displayed_with_minus_in_front, canonical_unit, divexact, div, rem, mul!, addeq!, zero!, one, divides;

mutable struct ComplexNumbers{T<:Complex}<:AbstractAlgebra.Ring
	function ComplexNumbers{T}() where {T<:Complex}
		if haskey(ComplexNumbersID, T)
			z = ComplexNumbersID[T]::ComplexNumbers{T};
		else 
			z = new{T}();
			ComplexNumbersID[T] = z;
		end
		return z;
	end
end

const ComplexNumbersID = Dict{DataType, AbstractAlgebra.Ring}();

const JuliaCC = ComplexNumbers{Complex{Float64}}();

const CC = JuliaCC;


# Methods

elem_type(::Type{ComplexNumbers{T}}) where {T<:Complex} = T;

parent_type(::Type{T}) where {T<:Complex} = ComplexNumbers{T};

#=
function (a::ComplexNumbers{T})(b::Complex) where {T<:Complex}
	return T(b);
end
=#

function (a::ComplexNumbers{T})(b::Integer)::Complex where {T<:Complex}
	return T(b);
end

parent(a::T) where {T<:Complex} = ComplexNumbers{T}();

function show(io::IO, R::ComplexNumbers)
   print(io, "Complex numbers");
end

needs_parentheses(::Complex)::Bool = true;

function (a::ComplexNumbers{T})()::T where {T<:Complex}
   return T(0);
end

displayed_with_minus_in_front(a::Complex)::Bool = displayed_with_minus_in_front(real(a));

function gcd(a::Complex, b::Complex)::Complex
   if isreal(a) && isreal(b)
      return gcd(real(a), real(b));
   end
   error("GCD of complex numbers");
end

canonical_unit(a::T) where {T<:Complex} = T(1);

function divexact(a::Complex, b::Complex)::Complex
   q, r = divrem(a, b);
   if !iszero(r)
      error(ArgumentError("not an exact division"));
   end
   return q;
end

function div(a::S, b::T) where {S<:Complex, T<:Complex}
   if isreal(a) && isreal(b)
      return div(real(a), real(b));
   end
   error("div of complex numbers");
end

function rem(a::S, b::T) where {S<:Complex, T<:Complex}
   if isreal(a) && isreal(b)
      return rem(real(a), real(b));
   end
   error("rem of complex numbers");
end

function div(a::S, b::T) where {S <: Integer, T <: Integer}
   r = mod(a, b)
   q = Base.div(a - r, b)
   return q
end

function mul!(a::T, b::T, c::T) where {T<:Complex}
   return b*c;
end

function addeq!(a::T, b::T) where {T<:Complex}
   return a + b;
end

function zero!(a::Complex)::Complex
   return Complex(0);
end

one(::ComplexNumbers{T}) where {T<:Complex} = T(1);

function divides(a::T, b::T)::Bool where {T<:Complex}
   return true, a / b; # TODO
end
