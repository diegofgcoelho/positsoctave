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
## @deftypefn r = genatanpolp (n, nbits, es)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-29

function r = genatanpolp (n, nbits, es)

  r = [];
  
  for k = 1:n+1
    r = [r zeroposit(nbits, es)];
  endfor

  k = 1;
  while(k <= (n+1)/2)
      tempp = int2posit(2*k-1, nbits, es);
      tempp = div(oneposit(nbits, es), tempp);

      if(-(-1)^(k) == -1)
        tempp.sign = not(tempp.sign);
      endif
      r(2*k) = tempp;
      k = k+1;
  endwhile
  
  r = fliplr(r);
  
endfunction
