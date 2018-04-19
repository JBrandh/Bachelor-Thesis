function conc = setParam( )
%SETPARAM Reads initial concentrations from file.
%   Returns initial concentrations as cell.

[iconcv,iconct,iconcr] = xlsread('initial_concentrations.xls','','','basic');
conc = cell(length(iconcv),3);
conc(:,1) = num2cell(iconcv);
conc(:,2) = iconct(:,3);
conc(:,3) = iconcr(:,4);

end

