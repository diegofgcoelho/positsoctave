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
## @deftypefn mul {@var{retval} =} mul (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-08

# This function performs the addition of two bits and its carry in

function [s carryout] = addbit(a, b, c)

  # a and b are inputs
  # c is the carry in
  
  # Summation result
  s = xor(a, xor(b, c));
  
  # Carry out result
  carryout = or(or(and(a, b), and(a, c)), and(b, c));

endfunction
