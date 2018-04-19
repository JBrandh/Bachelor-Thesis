function [] = plotmax( specie,change,r,mode )
%PLOTMAX Summary of this function goes here
%   Detailed explanation goes here

Rates=setRates;
conc=setParam;
x=cell2mat(conc(:,1)); 
global y0;

global k;
global tspan;

n=100;
scale=linspace(0,r,n);
f=zeros(n,1);
if mode=='rate'
    for i=1:n
        k(change)=k(change)*scale(i);
        sol=ode15s(@setODE,[0 tspan],y0);
        f(i)=max(sol.y(specie,:));
        k=cell2mat(Rates(:,1));
    end
    figure;
    plot(scale(:),f(:));
    xlabel('k('+int2str(change)+')*x');
    str=conc(specie,2);
    ylabel(str+' max');
end

if mode=='specie'
    for i=1:n
        x(change)=x(change)*scale(i);
        sol=ode15s(@setODE,[0 tspan],x);
        f(i)=max(sol.y(specie,:));
        x=cell2mat(conc(:,1));
    end
    figure;
    plot(scale(:),f(:));
    spec=conc(change,2);
    xlabel(spec+'*x');
    str=conc(specie,2);
    ylabel(str+' max'); 
end

end

