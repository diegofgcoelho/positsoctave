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
## @deftypefn disposit disposit (posit)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-08

# This function simply display the posit passed as input. If a second argument 
# is passed and ti contains the string 'float', then the posit is displayed in
# floating point format.
# This function will not return anything if it is not requested. However, if
# if retun variable is used, it returns an string represnting the posit. If the
# mode is float, the string is represented in base 10, and 2 otherwise.


function r = disposit (a, mode)

  # Check if the input posit bits are all 0. If yes, it represents the zerocrossing
  if(isequal(a.sign, 0) && isequal(a.regime, zeros(size(a.regime))) && ...
    isequal(a.exponent, zeros(size(a.exponent))) && ...
    isequal(a.mantissa, zeros(size(a.mantissa))))
    if(nargin == 2)
      fprintf('and = %f\n', 0.0);
    else
      fprintf('Total exponent: %d, Mantissa: %f\n', 0, 0.0);
    endif
    return;   
  endif

  # Check if the input is + or - infinity
  if(length(a.regime) == a.nbits-1 && ~xor(a.regime(1,1), a.regime(1,end)))
    if(a.sign == 0)
      fprintf('Total input is +infinity\n');
    else
      fprintf('Total input is -infinity\n');
    end
    return;
  endif
  
  # Evaluate mantissa
  manval = 1;
  for i = 1:length(a.mantissa)
    manval = manval+a.mantissa(i)*2^(-i);
  endfor

  # Check sign
  if(a.sign == 1)
    manval = -manval;
  endif
  
  # Numerical operation over the regime bits. 
  
  # The ((-1)^(regime(1,1)+1)) is necessary to account for the 
  # regime bit sequence for the regime bits regarding the sign. The regime bits
  # have size greater than 1, always, so if the first bit is 1, it means that
  # the sequence is compounded by 1's fowllowed by 0, which implies a positive
  # coefficients due to the regime bits. If the first bit is 0, it means that the
  # sequence is of 0's followed by 1, which in this case implies that the 
  # coefficients due to the regime bits is negative. Also, if the first regime bit
  # is 1, the numerical meaning of it is length(a.regime)-1, and 
  # length(a.regime)-2 otherwise.
  
  # We first treat the normal case, when the regime bits does not clamp the 
  # exponent and mantissa bits and then treat the separate case where the exponent
  # is not present in the posit
  
  if(length(a.regime) < a.nbits-1)
    ttotalexp = ((-1)^(a.regime(1,1)+1))*(regrunlength(a.regime))*2^a.es+mbin2dec(a.exponent);
  else
    # Note that we have an extra (-1)^(a.regime(1,1)+1)) in this expression. 
    # This is because we are accountfin for the case where the posit regime
    # bits clamped the exponent and mantissa
    ttotalexp = ((-1)^(a.regime(1,1)+1))*(regrunlength(a.regime))*2^a.es...
      +(-1)^(a.regime(1,1)+1);
  endif
  
  if(nargin == 2)
    if(isequal(mode, 'float'))
      fprintf('ans = %.100f\n', manval*(2^ttotalexp));
    endif
  else
    fprintf('Total exponent: %d, Mantissa: %f\n', ttotalexp, manval);
  endif
  
  if(nargout == 1)
    if(nargin == 2)
      if(isequal(mode, 'float'))
        r = strcat(num2str(manval), '*10^{', num2str(ttotalexp*log10(2)), '}');
      endif
    else
      r = strcat(num2str(manval), '*2^{', num2str(ttotalexp), '}');
    endif
    
  endif

endfunction
