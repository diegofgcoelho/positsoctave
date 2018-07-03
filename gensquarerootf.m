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
## @deftypefn r = gensquarerootf (n)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-12-03

# This function returns the polynomial expansion for the sqrt(x+1). Note that
# the user needs to subtract one from y if he wants to evaluate the series on y,ie.,
# do polyval(y-1) in order to get the series approximation for sqrt(y).

function r = gensquarerootf (n)

  r = zeros(1,n+1);
  
  r(1) = 1;
  
  if(n == 1)
    return;
  endif
  
  for k = 1:n
    r(k+1) = ((-1)^k)*prod([(k+1):1:(2*k)])/((1-2*k)*factorial(k)*(4^k));
  endfor

  r = fliplr(r);
endfunction
