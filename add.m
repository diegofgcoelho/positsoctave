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
## @deftypefn c = add (posita, positb), where posita and positb are posits
##
## @seealso{posit, disposit}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-11-08

# This method returns the result of the addition of two posits. Both 
# inputs must have the same parameters (nbits and es). The result will also have
# the same parameters

function positc = add (posita, positb)

  # Check if one of the arguments is zero. If yes, return the other argument
  if(posita.sign == 0 && isequal(posita.regime, zeros(size(posita.regime))) && ...
    isequal(posita.exponent, zeros(size(posita.exponent))) && ...
    isequal(posita.mantissa, zeros(size(posita.mantissa))))
    positc = positb;
    return;
  endif
  if(positb.sign == 0 && isequal(positb.regime, zeros(size(positb.regime))) && ...
    isequal(positb.exponent, zeros(size(positb.exponent))) && ...
    isequal(positb.mantissa, zeros(size(positb.mantissa))))
    positc = posita;
    return;
  endif
  
  # Create a posit element and set its parameters
  positc = posit();
  
  positc.nbits = posita.nbits;
  positc.es = posita.es;
  
  # Fixing mantissa sizes
  dsizea = length(posita.mantissa)-length(positb.mantissa);
  
  # Fixing the exponents
  if(length(posita.exponent) <= posita.es)
    posita.exponent = [zeros(1,posita.es-length(posita.exponent)) posita.exponent];
  endif;
  if(length(positb.exponent) <= positb.es)
    positb.exponent = [zeros(1,positb.es-length(positb.exponent)) positb.exponent];
  endif;  
  
  # Fixing the mantissas.
  # Note that it includes the hidden bit as well. The 1 in front
  # of the actual mantissa represents the hidden bit. The two zeros represents,
  # respectively, the sign (the first one) in 2's complement and the second is
  # a bit in case of overflow
  posita.mantissa = [0 0 1 posita.mantissa];
  positb.mantissa = [0 0 1 positb.mantissa];
  posita.mantissa = [posita.mantissa zeros(1, max(-dsizea, 0))];
  positb.mantissa = [positb.mantissa zeros(1, max(dsizea, 0))];
  
  # Finds the largest posit
  # Note that the 
  # (length(posita.regime)-1) is necessary to remove from the counting the
  # last regime bit. The ((-1)^(regime(1,1)+1)) is necessary to account for the 
  # regime bit sequence for the regime bits regarding the sign. The regime bits
  # have size greater than 1, always, so if the last bit is 1, it means that
  # the sequence is compounded by 0's fowllowed by 1, which implies a negative
  # coefficients due to the regime bits. If the last bit is 0, it means that the
  # sequence is of 1's followed by 0, which in this case implies that the 
  # coefficients due to the regime bits is positive.
  taregime = ((-1)^(posita.regime(1,1)+1))*regrunlength(posita.regime);
  tbregime = ((-1)^(positb.regime(1,1)+1))*regrunlength(positb.regime);
  
  taexp = mbin2dec(posita.exponent);
  tbexp = mbin2dec(positb.exponent);
  # Total exponent
  tatotalexp = taregime*2^posita.es+taexp;
  tbtotalexp = tbregime*2^positb.es+tbexp;
  
  # Exponent alignment
  amantsize = length(posita.mantissa);
  bmantsize = length(positb.mantissa);
  if(tatotalexp > tbtotalexp)
    ddiff = tatotalexp-tbtotalexp;
    if(ddiff > bmantsize)
      # If this if is positive, there nothing to do but return posita
      positc = posita;
      return;
    else
      # If the else statemant occurs, then we need to align the exponents
      positb.mantissa = [zeros(1,ddiff) positb.mantissa(1,1:bmantsize)];
      posita.mantissa = [posita.mantissa(1,1:amantsize) zeros(1,ddiff)];
      positb.exponent = posita.exponent;
      positb.regime = posita.regime;
      
      positc.regime = posita.regime;
      positc.exponent = posita.exponent;
    endif
  else
    ddiff = tbtotalexp-tatotalexp;
    if(ddiff > amantsize)
      # If this if is positive, there nothing to do but return positb
      positc = positb;
      return;
    else
      # If the else statemant occurs, then we need to align the exponents
      posita.mantissa = [zeros(1,ddiff) posita.mantissa(1,1:amantsize)];
      positb.mantissa = [positb.mantissa(1,1:bmantsize) zeros(1,ddiff)];
      posita.exponent = positb.exponent;
      posita.regime = positb.regime;
      
      positc.regime = positb.regime;
      positc.exponent = positb.exponent;

    endif
  endif;
  tcregime = ((-1)^(positc.regime(1,1)+1))*regrunlength(positc.regime);
  # End of the seciton alinging the exponents. From now on, the mantissas have 
  # been shifted accordingly and we can prodceed with additon/subtraction 
  # according the input signs
  
  
  # Temporary variables with the mantissas with approrpiate 2's complement 
  # representation.
  tamant = posita.mantissa;
  tbmant = positb.mantissa;
  if(posita.sign == 1)
    tamant = addbits(not(tamant), zeros(1,length(tamant)), 1);
  endif
  if(positb.sign == 1)
    tbmant = addbits(not(tbmant), zeros(1,length(tbmant)), 1);
  endif
  # End of section assigning mantissas values and sign
  rmant = addbits(tamant, tbmant);
  
  # Check reulsting sign and possible overflow
  positc.sign = rmant(1,1);
  if(positc.sign == 1)
    # If the result is negative, take the 2's complement
    rmant = addbits(not(rmant), zeros(size(rmant)), 1);
  endif
  # Remove the sign bit
  rmant = rmant(1,2:end);
  # Search for the first one after the sign
  yy = find(rmant);
  if(~isempty(yy))
    expshift = -(yy(1)-2); 
  else
    # if yy is empty, it means that the mantissa is totatlly zero
    # expshift = 0;
    positc.sign = 0;
    positc.regime = zeros(1,positc.nbits-positc.es-1-1);
    positc.mantissa = 0;
    return;
  endif
  
  texp = [0 positc.exponent];
  #tregime = positc.regime;
  while(expshift ~= 0)
    if(expshift < 0)
      expshift = expshift+1;
      stexp = texp(1);
      texp = addbits(texp, ones(size(texp)));
      if(xor(stexp, texp(1)))
        tcregime = tcregime-1;
      endif
      # Shifting the mantissa
      rmant = [rmant(1,2:end) 0];
    else
      expshift = expshift-1;
      stexp = texp(1);
      texp = addbits(texp, zeros(1,length(texp)), 1);
      if(xor(stexp, texp(1)))
        tcregime = tcregime+1;
      endif
      # Shifting the mantissa
      rmant = [0 rmant(1,1:end-1)];
    endif
  endwhile
  
  # Unecessary part. Removed.
  # Change the exponent 2's complement if necessary
  #if(texp(1) == 1)
  #  texp = addbits(not(texp), zeros(size(texp)), 1);
  #endif
  
  positc.exponent = texp(1,2:end);
  
  # Determines the new regime bits for positc
  if(tcregime >= 0)
    positc.regime = [ones(1,tcregime+1) 0];
  else
    positc.regime = [zeros(1,-tcregime) 1];
  endif
  # At this point, exponent, regime its and mantissa for positc are all with 
  # correct values, expect that we need to round the mantissa and adjust its
  # size to fit positc
  
  # Rounding
  rmant = rmant(1,2:end);
  [rmant rmcarry] = roundmanta(rmant, max(positc.nbits-(length(positc.regime)+positc.es+1)+1,1));
  # Adjusting the exponent and regime bits in case of overflow
  if(rmcarry == 1)
    [positc.exponent expcarry] = addbits(positc.exponent, zeros(1,positc.es), 1);
    if(expcarry == 1)
      # Update the new bits for positc
      tcregime = tcregime+1;
      if(tcregime >= 0)
        positc.regime = [ones(1,tcregime+1) 0];
      else
        positc.regime = [zeros(1,-tcregime) 1];
      endif
    endif
    positc.mantissa = rmant(1,1:max((positc.nbits-(length(positc.regime)+positc.es+1)), 1));
  else
    # If there is no carry, there is nothing to do but just return positc
    positc.mantissa = rmant(1,2:max((positc.nbits-(length(positc.regime)+positc.es+1)+1), 1)); # eliminating the leading bit
  endif
  
  # Cleaning the exponent
  positc.exponent = positc.exponent(1,1:min(positc.es, positc.nbits-1-length(positc.regime)));
  
endfunction
