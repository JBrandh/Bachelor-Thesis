function [s] = sensitivity(var,density,mode)
%SENSITIVITY Calculates the parameter sensitivities.
%   Helper function for calculating sensitivities.
%   var: max variation in parameter
%   density: number of points for the sensitivity analysis
%   mode: analysis mode

% read parameters & initial concentrations 
Param = setParam;
Rates = setRates;
global y0;
global k;
global tspan;

T=tspan;  % upper bound of integration
target=37;

[t,y]=ode15s(@setODE,[0 tspan],y0);


% last timepoint
if strcmp(mode, 'end-concentration')
    readout_0=y(length(t),target);
end

% integral value
if strcmp(mode, 'integral')
    readout_0=Integrate(t,y(:,target),T);
    readout_0=readout_0(2,end);
end

% maximal value
if strcmp(mode, 'max')
    readout_0=max(y(:,target));
end


% definitition of scaling factors for calculating sensitivities
scale=linspace(1-var,1+var,density);

% calculate the sensitivity for all parameters & changes
s = zeros(density,length(Rates));
for i=1:length(Rates)
    for j=1:density
        k0=k(i);
        k(i)=k(i)*scale(j);
        
        [t,y]=ode15s(@setODE,[0,tspan],y0);
        
        if strcmp(mode, 'max')
             readout=max(y(:,target));
        end
        if strcmp(mode, 'integral')
            readout=Integrate(t,y(:,target),T);
            readout=readout(2,end);
        end
        
        % is this normalization correct?
        s(j,i)=((readout-readout_0)/readout_0)/((k(i)-k0)/k0);
        % reset all rate constants
        k=cell2mat(Rates(:,1));
    end
    
end

% Create sensitivity figure 
f4 = figure('Name','sensitivity rates');
figure(f4);

subplot(2,1,1);
xaxis=[1 length(Rates)];
yaxis=[1-var 1+var];
clims=[-1.5 1.5];
imagesc(xaxis,yaxis,s,clims);
title('sensitivity');
colorbar;
axis xy;
ylabel('fold derivation from default value');
xlabel('rate constants index');
mymap=[1 0 0; 1 0.3 0.3;1 0.7 0.7;1 1 1; 0.7 1 0.7; 0.3 1 0.3; 0 1 0]; % colormap red/green
colormap(mymap);

subplot(2,1,2);
plot(linspace(1,length(Rates),length(Rates)),s(1,:),'.',linspace(1,length(Rates),length(Rates)),s(density,:),'.');
title('maximal sensitivity');
xlabel('rates');
ylabel('sensitivity coefficient');
legend('0.5','1.5');
end
