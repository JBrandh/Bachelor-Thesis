function [ dx ] = testODE( t,x )
%TESTODE Summary of this function goes here
%   Detailed explanation goes here

STAT0=50;
PPN=60;
k1=0.01;
k2=0.0005;
k3=0.0001;


f=STAT0*exp(-k3*PPN*t);

dx=k1*f-k2*x;

end

