function [a] = check_init(var, density)
%CHECK_INIT Calculate sensitivities towards initial concentrations.
%   Only sensitivities for the nonzero initial concentrations are
%   calculated.

% read parameters & initial concentrations
Param=setParam;
conc=setParam;
x=cell2mat(conc(:,1));                                                      %matdata of concentrations
global tspan;
% upper bound of integration
target=37;

% baseline readout
[tdefault,ydefault]=ode15s(@setODE,[0 tspan],x);
readout_0 = Integrate(tdefault,ydefault(:,target),tspan);
readout_0 = readout_0(end);

scale=linspace(1-var,1+var,density);


% Get number of nonzero components of the concentrations
nonzerocomponents=0;
for i=1:length(x)
    if x(i)~=0
        nonzerocomponents=nonzerocomponents+1;
    end
end


% Calculate sensitivity to initial concentration
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
        % nonzeros(e)
        [t,y]=ode15s(@setODE,[0,tspan],e);
        if max(abs(y(:,target)))<0.1
            s(j,counter)=0;
        else
            s(j,counter)=y(length(t),target)/ydefault(length(tdefault),target);
            Integral=Integrate(t,y(:,target),tspan);
            readout(j,counter)=Integral(end);
        end
        % reset values after every iteration
        e=x;
        
    end
    
end


% convert results to color map
xaxis=[1 nonzerocomponents];
yaxis=[1-var 1+var];
axis xy;
ylabel('fold derivation from default value');
xlabel('rate constants index');
for j=1:density
    for i=1:nonzerocomponents %2gruen 1weiss 0gelb  -1rot hier stimmt was nicht im farbcode
        if s(j,i)==0                                                              %no-response
            a(j,i)=0;
        else
            if s(j,i)>10                                                          %high end conc
                a(j,i)=1;
            else
                s(j,i)=readout(j,i)/readout_0;                                    %reduced transient response
                if s(j,i)<0.9
                    a(j,i)=2;
                else
                    if s(j,i)>1.1                                                 %higher transiet response
                        a(j,i)=3;
                    else                                                        %low effekt
                        a(j,i)=4;
                    end
                end
            end
        end
    end
end

figure;
clims=[0 4];
imagesc(flipud(a),clims);

colorbar;
colours=[0 1 0;1 0 0;1 1 0;0 0 1;1 1 1];
colormap(colours);

end
