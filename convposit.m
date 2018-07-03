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
## @deftypefn r = convposit (a, nbits, es)
##
## @seealso{}
## @end deftypefn

## Author: diego <diegofgcoelho@gmail.com>
## Created: 2017-12-01

# This function converts the input posit to a posit with nbits bits and es 
# exponent bits, only if nbits >= a.nbits and es >= a.es.

function r = convposit (a, nbits, es)
  
  if(nbits < a.nbits || es < a.es)
    disp('Error: nbits and es must be greater than the parameters for the current input posit.');
    printf('Current a.nbits  = %d, a.es = %d, new parameters nbits = %d, es = %d\n', a.nbits, e.es, nbits, es);
  endif
  
  if(~isempty(a.mantissa))
  
    ttotalexp = ((-1)^(a.regime(1,1)+1))*(regrunlength(a.regime))*2^a.es+mbin2dec(a.exponent);
    
    expval = mod(ttotalexp, 2^es);
    
    a.exponent = mdec2bin(expval, es);
    
    regimeval = ttotalexp+expval*(-1)^(a.regime(1,1)+1);
    
    if(regimeval >= 0)
      a.regime = [ones([1 round(abs(regimeval)/2^es)+1]) 0];
    else
      a.regime = [zeros([1 round(abs(regimeval)/2^es)]) 1];
    endif
        
    a.mantissa = [a.mantissa zeros(1,nbits-a.nbits-(es-a.es))];
  elseif(~isempty(a.exponent))

    ttotalexp = ((-1)^(a.regime(1,1)+1))*(regrunlength(a.regime))*2^a.es+mbin2dec(a.exponent);
    
    expval = mod(ttotalexp, 2^es);
    
    a.exponent = mdec2bin(expval, es);
    
    regimeval = ttotalexp+expval*(-1)^(a.regime(1,1)+1);
    
    if(regimeval >= 0)
      a.regime = [ones([1 round(abs(regimeval)/2^es)+1]) 0];
    else
      a.regime = [zeros([1 round(abs(regimeval)/2^es)]) 1];
    endif
 
    a.exponent = [zeros(1,es-length(a.exponent)) a.exponent];
    a.mantissa = zeros(1,nbits-a.nbits-(es-length(a.exponent)));
  else

    ttotalexp = ((-1)^(a.regime(1,1)+1))*(regrunlength(a.regime))*2^a.es;
    
    a.exponent = mdec2bin(0, es);
    
    if(ttotalexp >= 0)
      a.regime = [ones([1 round(abs(ttotalexp)/2^es)+1]) 0];
    else
      a.regime = [zeros([1 round(abs(ttotalexp)/2^es)]) 1];
    endif
  
    if(xor(a.regime(1,1), a.regime(1,end)) == 1)
      a.exponent = [zeros(1,min(es, nbits-1-length(a.regime)))];
      a.mantissa = zeros(1,nbits-1-length(a.exponent)-length(a.regime));
    else
      if(a.regime(1,1) == 1)
        if(nbits-a.nbits >= 1)
          a.regime = [a.regime 0];
          a.exponent = [zeros(1,min(es, nbits-1-length(a.regime)))];
          a.mantissa = zeros(1,nbits-1-length(a.exponent)-lenght(a.regime));
        endif
      else
        a.regime = [a.regime zeros(1,nbits-a.nbits)];
      endif
    endif
  endif

  a.nbits = nbits;
  a.es = es;
  
  r = a;
  
endfunction
