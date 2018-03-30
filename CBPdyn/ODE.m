function [dx] = ODE(k,x,t)
%ODE Summary of this function goes here
%   Detailed explanation goes here
dx=zeros(length(x),1);
for j=1:length(x)
    dx(j)=eval(getODE(j,k(j),x(j)));
end

end

