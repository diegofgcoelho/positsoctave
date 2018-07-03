# This script evaluates the numerical errors of Wilkinson polynomial evaluation. 
# It uses
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
psize = [5 6 7];

# Stores the errors due to the polynomial evaluation  
cellerrpolwilkinson = cell(length(nbitsvalues),length(psize));

# Defining the number of replicates for each polynomial with each precision
NN = 100;

# Array storing the errors
errpolwilkinson = [];
rpolwilkinsontrues = [];
rpolwilkinsontests = [];
xs = [];
xtrues = [];
meanerrpolwilkinson = zeroposit(ntrue, estrue);

if(length(nbitsvalues) ~= length(esvalues))
  error('The number of nbits and es values must be the same.');
endif

fprintf('Starting actual simulation\n');

for s = 1:length(psize)

  # polynomials with 'true' precision
  polwilkinsontrue = genpolwilkinson (psize(s), ntrue, estrue);
  
  for k = 1:length(nbitsvalues)
  
    printf('polynomial size = %d with nbitvalues = %d\n', psize(s), nbitsvalues(k));
    
    # atan polynomial   
    tttic = tic();
    polwilkinsontest = genpolwilkinson (psize(s), nbitsvalues(k), esvalues(k));
    ttime = toc(tttic);
    fprintf('Time for generating tan pol: %f\n', ttime);
    
    # Running over several random generated inputs
    multc = int2posit(10, nbitsvalues(k), esvalues(k));
    subc = int2posit(5, nbitsvalues(k), esvalues(k));
    
    errpolwilkinson = [];
    
    for rep = 1:NN
      
      # x = mulc*rand-subc
      x = add(int2posit(randi(psize(s)),nbitsvalues(k), esvalues(k)), exacinv(int2posit(1000,nbitsvalues(k), esvalues(k))));
      xs = [xs x];
      
      xtrue = convposit(x, ntrue, estrue);
      xtrues = [xtrues xtrue];
      
      # Result from the polynomial
      rpolwilkinsontest = hornerp(polwilkinsontest, x);
      rpolwilkinsontests = [rpolwilkinsontests rpolwilkinsontest];
      
      # Result from the polynomial qith 'true' precision
      rpolwilkinsontrue = hornerp(polwilkinsontrue, xtrue);
      rpolwilkinsontrues = [rpolwilkinsontrues rpolwilkinsontrue];
      
      errpolwilkinson = absp(mul(sub(convposit(rpolwilkinsontest, ntrue, estrue), rpolwilkinsontrue), exacinv(rpolwilkinsontrue)));
      errpolwilkinson = [errpolwilkinson errpolwilkinson];
     
    endfor
    
    cellerrpolwilkinson{k,s} = errpolwilkinson;
    
  endfor

endfor

# This section computes the means for ech polynomial size and posit size
meancellerrspolwilkinsons = cell(size(cellerrpolwilkinson));

for n = 1:size(cellerrpolwilkinson, 1)

  for k = 1:size(cellerrpolwilkinson, 2)

    aa = cellerrpolwilkinson{n,k};
    meancellerrspolwilkinsons{n,k} = zeroposit(ntrue, estrue);
   
    for t = 1:length(aa)
  
      meancellerrspolwilkinsons{n,k} = add(meancellerrspolwilkinsons{n,k}, aa(t));
    
    endfor
    
  endfor
  
endfor