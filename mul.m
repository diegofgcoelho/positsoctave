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
## @deftypefn c = mul (posita, positc), where posita and positb are posits
##
## @seealso{posit, disposit}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-08

# This method returns the result of the multiplication of two posits. Both 
# inputs must have the same parameters (nbits and es). The result will also have
# the same parameters

function positc = mul (posita, positb)

  # Create a posit element and set its parameters
  positc = posit();
  
  positc.nbits = posita.nbits;
  positc.es = posita.es;
  
  # Logical operation over the sign
  positc.sign = xor(posita.sign, positb.sign);
 
  # Numerical operation over the exponent bits. First check if they are empty
  # or have different sizes
  if(length(posita.exponent) == 0 && length(positb.exponent) == 0)
    posita.exponent = zeros(1,posita.es);
    positb.exponent = zeros(1,positb.es);
  endif
  dexpsize = length(posita.exponent)-length(positb.exponent);
  if(dexpsize > 0)
    positb.exponent = [zeros(1,dexpsize) positb.exponent];
  else
    posita.exponent = [zeros(1,-dexpsize) posita.exponent];
  endif
  [texp carryexp]= addbits(posita.exponent, positb.exponent, 0);
  
  positc.exponent = texp;
  
  # Numerical operation over the regime bits. Note that the 
  # (length(posita.regime)-1) is necessary to remove from the counting the
  # last regime bit. The ((-1)^(regime(1,1)+1)) is necessary to account for the 
  # regime bit sequence for the regime bits regarding the sign. The regime bits
  # have size greater than 1, always, so if the last bit is 1, it means that
  # the sequence is compounded by 0's fowllowed by 1, which implies a negative
  # coefficients due to the regime bits. If the last bit is 0, it means that the
  # sequence is of 1's followed by 0, which in this case implies that the 
  # coefficients due to the regime bits is positive.
  tregime = ((-1)^(posita.regime(1,1)+1))*regrunlength(posita.regime)+...
    ((-1)^(positb.regime(1,1)+1))*regrunlength(positb.regime);
    
  tregime = tregime+carryexp;
  
  if(tregime >= 0)
    positc.regime = [ones(1,tregime+1) 0];
  else
    positc.regime = [zeros(1,-tregime) 1];
  endif
 
  # Numerical operation over mantissa bits
  tamantissa = ones(1, length(posita.mantissa)+1);
  # Inserting the 1 (hidden bit) in front of the mantissa array of bits
  tamantissa(2:end) = posita.mantissa;
  
  tbmantissa = ones(1, length(positb.mantissa)+1);
  # Inserting the 1 (hidden bit) in front of the mantissa array of bits
  tbmantissa(2:end) = positb.mantissa;
  
  [mantissa ccarry] = mulbits(tamantissa, tbmantissa);
  
  tmantissa = [];
  
  # If the carry out from the multplication of the mantissas is 1, then we 
  # update the array of bits of the mantissa
  if(ccarry == 1) 
    [tmantissa mrcarry]= roundmantm([1 mantissa], max(positc.nbits-(length(positc.regime)+positc.es+1)+1, 1));
  else
    [tmantissa mrcarry] = roundmantm(mantissa, max(positc.nbits-(length(positc.regime)+positc.es+1)+1, 1));
  endif
  
  # Check for the value of the overflows for the mantissa multiplication and
  # the rounding.
  [overs overc] = addbits(ccarry, mrcarry);
  
  #Update the exponent and the regime bits
  temp = zeros(1,length(positc.exponent)); 
  # modified here to make posit(16,1) works
  if(length(positc.exponent) == 1)
    temp(1,end) = overs;
    [texp carryexp] = addbits(positc.exponent, or(temp, overc));
  else
    temp(1,end-1:end) = [overc overs];
    [texp carryexp] = addbits(positc.exponent, temp);
  endif
   
  positc.exponent = texp;
    
  # Update the regime bits (if needed)
  tregime = tregime+carryexp;
  if(tregime >= 0)
    positc.regime = [ones(1,tregime+1) 0];
  else
    positc.regime = [zeros(1,-tregime) 1];
  endif
  
  # Check regime bits size, and cut short if they are too long.
  positc.regime = positc.regime(1,1:min(length(positc.regime),positc.nbits-1));
  
  # Assign the mantissa
  if(mrcarry == 1)
    positc.mantissa = tmantissa(1,1:(positc.nbits-(length(positc.regime)+positc.es+1)));
  else
    if(length(tmantissa) >= (positc.nbits-(length(positc.regime)+positc.es+1)+1))
      positc.mantissa = tmantissa(1,2:(positc.nbits-(length(positc.regime)+positc.es+1)+1));
    else
      positc.mantissa = [tmantissa(1,2:end) zeros(1,(positc.nbits-(length(positc.regime)+positc.es+1)+1)-length(tmantissa))];
    endif
  endif
  
  # Truncating exponent and mantissa bits, if necessary
  positc.exponent = positc.exponent(1,1:min(positc.nbits-1-length(positc.regime), length(positc.exponent)));
  positc.mantissa = positc.mantissa(1,1:positc.nbits-1-length(positc.regime)-length(positc.exponent));
  
endfunction
