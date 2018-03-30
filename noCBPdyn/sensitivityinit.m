function [ s ] = sensitivityinit( var,density,mode )
%SENSEITIVITYINIT Summary of this function goes here
%   Detailed explanation goes here
Param=setParam;
conc=setParam;
x=cell2mat(conc(:,1));                                                      %matdata of concentrations           
global tspan;


T=tspan;                                                                  %upper bound of integration
target=37;


[t,y]=ode15s(@setODE,[0 tspan],x);                                                           
if mode=="max"
    readout_0=max(y(:,target));
end
if mode=="integral"
    readout_0=Integrate(t,y(:,target),T);
readout_0=readout_0(2,end);
end
                                                              
scale=linspace(1-var,1+var,density);
nonzerocomponents=0;
for i=1:length(x)
   
    if x(i)~=0
         nonzerocomponents=nonzerocomponents+1;
    end
end
s=zeros(density,nonzerocomponents);

e=zeros(length(conc),1);
e=x;

counter=0;
for i=1:length(x)    
    
    if e(i)==0
            continue;
    end
    counter=counter+1;
    for j=1:density
        e(i)=x(i)*scale(j);
        
        [t,y]=ode15s(@setODE,[0,tspan],e);
        if mode=="max"
             readout=max(y(:,target));
        end
        if mode=="integral"
            readout=Integrate(t,y(:,target),T);
            readout=readout(2,end);
        end
        s(j,counter)=((readout-readout_0)/readout_0)/((e(i)-x(i))/x(i));
        
        e=x;       
        
    end
   
end

f5=figure('Name','sensitivity initial conditions');
figure(f5);

subplot(2,1,1);
x=[1 nonzerocomponents];
y=linspace(1+var,1-var,density);
clims=[-1.5 1.5];
imagesc(x,y,flipud(s),clims);
title('sensitivity');
colorbar;
axis xy;
ylabel("fold-derivation of default value");
xlabel("initial concentrations");
mymap=[1 0 0; 1 0.3 0.3;1 0.7 0.7;1 1 1; 0.7 1 0.7; 0.3 1 0.3; 0 1 0]; %colormap red/green
colormap(mymap);


subplot(2,1,2);

plot(linspace(1,nonzerocomponents,nonzerocomponents),s(1,:),'.',linspace(1,nonzerocomponents,nonzerocomponents),s(density,:),'.');
title('maximal sensitivity');
xlabel("initial concentration");
ylabel("sensitivity coefficient");
legend("0.5","1.5");
end

