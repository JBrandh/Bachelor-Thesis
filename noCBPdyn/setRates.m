function rates = setRates(  )
%SETRATES Summary of this function goes here
%   Detailed explanation goes here
[ratesv,ratest,ratesr]=xlsread('param.xls','','','basic');
rates=cell(length(ratesv),3);
rates(:,1)=num2cell(ratesv);
rates(:,2)=ratest(:,2);
rates(:,3)=ratesr(:,3);
end

