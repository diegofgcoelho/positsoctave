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
## @deftypefn  r = wilkinsonp (x, n)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-27

# This function evaluates the Wilskinson polynomial of degree n in x, where x
# and its outputs are floating points. The type of floating point 
# (single or double precision), will depend on the platform octave runs.


function r = wilkinsonf (x, n)

  # The output variable
  r = x-1;
    
  if(n == 1)
    return;
  endif
  
  for k = 2:n
    r = r*(x-k);
  endfor


endfunction
