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

function bin = mdec2bin (input, bsize)

  if(2^bsize <= input)
    fprintf('Error: the output array size too small. It must be at least ceil(log2(input))\n');
    return;
  endif
  
  bin = zeros([1 bsize]);
  for i = 1:bsize
    rmod = mod(input, 2^(bsize-i));
    if(rmod < input)
      input = rmod;
      bin(i) = 1;
    endif
  endfor
endfunction
