function rates = setRates(  )
%SETRATES Reading parameters from file.
%   Reading parameter values in cell.
[ratesv,ratest,ratesr] = xlsread('param.xls','','','basic');
rates = cell(length(ratesv),3);
rates(:,1) = num2cell(ratesv);
rates(:,2) = ratest(:,2);
rates(:,3) = ratesr(:,3);
end

