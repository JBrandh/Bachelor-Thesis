Param=setParam;
conc=setParam;
global y0;
y0=cell2mat(conc(:,1));                                                     %matdata of concentrations
Rates=setRates;
global k;
k=cell2mat(Rates(:,1));
           
global tspan;
tspan=3600*14;                                                              %time of simulation (14)
global tstart;
tstart=3600*2;                                                              %timepoint where stimulus is added (2)
global tstim;
tstim=3600*8;                                                               %time stimulation is active (puls stimulation) (8)
[t,y]=ode15s(@setODE,[0 tspan],y0);
sol=[t,y];

th=t/3600;

%subplotting([6 7 17 24 25],5,1,'Time Courses',sol);

I=Integrate(t,y(:,37),tspan);

%subplotting([31 6 7 9 17 40 41 25],4,2,'signal transcduction',sol)



var=0.5;
density=20;
test=check_init(var,density);
%sr=sensitivity(var,density,"integral");
%sc=sensitivityinit(var,density,"integral");
%sz=sensitivityzero(var,density,"normal");
specie=37;                                                                  %specie to monitor
specied=[];                                                              %vector of variated initial conditions  
rate=[28, 38];                                                                    %vector of variated rates
bounds=[.20 1.8;.20 1.8];                                                  %[firstbound lastbound] specied first
%monitor(specie,specied,rate,bounds);




