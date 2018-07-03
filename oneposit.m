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
## @deftypefn {Function File} {@var{retval} =} oneposit (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-27

function r = oneposit (nbits, es)

  r = posit();
  r.sign = 0;
  r.regime = [1 0];
  r.exponent = zeros(1, es);
  r.mantissa = zeros(1, nbits-es-3);
  r.nbits = nbits;
  r.es = es;
  return;

endfunction
