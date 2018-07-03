## Copyright (C) 2017 Diego Coelho, PhD Candidate, University of Calgary
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn posit {@var{retval} =} posit (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-07

#This class represent the posit numerical representation proposed by Prof. John
#Gustafson. It uses the octave multiprecision package (mp) for the 
#of its internal parameters (sign, regime, exponent, and mantissa).

#If no argument is passed to the constructor, the returned posit represents
#the zero using nbits = 16 bits in total, es = 7 (following Prof. John notes,
#page 42 where it states that he recommends es = log2(nbits)-3).
#Prof. John notes can be found at 


function p = posit (sign, regime, exponent, mantissa, nbits, es)

# sign: just one bit long
# regime: a vector of 1`s or 0`s ended by an opposite value (0 or 1)
# exponent: a vector of 1`s or 0`s of size es
# mantissa: a vector of 1`s or 0`s whose number of bits is what is left after 
#           the sign, regime and exponent bits has been placed


  if(nargin == 0)
    p = struct("sign", 0, "regime", [0 0 0 0 0 0 1], "exponent", [0],...
      "mantissa", [0 0 0 0 0 0 0],...
      "nbits", 16, "es", 1);   
  else
    # Checking if the mantissa is greater or smaller than what it should be.
    # If it is smaller, we append zeros, if greater, it is truncated.

    if(length(regime) <= nbits-es-1)
      nn = 1+es+length(regime);
      if(length(mantissa) > nbits-nn)
        fprintf('\nThe mantissa of the input posit will be truncated (not rounded to the nearest).');
        mantissa = mantissa(1,1:nbits-nn);
      elseif(length(mantissa) < nbits-nn)
        tmantissa = zeros(1, nbits-nn);
        tmantissa(1:length(mantissa)) = mantissa;
        mantissa = tmantissa;
      endif
    elseif(length(regime) < nbits-1)
      fprintf('\nThe mantissa and the exponent of the input posit will be clipped off.');
      mantissa = [];
      exponent = exponent(1,1:nbits-length(regime)-1);
    else
      fprintf('\nThe mantissa and the exponent and the regime bits of the input posit will be clipped off.');
      mantissa = [];
      exponent = [];
      regime = regime(1,1:nbits-1);
    endif
    p = struct("sign", sign, "regime", regime, "exponent", exponent,...
      "mantissa", mantissa,...
      "nbits", nbits, "es", es);
  endif
endfunction
