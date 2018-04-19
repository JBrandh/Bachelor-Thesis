%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sensitivity analysis in JAK-signalling
%
% This is the main entry point for the analysis and allows 
% to calculate the various sensitivities in the model.
%
% - setODE: ode system
% - setParam|initial_concentrations.xls: initial concentrations of ODE
% - setRates|param.xls: parameters of ODE system
%
% Key specie of interest is y(37): nuclear activated STAT1-dimer inhibitor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---------------------
% read parameters and initial concentrations
% ---------------------
Param=setParam;
conc=setParam;
global y0;
y0 = cell2mat(conc(:,1));
Rates=setRates;
global k;
k = cell2mat(Rates(:,1));

% defining time points for model (model time in seconds)
global tspan;
tspan=3600*14;  %time of simulation (14[h])
global tstart;
tstart=3600*2;  %timepoint where stimulus is added (2[h])
global tstim;
tstim=3600*8;   %time stimulation is active (puls stimulation) (8[h])

% integration
[t,y]=ode15s(@setODE,[0 tspan],y0);
sol=[t,y];
th=t/3600;

% Plot the timecourse of key players
% subplotting([6 7 17 24 25],5,1,'Time Courses',sol);  % Figure 3

I=Integrate(t,y(:,37),tspan); 

% subplotting([31 6 7 9 17 40 41 25],4,2,'signal transduction',sol)  % Figure 5

% ---------------------
% sensitivity analysis
% ---------------------
var=0.5;
density=20;
%test=check_init(var, density);  % Figure 14 (sensitivity to initial concentrations)
%sr=sensitivity(var, density, 'integral');  % Figure 7 (sensitivity to rate constants)
%sc=sensitivityinit(var, density, 'integral'); % Figure 6 (sensitivity to initial concentrations)
%sz = sensitivityzero(var, density, 'normal'); % Figure 8 (sensitivity of rate constants 

% ---------------------
% additional analysis
% ---------------------
specie=37;  %specie to monitor
specied=[];  %vector of variated initial conditions  
rate=[28, 38];  %vector of variated rates
bounds=[.20 1.8;.20 1.8]; %[firstbound lastbound] specied first
%monitor(specie,specied,rate,bounds);
