function [ dx ] = setODE(t,x)
%SETODE Summary of this function goes here
%   Detailed explanation goes here

global k;


k1=k(1);        %R-JAK-Binding
k1r=k(2);
k2=k(3);        %IFN-Binding
k2r=k(4);
k3=k(5);        %Receptor-Dimerisation
k3r=k(6);
k4=k(7);        %Rezeptor-Activition
k5=k(8);        %STAT-Rezeptor-Bindung
k5r=k(9);
k6=k(10);       %STAT-Activation
k7=k(11);       %ActivatedSTAT-Receptor-Binding
k7r=k(12);
k8=k(13);       %STAT-Dimerisation
k8r=k(14);
k9=k(15);       %SHP2-Binding
k9r=k(16);      
k10=k(17);      %SHP2-Unbinding
k11=k(18);      %PPX-Binding
k11r=k(19);
k12=k(20);      %PPX-unbinding
k13=k(21);      %STAT-Heterodimerisation
k13r=k(22);
k14=k(23);      %STAT-Import
k15=k(24);      %PPN-Binding
k15r=k(25);
k16=k(26);      %PPN-Unbinding
k17=k(27);      %STAT-Export
k18a=k(28);     %Transcription
k18b=k(29);     %Transcription
k19=k(30);      %mRNA-Export
k20=k(31);      %Translation
k21=k(32);      %SOCS1-Binding
k21r=k(33);
k22=k(34);      %mRNA-Degradation
k23=k(35);      %Protein-Degradation
k24=k(36);      %PIAS-Binding
k24r=k(37);
k25a=k(38);     %transcription max
k25b=k(39);     %
k26=k(40);      %generic mRNA-degradation
k27=k(41);      %CBP Binding
k27r=k(42);     %
k28a=k(43);     %CBP transcription
k28b=k(44);     %
k29=k(45);      %CBPmRNA degradation
k30=k(46);      %CBP degradation
k31=k(47);      %CBP translation
vCBP0=k(48);    %CBP base production

R=x(1);
JAK=x(2);
RJ=x(3);
IFNRJ=x(4);
IFNRJ2=x(5);
IFNRJ2P=x(6);
STAT1c=x(7);
IFNRJ2P_STAT1c=x(8);
STAT1cP=x(9);
IFNRJ2P_STAT1cP=x(10);
STAT1cP_STAT1cP=x(11);
SHP2=x(12);
IFNRJ2P_SHP2=x(13);
PPX=x(14);
STAT1cP_PPX=x(15);
STAT1c_STAT1cP=x(16);
STAT1nP_STAT1nP=x(17);
STAT1nP=x(18);
PPN=x(19);
STAT1nP_PPN=x(20);
STAT1n=x(21);
STAT1n_STAT1nP=x(22);
mRNAn=x(23);
mRNAc=x(24);
SOCS1=x(25);
IFNRJ2P_SOCS1=x(26);
IFNRJ2P_SHP2_SOCS1_STAT1c=x(27);
STAT1cP_STAT1cP_PPX=x(28);
STAT1nP_STAT1nP_PPN=x(29);
IFNRJ2P_SOCS1_STAT1c=x(30);
IFN=x(31);
IFNRJ2P_SHP2_STAT1c=x(32);
IFNRJ2P_SHP2_SOCS1=x(33);
IFNR=x(34);
genericmRNAn=x(35);
genericmRNAc=x(36);
generic=x(37);
PIAS1=x(38);
PIAS1_STAT1nP_STAT1nP=x(39);
CBP=x(40);
CBP_STAT1nP_STAT1nP=x(41);
CBP_STAT1nP_STAT1nP_PPN=x(42);
CBP_mRNAn=x(43);
CBP_mRNAc=x(44);

global tstart                                                                    %delay of stimulus
global tstim
te=tstart+tstim;                                                               %transient signal
if t<tstart
    IFN=0;    
else
    IFN=x(31);
end
if t>te
    IFN=0;
end
        




v(1)=k1*R*JAK-k1r*RJ;                                                       %
v(2)=k2*IFN*RJ-k2r*IFNRJ;                                                   %
v(3)=k3*IFNRJ*IFNRJ-k3r*IFNRJ2;                                             %
v(4)=k4*IFNRJ2;                                                             %Rezeptor-Activation
v(5)=k5*STAT1c*IFNRJ2P-k5r*IFNRJ2P_STAT1c;                                  %
v(6)=k6*IFNRJ2P_STAT1c;                                                     %
v(7)=k7*IFNRJ2P*STAT1cP-k7r*IFNRJ2P_STAT1cP;                                %
v(8)=k8*STAT1cP*STAT1cP-k8r*STAT1cP_STAT1cP;                                %
v(9)=k9*IFNRJ2P*SHP2-k9r*IFNRJ2P_SHP2;                                      %
v(10)=k10*IFNRJ2P_SHP2;                                                     %
v(11)=k11*PPX*STAT1cP-k11r*STAT1cP_PPX;                                     %
v(12)=k12*STAT1cP_PPX;                                                      %
v(13)=k11*PPX*STAT1cP_STAT1cP-k11r*STAT1cP_STAT1cP_PPX;                     %
v(14)=k12*STAT1cP_STAT1cP_PPX;                                              %
v(15)=k13*STAT1c*STAT1cP-k13r*STAT1c_STAT1cP;                               %
v(16)=k14*STAT1cP_STAT1cP;                                                  %
v(17)=k8*STAT1nP*STAT1nP-k8r*STAT1nP_STAT1nP;                               %
v(18)=k15*PPN*STAT1nP-k15r*STAT1nP_PPN;                                     %
v(19)=k16*STAT1nP_PPN;                                                      %
v(20)=k15*PPN*STAT1nP_STAT1nP-k15r*STAT1nP_STAT1nP_PPN;                     %
v(21)=k16*STAT1nP_STAT1nP_PPN;                                              %
v(22)=k13*STAT1n*STAT1nP-k13r*STAT1n_STAT1nP;                               %
v(23)=k17*STAT1n;                                                           %
v(24)=(k18a*CBP_STAT1nP_STAT1nP)/(k18b+CBP_STAT1nP_STAT1nP);                %transcription
v(25)=k19*mRNAn;                                                            %
v(26)=k20*mRNAc;                                                            %
v(27)=k22*mRNAc;                                                            %
v(28)=k23*SOCS1;                                                            %
v(29)=k21*SOCS1*IFNRJ2P-k21r*IFNRJ2P_SOCS1;                                 %
v(30)=k5*STAT1c*IFNRJ2P_SOCS1-k5r*IFNRJ2P_SOCS1_STAT1c;                     %
v(31)=k9*SHP2*IFNRJ2P_SOCS1_STAT1c-k9r*IFNRJ2P_SHP2_SOCS1_STAT1c;           %
v(32)=k10*IFNRJ2P_SHP2_SOCS1_STAT1c;                                        %
v(33)=k23*IFNRJ2P_SHP2_SOCS1_STAT1c;                                        %
v(34)=k9*SHP2*IFNRJ2P_SOCS1-k9r*IFNRJ2P_SHP2_SOCS1;                         %
v(35)=k5*STAT1c*IFNRJ2P_SHP2_SOCS1-k5r*IFNRJ2P_SHP2_SOCS1_STAT1c;           %
v(36)=k9*SHP2*IFNRJ2P_STAT1c-k9r*IFNRJ2P_SHP2_STAT1c;                       %
v(37)=k10*IFNRJ2P_SHP2_STAT1c;                                              %
v(38)=k23*IFNRJ2P_SOCS1_STAT1c;                                             %
v(39)=k23*IFNRJ2P_SHP2_SOCS1;                                               %
v(40)=k10*IFNRJ2P_SHP2_SOCS1;                                               %
v(41)=k23*IFNRJ2P_SOCS1;                                                    %
v(42)=k21*SOCS1*IFNRJ2P_STAT1c-k21r*IFNRJ2P_SOCS1_STAT1c;                   %
v(43)=k21*SOCS1*IFNRJ2P_SHP2-k21r*IFNRJ2P_SHP2_SOCS1;                       %
v(44)=k21*SOCS1*IFNRJ2P_SHP2_STAT1c-k21r*IFNRJ2P_SHP2_SOCS1_STAT1c;         %
v(45)=k2*IFN*R-k2r*IFNR;                                                    %
v(46)=k1*IFNR*JAK-k1r*IFNRJ;                                                %
v(47)=k20*genericmRNAc;                                                     %generic protein translation
v(48)=k23*generic;                                                          %generic protein degradation
v(49)=k24*PIAS1*STAT1nP_STAT1nP-k24r*PIAS1_STAT1nP_STAT1nP;                 %
v(50)=(k25a*CBP_STAT1nP_STAT1nP)/(k25b+CBP_STAT1nP_STAT1nP);                %generic tracsription
v(51)=k19*genericmRNAn;                                                     %gereric export
v(52)=k26*genericmRNAc;                                                     %generic degradation
v(53)=k27*STAT1nP_STAT1nP*CBP-k27r*CBP_STAT1nP_STAT1nP;                     %
v(54)=k15*PPN*CBP_STAT1nP_STAT1nP-k15r*CBP_STAT1nP_STAT1nP_PPN;             %
v(55)=k16*CBP_STAT1nP_STAT1nP_PPN;                                          %
v(56)=(k28a*generic)/(k28b+generic);                                        %CBP transcription
v(57)=k19*CBP_mRNAn;                                                        %CBPmRNA export
v(58)=k29*CBP_mRNAc;                                                        %CBPmRNA degradation
v(59)=k30*CBP;                                                              %CBP degradation
v(60)=k31*CBP_mRNAc;                                                        %CBP translation
v(61)=vCBP0;                                                                %CBP base production

dx(1,1)=-v(1)-v(45);                                                        %d[R]/dt        
dx(2,1)=-v(1)-v(46);                                                        %d[JAK]/dt      
dx(3,1)=v(1)-v(2);                                                          %d[RJ]/dt       
dx(4,1)=v(2)+v(46)-2*v(3);                                                  %d[IFNRJ]/dt    
dx(5,1)=v(3)+v(10)+v(32)+v(37)+v(40)-v(4);                                  %d[IFNRJ2]/dt  
dx(6,1)=v(4)+v(6)+v(41)-v(5)-v(7)-v(9)-v(29);                               %d[IFNRJ2P]/dt  
dx(7,1)=v(12)+v(23)+v(32)+v(37)-v(5)-v(15)-v(30)-v(35);                     %d[STAT1c]/dt
dx(8,1)=v(5)+v(38)-v(6)-v(36)-v(42);                                        %d[IFNRJ2P_STAT1c]/dt
dx(9,1)=v(6)-v(7)-2*v(8)-v(11)-v(15);                                       %d[STAT1P]/dt
dx(10,1)=v(7);                                                              %d[IFNRJ2P_STAT1cP]/dt       
dx(11,1)=v(8)-v(13)-v(16);                                                  %d[STAT1cP_STAT1cP]/dt
dx(12,1)=v(10)+v(32)+v(37)+v(40)-v(9)-v(31)-v(34)-v(36);                    %d[SHP2]
dx(13,1)=v(9)+v(39)-v(10)-v(43);                                            %d[IFNRJ2P_SHP2]/dt    
dx(14,1)=v(12)+v(14)-v(11)-v(13);                                           %d[PPX]/dt
dx(15,1)=v(11)-v(12);                                                       %d[STAT1cP_PPX]/dt
dx(16,1)=v(14)+v(15);                                                       %d[STAT1c_STAT1cP]/dt
dx(17,1)=v(16)+v(17)-v(20)-v(49)-v(53);                                     %d[STAT1nP_STAT1nP]/dt
dx(18,1)=-2*v(17)-v(18)-v(22);                                              %d[STAT1nP]/dt
dx(19,1)=v(19)+v(21)+v(55)-v(18)-v(20)-v(54);                               %d[PPN]/dt
dx(20,1)=v(18)-v(19);                                                       %d[STAT1nP_PPN]/dt
dx(21,1)=v(19)-v(22)-v(23);                                                 %d[STAT1n]/dt
dx(22,1)=v(21)+v(22)+v(55);                                                 %d[STAT1n_STAT1nP]/dt
dx(23,1)=v(24)-v(25);                                                       %d[mRNAn]/dt
dx(24,1)=v(25)-v(27);                                                       %d[mRNAc]dt
dx(25,1)=(v(26)+v(32)+v(40)-v(28)-v(29)-v(42)-v(43)-v(44));                 %d[SCOCS1]/dt
dx(26,1)=v(29)-v(30)-v(34)-v(41);                                           %d[IFNRJ2P_SOCS1]/dt
dx(27,1)=v(31)+v(35)+v(44)-v(32)-v(33);                                     %d[IFNRJ2P_SHP2_SOCS1_STAT1c]/dt
dx(28,1)=v(13)-v(14);                                                       %d[STAT1cP_STAT1cP_PPX]/dt
dx(29,1)=v(20)-v(21);                                                       %d[STAT1nP_STAT1nP_PPN]/dt
dx(30,1)=v(30)+v(42)-v(31)-v(38);                                           %d[IFNRJ2P_SOCS1_STAT1c]/dt
dx(31,1)=0; %-IFN*0.0001;                                                   %d[IFN]/dt
dx(32,1)=v(33)+v(36)-v(37)-v(44);                                           %d[IFNRJ2P_SHP_STAT1c]/dt
dx(33,1)=v(34)+v(43)-v(35)-v(39)-v(40);                                     %d[IFNRJ2P_SHP2_SOCS1]/dt
dx(34,1)=v(45)-v(46);                                                       %d[IFNR]/dt
dx(35,1)=v(50)-v(51);                                                       %d[p21mRNAn]/dt
dx(36,1)=v(51)-v(52);                                                       %d[p21mRNAc]/dt
dx(37,1)=v(47)-v(48);                                                       %d[p21]/dt
dx(38,1)=-v(49);                                                            %d[PIAS1]/dt
dx(39,1)=v(49);                                                             %d[PIAS1_STAT1nP_STAT1nP]
dx(40,1)=v(55)+v(60)+v(61)-v(53)-v(59);                                     %d[CBP]/dt
dx(41,1)=v(53)-v(54);                                                       %d[CBP_STAT1nP_STAT1nP]/dt
dx(42,1)=v(54)-v(55);                                                       %d[CBP_STAT1nP_STAT1nP_PPN]/dt
dx(43,1)=v(56)-v(57);                                                       %d[CBPmRNAn]/dt
dx(44,1)=v(57)-v(58);                                                       %d[CBPmRNAn]/dt
end

