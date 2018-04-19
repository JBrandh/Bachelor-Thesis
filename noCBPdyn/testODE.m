function [dx] = testODE(t, x)
%TESTODE Simple ODE system for testing.
%   ODE test system.

% parameters
STAT0 = 50;
PPN = 60;
k1 = 0.01;
k2 = 0.0005;
k3 = 0.0001;

% assignments
f = STAT0*exp(-k3*PPN*t);

% odes
dx = k1*f -k2*x;

end

