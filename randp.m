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
## @deftypefn r = randp (nbits, es)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-12-04

# This function returns a random posit number with nbits bits and es exponent 
# bits in the interval (0, 1)

function r = randp (nbits, es)

  r = oneposit(nbits, es);
  
  for k = 1:length(r.mantissa)
    # The use of (unidrnd(2)-1) returns a Bernoulli distribution with probability
    # 1/2 of success
    r.mantissa(k) = (unidrnd(2)-1);
  endfor

endfunction
