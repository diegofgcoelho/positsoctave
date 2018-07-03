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
## @deftypefn r = isequalp (a, b)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-29

# This function returns if the posits a and b are equal

function r = isequalp (a, b)

  if(a.nbits ~= b.nbits && a.es ~= b.es)
    r = false;
    return;
  endif
  
  if(isequal(a.regime, b.regime) && isequal(a.exponent, b.exponent) && ...
    isequal(a.mantissa, b.mantissa))
    r = true;
    return;
  else
    r = false;
    return;
  endif

endfunction
