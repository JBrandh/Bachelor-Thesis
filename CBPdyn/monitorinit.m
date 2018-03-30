function [  ] = monitorinit( specie,specied,lb,hb)
%MONITORINIT Summary of this function goes here
%   Detailed explanation goes here
Rates=setRates;
conc=setParam;
x=cell2mat(conc(:,1));    
n=10;

global d;
global tspan;

e=x;
scale=linspace(lb,hb,n-1);
figure;
for i=1:n-1
    e(specied)=x(specied)*scale(i);
    sol=ode15s(@setODE,[0,tspan],e);    
    v(i)=sol;
    th=sol.x/3600;
    subplot(2,5,i);
    plot(th,sol.y(specie,:));
    str=conc(specie,2);
    title(str+" "+conc(specied,2)+"*"+num2str(scale(i)))
    xlabel("time in h");
    ylabel(conc(specie,2));
    
    e=cell2mat(conc(:,1));  
end
subplot(2,5,10);
plot(v(1).x/3600,v(1).y(specie,:),v(2).x/3600,v(2).y(specie,:),v(3).x/3600,v(3).y(specie,:),v(4).x/3600,v(4).y(specie,:),v(5).x/3600,v(5).y(specie,:),v(6).x/3600,v(6).y(specie,:),v(7).x/3600,v(7).y(specie,:),v(8).x/3600,v(8).y(specie,:),v(9).x/3600,v(9).y(specie,:))
xlabel("time in h");
ylabel(conc(specie,2));

end

