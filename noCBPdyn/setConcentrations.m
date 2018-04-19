function concentrations = setConcentrations( varargin )
%SETCONCENTRATIONS Summary of this function goes here
%   Detailed explanation goes here
concentrations=zeros(nargin:1);
for j=1:nargin    
    concentrations(j,1)=varargin{j} ;
end

end