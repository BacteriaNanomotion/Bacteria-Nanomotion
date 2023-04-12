
clear all

Nbars=3;%n bars to plot


Gbar(1:Nbars)=0;
GbarStd(1:Nbars)=0;
ErLow(1:Nbars)=0;
ErHigh(1:Nbars)=0;

N=1;
Gbar(N)=1.265;% one cell
GbarStd(N)=0.188;


N=N+1;  % two cells
Gbar(N)=1.002;
GbarStd(N)=0.114;


N=N+1;
Gbar(N)=0.718;% 3 cells
GbarStd(N)=0.136;

% 
% N=N+1;  %Metolachlore 3h14
% Gbar(N)=1.;
% GbarStd(N)=0.637;
% 
% 
% 
% N=N+1;  %Penconazone 3h16m
% Gbar(N)=1.772;
% GbarStd(N)=0.146;
% % 
% % 
% 
% N=N+1;  %Terbutryn
% Gbar(N)=1.719;
% GbarStd(N)=0.453;


for N=1:Nbars
    ErLow(N)=(GbarStd(N)/2);
    ErHigh(N)=(GbarStd(N)/2);
end;

figure
bar(Gbar)

title('1 cell  2 cells 3 cells')

hold on


er = errorbar(1:Nbars,Gbar,ErLow,ErHigh);    
er.Color = [1 0 0];                            
er.LineStyle = 'none';  
grid on

hold off




