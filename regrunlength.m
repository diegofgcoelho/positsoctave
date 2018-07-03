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
## @deftypefn z = regrunlength (posit.regime)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-09

# This function returns the regime bits run length, where the input argument of
# this funciton must be a valid regime bit (either 0's followed by only one 1
# or the other way around). The output argument is the numericla meaning, as
# pointed out in 
#
# Beating Floating Point at its Own Game: Posit Arithmetic, by
# John L. Gustafson and Isaac Yonemoto
#

function runlen = regrunlength (regime)

  # If the string is of 0's folowed by a 1, the numerical meaning is the negative
  # of the length minus 1, otherwise it is the length minus 2.
  
  if(regime(1,1) == 0 && regime(1,end) == 1)
    # case 000 ... 1
    runlen = length(regime)-1;
    return;
  
  elseif(regime(1,1) == 0 && regime(1,end) == 0)
    # case 000 ... 0
    runlen = length(regime);
    return;
    
  elseif(regime(1,1) == 1 && regime(1,end) == 0)
    # case 111 ... 0
    runlen = length(regime)-2;
    return;
  
  else
    # case 111 ... 1
    runlen = length(regime)-1;
    return;
  
  endif

endfunction
