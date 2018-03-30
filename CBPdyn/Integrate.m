function [ I ] = Integrate( t,T,f )
%INTEGRATE Summary of this function goes here
%   Detailed explanation goes here


n=10;
T=1:T*n;


vq = interp1(t*n,f,T,'spline');
vq=double(vq)/double(n);



I=zeros(2,length(T));
for i=2:length(T)
    I(1,i)=T(i)/(3600*n);
    I(2,i)=I(2,i-1)+((T(i)-T(i-1))*(vq(i)+(vq(i)-vq(i-1))/2));
end




end

