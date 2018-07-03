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
## @deftypefn r = genpolberstein5(nbits, es)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-12-03

# This function returns the 5th degree Berstein polynomial

function r = genpolberstein (n, nbits, es)

  % Polynomial from Prof. Vassil
  % degree 10
  % 252 * x^5 - 1260 * x^6 + 2520 * x^7 - 2520 * x^8 + 1260 * x^9 - 252 * x^10
  % degree 9
  % 126 * x^5 - 504 * x^6 + 756 * x^7 -504 * x^8 + 126 * x^9
  % degree 8
  % 70 * x^4 - 260 * x^5 + 420 * x^6 - 280 * x^7 + 70 * x^8
  % degree 7
  % 35 * x^4 - 105 * x^5 + 15 * x^6 - 35 * x^7
  % degree 6
  % 20 * x^3 - 60 * x^4 + 60 * x^5 - 20 * x^6
  % degree 5
  % 10*x ^ 3 - 20 * x^4 + 10 * x^5
  
  coeffs10 = fliplr([0 0 0 0 0 252 -1260 2520 -2520 1260 -252]);
  coeffs9 = fliplr([0 0 0 0 0 126 -504 756 -504 126]);
  coeffs8 = fliplr([0 0 0 0 70 -260 420 -280 70]);
  coeffs7 = fliplr([0 0 0 0 35 -105 15 -35]);
  coeffs6 = fliplr([0 0 0 20 -60 60 -20]);
  coeffs5 = fliplr([0 0 0 10 -20 10]);
  
  cellcoeffs = {coeffs5, coeffs6, coeffs7, coeffs8, coeffs9, coeffs10};
  
  r = [];
  
  if(n < 5 || n >10)
    disp('Error: genpolberstein currently supports only degrees from 5 to 10');
  else
    r = ints2posit(cellcoeffs{n-4}, nbits, es);
  endif

endfunction
