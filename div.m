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
## @deftypefn r = div (diva, divb, niter)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-29

# This function computes the division of posits using Newton-Raphson method.
# The number of iteration can be determined. If the number of operations is not 
# passed, this function perform as much iterations as needed in order to have 
# up to the last bit correct. The second output parameter is the number of used
# iterations.

function [r k] = div (diva, divb, niter)

  if(nargin == 2)
    niter = -1; #It means that will iterate until the last bit is correct
  endif
  
  # Output variable and initial guess
  # Getting a initial guess that is greater than divb/2 and positive
  absdivb = divb; absdivb.sign = 0;
  r = absdivb; r.mantissa = zeros(size(r.mantissa));
  r = exacinv(r); 
  
  k = 0;
  lcond = true;
  while(lcond)
    k = k+1;
    
    r_ = r;
    r = mul(r, sub(int2posit(2, absdivb.nbits, absdivb.es), mul(absdivb, r)));
    
    if((niter == -1 && ~isequalp(r,r_)) || (k < niter))
      lcond = true;
    else
      lcond = false;
    endif
  endwhile
  
  r.sign = divb.sign;
  
  r = mul(r, diva);

endfunction
