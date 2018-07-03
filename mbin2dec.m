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
## @deftypefn dec = mbin2dec (inputarray)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-10

# This function convert the input array of 0's and 1's to a decimal number, 
# assuming that the input array is abinary number. Note that if the input array
# is empty, then the returned value is null

function dec = mbin2dec (inputarray)
  dec = 0;
  for i = length(inputarray):-1:1
    dec = dec+inputarray(1,i)*2^(length(inputarray)-i);
  endfor
endfunction
