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
## @deftypefn addbits [s carryout] =  addbits (a, b, c)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-08

# This function performs the addition of two bits arrays of same size and 
# its carry in

function [s carryout] = addbits(a, b, c)

  # a and b are inputs
  # c is the carry in
  
  # Sanity check
  if(length(a) ~= length(b))
    error('Error! a and b (first two arguments) in addbits must be of the same size.');
  endif;
  
  # Summation result
  if(nargin == 2)
    tcarry = 0;
  else
    tcarry = c;
  endif
  
  for i = length(a):-1:1
  
    [s(i) tcarry] = addbit(a(i), b(i), tcarry);
  
  endfor
  
  # Carry out result
  carryout = tcarry;
  
endfunction
