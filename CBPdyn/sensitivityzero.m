function [s] = sensitivityzero(  )
%SENSITIVITYZERO Summary of this function goes here
%   Detailed explanation goes here
Rates=setRates;
global y0;
global tspan;
global k
target=37;
[tdefault,ydefault]=ode15s(@setODE,[0 tspan],y0);
s=zeros(1,length(Rates));
for i=1:length(Rates)
    k(i)=0;
    [t,y]=ode15s(@setODE,[0,tspan],y0);
    s(1,i)=y(length(t),target)/ydefault(length(tdefault),target);
    k=cell2mat(Rates(:,1));
end

for i=1:length(s)
    if s(i)<0.5
        a(i)=1;
    else
        if s(i)<2
            a(i)=0;
        else
            a(i)=-1;
        end
    end
end
figure;
imagesc(a);
colorbar;
colours=[1 0 0;1 1 1; 0 1 0];
colormap(colours);

end

