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
## @deftypefn r = genpolwilkinson(n ,nbits, es)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-12-03

# This function returns the n degree Wilkinson polynomial

function r = genpolwilkinson (n, nbits, es)

  % Polynomial from Prof. Vassil
  % degree 5
  % -120 + 274 x - 225 x^2 + 85 x^3 - 15 x^4 + x^5
  % degree 6
  % 720 - 1764 x + 1624 x^2 - 735 x^3 + 175 x^4 - 21 x^5 + x^6
  % degree 7
  % -5040 + 13068 x - 13132 x^2 + 6769 x^3 - 1960 x^4 + 322 x^5 - 28 x^6 + x^7
  % degree 8
  % 40320 - 109584 x + 118124 x^2 - 67284 x^3 + 22449 x^4 - 4536 x^5 + 546 x^6 - 36 x^7 + x^8
  % degree 9
  % -362880 + 1026576 x - 1172700 x^2 + 723680 x^3 - 269325 x^4 + 63273 x^5 - 
  % 9450 x^6 + 870 x^7 - 45 x^8 + x^9
  % degree 10
  % 3628800 - 10628640 x + 12753576 x^2 - 8409500 x^3 + 3416930 x^4 - 902055 x^5 + 157773 x^6 - 18150 x^7 + 1320 x^8 - 55 x^9 + x^10


  coeffs5 = fliplr([-120 274 -225 85 -15 1]);
  coeffs6 = fliplr([720 -1764 1624 -735 175 -21 1]);
  coeffs7 = fliplr([-5040 13068 -13132 6769 -1960 322 -28 1]);
  coeffs8 = fliplr([40320 -109584 118124 -67284 22449 -4536 546 -36 + 1]);
  coeffs9 = fliplr([-362880 1026576 -1172700 723680 -269325 63273 -9450 870 -45 1]);
  coeffs10 = fliplr([3628800 -10628640 12753576 -8409500 3416930 -902055 157773 -18150 1320 -55 1]);
  
  cellcoeffs = {coeffs5, coeffs6, coeffs7, coeffs8, coeffs9, coeffs10};
  
  r = [];
  
  if(n < 5 || n >10)
    disp('Error: genpolwilkinson currently supports only degrees from 5 to 10');
  else
    r = ints2posit(cellcoeffs{n-4}, nbits, es);
  endif
  
endfunction
