# positsoctave
An Octave implementation of Posits arithmetic

This respository contains a set of functions implementing the basic operations in posits arithmetic. Each posit is represented by an structure containing a sign, exponent size, posit size, regime, exponent, and mantissa bits.

If a and b are posits with the same parameters (exponent size and posit size), you can operate on them by using the functions add, sub, mul, div and abs by passing both posits as arguments and receiving a third posit contanaing the result.

You can also print the posit content by using the disposit function. You can also perform the product of several posits (prodp) and do define 0 and 1 posit with specific parameters by using the functions zeroposit and one posit.
