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
## @deftypefn r = hornerp (p, x)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-28

# Thi fucntion returns the polynomial evaluation in x, where p are the 
# coefficients of the input polynomial. It returns
#
#               p(1)*x^(n-1)+p(2)*x^(n-2)+...+p(n),
# where n is the size of p. Both x and the elemnts of p are posits with the 
# same parameters.

function r = hornerp (p, x)

  r = p(1);
  
  for n = 2:length(p)
    r = add(p(n), mul(r, x));
  endfor

endfunction
