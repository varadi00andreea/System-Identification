    Assignment description
    
We will study the recursive variant of the ARX method. The data is provided in the "lab10_1" file. The system has order n, given in variable 'n' in the data file, that it is of the output error type and that it has no time delay. To account for the model type mismatch we will take larker orders for all the ARX models to be found. The recommendation is to take na=nb=3*n.


Requirements:

  Implement the general recursive ARX algorithm.
  
  Run it on the identification data, using an initial matrix with the parameter delta=0.01.
  
  Repeat the experiment for the initial matrix with the parameter delta=100.
