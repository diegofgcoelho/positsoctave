## Copyright (C) 2017  Diego Coelho, PhD Candidate, University of Calgary
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
## @deftypefn r = int2posit (intg)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-27

# This function converts an input integer to posit format using nbits bits and
# a exponent of size es.

function r = int2posit (intg, nbits, es)

  # Sign
  if(intg > 0)
    signr = 0;
  elseif(intg < 0)
    signr = 1;
  else
    # Declaring the zero and returning it
    r = posit(0, zeros(1,nbits-1), [], [], nbits, es);
    return;
  endif

  intg = abs(intg);
  
  # Finding the mantissa
  tmant = zeros(1,nbits);
  for n = nbits-1:-1:0
  if(intg >= 2^n)
      intg = intg-2^n;
      tmant(nbits-n) = 1;
    endif
  endfor

  yy = find(tmant);
  
  # If yy is empty, then the number afer conversion (for this nbits) is null
  if(isempty(yy))
    r = posit(0, zeros(1,nbits-1), [], [], nbits, es);
    return;
  endif

  # Searh for the MSB
  totalexp = nbits-yy(1); # This will be positive because we are dealing with intgers  
  if(yy(1) ~= length(tmant))
    tmant = tmant(1,yy(1)+1:end);
  else
    tmant = [];
  endif
  
  # Variabel used to create the regime bits
  lreg = idivide(int32(totalexp), int32(2^es), 'fix');
  regime = [ones(1,lreg+1) 0]; # Remember that lreg will be always positive
  lexp = mod(int32(totalexp), int32(2^es));
  exponent = zeros(1,es);
  for n = 1:lexp
    exponent = addbits(exponent, zeros(1,es), 1);
  endfor
  
  # Create the posit to be returned
  r = posit(signr, regime, exponent, tmant, nbits, es); 

endfunction
