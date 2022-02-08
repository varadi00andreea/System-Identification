
      Transient Analysis of Step Response
  
The "lab2_order1_2" contains several stept input signals and the response of a first-order system, and the "lab2_order2_2" file contains similar data for a second-order system. Every data set contains five consecutive step signal, each corresponding to 100 time steps. The initial conditions are zero.

In the MATLAB code, I've developed a transfer function model of the system, using the first step signal and response from the data. After this, the model is validated (by using the validation data) and mse is computed. The same goes for the second order system.
