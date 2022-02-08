    Assignment description
    
In this assignment we will study the creation and properties of pseudo-random binary sequences, PRBS.

The "system_simulator" function obtains experimental data from the system given an input signal. This simulation takes the place of the real experiment, for both identification and validation.

Requirements:

  Generate first a validation dataset with "system_simulator".
  
  Write a function that generates an input signal of length N using maximum-length PRBS with a register of a given length m, and wich switches between given values a and b. Parameters N, m, a, b are given as inputs to this functions, and m is limited to the range 3,4,...10.
  
  Generate an identification input signal of sufficient length (say around 300 samples) with m=3, taking values a=0.5 and b=1. Apply this signal to the system using "system_simulator".
  
  Identify an ARX model with the identification data obtained.
  
  Repeat the above but now with m=10.
