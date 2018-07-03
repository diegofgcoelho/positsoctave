# This script evaluates the numerical errors of polynomial evaluation. It uses
# ntrue bits posits with estrue bits for exponents in order to represent 
# quantities assumed as true values (very high precision). The posits parameters
# tested are in the vectors nbitsvalues and esvalues.

fprintf('Starting preparation for simulation\n');

# Defining posit parameters. These vectors must have the same size
nbitsvalues = [16, 32, 64];
esvalues = [1, 3, 4]; # not sure about it, waiting on Prof. Vassil response

# Defining nbits and es for 'true' values
ntrue = 256;
estrue = 10; # Check Prof. John notes for optimal size

# Defining polynomial sizes
psize = [3 4 5 6 7];

# Stores the errors due to the polynomial evaluation  
cellerrpol1s = cell(length(nbitsvalues),length(psize));

# Defining the number of replicates for each polynomial with each precision
NN = 100;

# Array storing the errors
errpol1s = [];
rpol1trues = [];
rpol1tests = [];
xs = [];
xtrues = [];
meanerrpol1s = zeroposit(ntrue, estrue);

if(length(nbitsvalues) ~= length(esvalues))
  error('The number of nbits and es values must be the same.');
endif

fprintf('Starting actual simulation\n');

for s = 1:length(psize)

  # polynomials with 'true' precision
  pol1true = genpol1p (psize(s), ntrue, estrue);
  
  for k = 1:length(nbitsvalues)
  
    printf('polynomial size = %d with nbitvalues = %d\n', psize(s), nbitsvalues(k));
    
    # atan polynomial   
    tttic = tic();
    pol1test = genpol1p (psize(s), nbitsvalues(k), esvalues(k));
    ttime = toc(tttic);
    fprintf('Time for generating tan pol: %f\n', ttime);
    
    # Running over several random generated inputs
    multc = int2posit(10, nbitsvalues(k), esvalues(k));
    subc = int2posit(5, nbitsvalues(k), esvalues(k));
    
    errpol1s = [];
    
    for rep = 1:NN
      
      # x = mulc*rand-subc
      x = sub(mul(multc, randp(nbitsvalues(k), esvalues(k))), subc);
      xs = [xs x];
      
      xtrue = convposit(x, ntrue, estrue);
      xtrues = [xtrues xtrue];
      
      # Result from the polynomial
      rpol1test = hornerp(pol1test, x);
      rpol1tests = [rpol1tests rpol1test];
      
      # Result from the polynomial qith 'true' precision
      rpol1true = hornerp(pol1true, xtrue);
      rpol1trues = [rpol1trues rpol1true];
      
      errpol1 = absp(mul(sub(convposit(rpol1test, ntrue, estrue), rpol1true), exacinv(rpol1true)));
      errpol1s = [errpol1s errpol1];
     
    endfor
    
    cellerrpol1s{k,s} = errpol1s;
    
  endfor

endfor

# This section computes the means for ech polynomial size and posit size
meancellerrspol1s = cell(size(cellerrpol1s));

for n = 1:size(cellerrpol1s, 1)

  for k = 1:size(cellerrpol1s, 2)

    aa = cellerrpol1s{n,k};
    meancellerrspol1s{n,k} = zeroposit(ntrue, estrue);
    
    for t = 1:length(aa)
  
      meancellerrspol1s{n,k} = add(meancellerrspol1s{n,k}, aa(t));
    
    endfor
    
  endfor
  
endfor