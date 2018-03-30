function [] = monitor( specie,specied,param,bounds)
%MONITOR Summary of this function goes here
%   Detailed explanation goes here

Rates=setRates;
conc=setParam;
x=cell2mat(conc(:,1));  
n=10;

global k;
global tspan;
e=x;
scale=zeros(length(specied)+length(param),n-1);                             %setting scales for input parameters
for i=1:(length(specied)+length(param))    
    scale(i,:)=linspace(bounds(i,1),bounds(i,2),n-1);
end

fmonitor=figure('Name',"monitor "+conc(specie,2));
fmonitorI=figure('Name',"monitor integral "+conc(specie,2));
figure(fmonitor);
figure(fmonitorI);
for i=1:n-1
    for j=1:length(specied)                                                 %changing initial conditions  
        e(specied(j))=e(specied(j))*scale(j,i);
    end
    
    for j=1:length(param)                                                   %changing rates
        k(param(j))=k(param(j))*scale(j+length(specied),i);
    end
    
    
    sol=ode15s(@setODE,[0,tspan],e);    
    v(i)=sol;
    th=sol.x/3600;
    figure(fmonitor)
    subplot(2,5,i);
    plot(th,sol.y(specie,:));
    str="";
    for j=1:length(specied)                                                 %setting string for name
        str=str+" "+conc(specied(j),2)+"*"+num2str(scale(j,i));
    end
    for j=1:length(param)
        str=str+" "+"k("+param(j)+")*"+num2str(scale(j+length(specied),i));
    end
    
    title(str)
    xlabel("time in h");
    ylabel(conc(specie,2));
    
    I=Integrate(sol.x,sol.y(specie,:),tspan);                               %monitoring produced specie
    
    figure(fmonitorI)
    subplot(2,5,i);
    plot(I(1,:),I(2,:));
    str="";
    
    for j=1:length(specied)
        str=str+" "+conc(specied(j),2)+"*"+num2str(scale(j,i));             %setting string for name
    end
    for j=1:length(param)
        str=str+" "+"k("+param(j)+")*"+num2str(scale(j+length(specied),i));
    end
    title(str)
    xlabel("time in h");
    ylabel(conc(specie,2)+" prduced");
    
    
    subplot(2,5,10);
    hold on    
    plot(I(1,:),I(2,:));
    xlabel("time in h");
    ylabel(conc(specie,2)+" produced");
    hold off
    k=cell2mat(Rates(:,1));
    e=cell2mat(conc(:,1));  
end
figure(fmonitor);
subplot(2,5,10);
plot(v(1).x/3600,v(1).y(specie,:),v(2).x/3600,v(2).y(specie,:),v(3).x/3600,v(3).y(specie,:),v(4).x/3600,v(4).y(specie,:),v(5).x/3600,v(5).y(specie,:),v(6).x/3600,v(6).y(specie,:),v(7).x/3600,v(7).y(specie,:),v(8).x/3600,v(8).y(specie,:),v(9).x/3600,v(9).y(specie,:))
xlabel("time in h");
ylabel(conc(specie,2));
end


