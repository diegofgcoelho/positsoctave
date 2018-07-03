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
## @deftypefn r = exacdiv (diva)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-29

# This function computes the exact inverse where the argument has mantissa that 
# is the unity (the number represented in a power of 2)

function r = exacinv (diva)


  tregime = ((-1)^(diva.regime(1,1)+1))*regrunlength(diva.regime);
  texp = mbin2dec(diva.exponent);
  #Total exponent
  ttotalexp = tregime*2^diva.es+texp;
  ttotalexp = -ttotalexp;
  
  # Variabel used to create the regime bits
  lreg = idivide(int32(ttotalexp), int32(2^diva.es), 'fix');
  if(ttotalexp >= 0)
    nregime = [ones(1,lreg+1) 0];
  else
    lreg = lreg-1;
    nregime = [zeros(1,-lreg) 1]; 
  endif
  
  lexp = ttotalexp-lreg*2^diva.es;
  nexponent = zeros(1,diva.es);
  for n = 1:lexp
    nexponent = addbits(nexponent, zeros(1,diva.es), 1);
  endfor
    
  #Resizing exponent, if needed
  r = posit(diva.sign, nregime, nexponent, ...
    zeros(1,diva.nbits-length(nregime)-length(nexponent)-1), diva.nbits, diva.es);
  return;

endfunction
