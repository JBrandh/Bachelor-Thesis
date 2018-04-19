function [] = subplotting(species, vertical, horizontal,name,sol)
%SUBPLOTTING Summary of this function goes here
%   Detailed explanation goes here
conc=setParam;
f=figure('Name',name);
figure(f)
t=sol(:,1);
th=t/3600;
for i=1:length(species)    
            subplot(vertical,horizontal,i);
            plot(th,sol(:,species(i)+1));
            title(conc(species(i),2));
            xlabel('time in h');
            ylabel(conc(species(i),2));    
end


end

