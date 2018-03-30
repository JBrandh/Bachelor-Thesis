function conc = setParam(  )
%SETPARAM Summary of this function goes here
%   Detailed explanation goes here

[iconcv,iconct,iconcr]=xlsread('initial_concentrations.xls','','','basic');
conc=cell(length(iconcv),3);
conc(:,1)=num2cell(iconcv);
conc(:,2)=iconct(:,3);
conc(:,3)=iconcr(:,4);

end

