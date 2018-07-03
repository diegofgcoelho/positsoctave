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
## @deftypefn r = wilkinsonp (x, n)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-27

# This function evaluates the Wilskinson polynomial of degree n in x, where x
# and its outputs are posits. The parameters for the output posit is determined,
# the same, as the input posit. This function does not use quire (yet).

function r = wilkinsonp (x, n)

  # The output variable
  r = sub(x,int2posit(1,x.nbits, x.es));
    
  if(n == 1)
    return;
  endif
  
  for k = 2:n
    r = mul(r, sub(x, int2posit(k, x.nbits, x.es)));
  endfor

endfunction
