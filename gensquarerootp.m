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

# This function returns the polynomial expansion for the sqrt(x+1). Note that t_test
# the user needs to subtract one from y if he wants to evaluate the series on y,ie.,
# do polyval(y-1) in order to get the series approximation for sqrt(y).

function r = gensquarerootp (n, nbits, es)

  r = oneposit(nbits, es);
  
  if(n == 1)
    return;
  endif
  
  for k = 1:n
    k  
    temp_prod = mul(sub(oneposit(nbits, es),int2posit(2*k, nbits, es)), factorialp(k, nbits, es));
    temp_den = mul(temp_prod, int2posit(4^k, nbits, es));
    temp_num = prodp(ints2posit([(k+1):1:(2*k)], nbits, es));
        
    temp_div = div(temp_num, temp_den);
    r = [r temp_div];
    if(mod(k,2) ~= 0)
      r(k+1).sign = not(r(k+1).sign);
    endif
  endfor

  r = fliplr(r);
endfunction
