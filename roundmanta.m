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
## @deftypefn rmantissa = roundmanta (mantissa)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-10

# This function rounds the input totalmantissa using nn bits for the additon. 
# The input totalmantissa is a array of bits and must has size greater than nn. 
# The carryout is necessary in case the rounding requires addition and it 
# requires a carry. The totalmentissa is actually the mantissa appended with the
# carry (if it exists) from the mantissas addition.

function [rmantissa carryout] = roundmanta (totalmantissa, nn)

  # Check if the mantissa has at least size nn+3, if not, zeros are appended. In
  # the later case, the guard bits will all be valued 0
  
  if(length(totalmantissa) < nn+3)
    totalmantissa = [totalmantissa zeros(1,nn+3-length(totalmantissa))];
  endif

  # Last bit
  L = totalmantissa(1,nn);
  # Guard bit
  G = totalmantissa(1,nn+1);
  # Round bit
  R = totalmantissa(1,nn+2);

  # Calculating the sticky bit
  T = 0;
  for i = (nn+3):length(totalmantissa)
    T = or(T, totalmantissa(1,i));
  endfor
  
  # Computing the round bit
  rnd = and(G,or(L,or(R, T)));
  
  temp = zeros(1, nn); temp(1,end) = rnd;
  [rmantissa carryout] = addbits(totalmantissa(1,1:nn), temp);
  
endfunction
