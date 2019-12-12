using AbstractAlgebra;

import Base.show;
import AbstractAlgebra: elem_type, parent_type, parent, needs_parentheses;

export CC, elem_type, parent_type, parent, show, needs_parentheses;

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

function (a::ComplexNumbers{T})(b::Integer) where {T<:Complex}
	return T(b);
end

parent(a::T) where {T<:Complex} = ComplexNumbers{T}();

function show(io::IO, R::ComplexNumbers)
   print(io, "Complex numbers");
end

needs_parentheses(::Complex) = true;

function (a::ComplexNumbers{T})() where {T<:Complex}
   return T(0)
end

function gcdinv(a::T, b::T) where T <: Integer
   g, s, t = gcdx(a, b)
   return g, s
end
