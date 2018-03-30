function [s] = sensitivityzero( var,density,mode )
%SENSITIVITYZERO Summary of this function goes here
%   Detailed explanation goes here
Rates=setRates;
global y0;
global tspan;
global k
target=37;








[tdefault,ydefault]=ode15s(@setODE,[0 tspan],y0);
readout_0=Integrate(tdefault,ydefault(:,target),tspan);
readout_0=readout_0(end);
s=zeros(1,length(Rates));
readout=zeros(1,length(Rates));
scale=linspace(1-var,1+var,density);

for i=1:length(Rates)
    if mode=="zeros"
        k(i)=0;
        [t,y]=ode15s(@setODE,[0,tspan],y0);
    
        if max(abs(y(:,target)))<0.1
            s(1,i)=0;
        else
            s(1,i)=y(length(t),target)/ydefault(length(tdefault),target);
            Integral=Integrate(t,y(:,target),tspan);
            readout(i)=Integral(end);
        end
        k=cell2mat(Rates(:,1));
    else
        for j=1:density
        k(i)=k(i)*scale(j);
        [t,y]=ode15s(@setODE,[0,tspan],y0);
    
        if max(abs(y(:,target)))<0.1
            s(j,i)=0;
        else
            s(j,i)=y(length(t),target)/ydefault(length(tdefault),target);
            Integral=Integrate(t,y(:,target),tspan);
            readout(j,i)=Integral(end);
        end
        k=cell2mat(Rates(:,1));
    end
    end
    
    
end
if mode=="zeros"
    for i=1:length(s) %2gruen 1weiss 0gelb  -1rot hier stimmt was nicht im farbcode
        if s(i)==0                                                              %no-response
            a(i)=0;
        else
            if s(i)>10                                                          %high end conc
                a(i)=1;
            else
                s(i)=readout(1,i)/readout_0;                                    %reduced transient response
                if s(i)<0.9
                    a(i)=2;
                else
                    if s(i)>1.1                                                 %higher transiet response
                        a(i)=3;
                    else                                                        %no effekt
                            a(i)=4;
                    end
                end
            end
        end
    end 


else
    xaxis=[1 length(Rates)];
    yaxis=[1-var 1+var];
    axis xy;
    ylabel("fold derivation from default value");
    xlabel("rate constants index");
    for j=1:density
            for i=1:length(s) %2gruen 1weiss 0gelb  -1rot hier stimmt was nicht im farbcode
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
end
figure;
clims=[0 4];
imagesc(a,clims);
colorbar;
colours=[0 1 0;1 0 0;1 1 0;0 0 1;1 1 1];
colormap(colours);

end

