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
## @deftypefn addbits [s carryout] =  addbits (a, b, c)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-08

# This function performs the multiplication of arrays of bits. The resulting bit
# array is truncated with nbits. If nbits is empty, then the result has the size
# that is the addition of both inputs minus -1.

function [m carryout] = mulbits(a, b, nbits)

  if(nargin == 2)
    nbits = length(a)+length(b)-1;
  endif
  
  # Temporary variable storing the result
  m = zeros(1,length(a)+length(b)-1);
  
  # Variable storing the carry
  carryout = 0;
  
  for i = length(b):-1:1
  
    if(isequal(b(i), 1))
      # This part represents the shift
      tta = zeros(1,length(a)+length(b)-1);
      tta(1,i:i+length(a)-1) = a;
    
      # Performing addition
      [m carryout] = addbits(m,tta, carryout);
    endif
    
  endfor
  
  m = m(1,1:nbits);
  
endfunction
