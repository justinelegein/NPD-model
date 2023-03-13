clear all
clc
% define parameters

param.D=43.2; %m²/d    %not too high
param.Dz=1;
param.depth=100; %m
param.n=round(param.depth/param.Dz); %m
param.kp=6*10^-12; %m²/cell
param.kw=0.045; %1/m
param.gmax=0.04*24; %1/d
param.I0=450*86400; %mmol/m².d    %has to be high!!
param.m=0.01*24;%1/d
param.Hn=0.02;%mmol/m³
param.Hi=20*86400; %µmol/m².d
param.a=10^-9; %mmol/cell
param.epsilon=0.5;
param.u=0.04*24; %m/d
param.Nbottom=100;%mmol/m³


%define grid
param.z=0.5*param.Dz:param.Dz:param.depth-0.5*param.Dz;

%define initial conditions
P0=zeros(1,param.n)';
P0(:)=14*10^7; % cells/m²
N0=zeros(1, param.n)';
N0(end)=100; %mmol/m³
v=[P0 ;N0];


tspan=1:800; %days


%calculate the phytoplankton concentration as function of time and depth
[t,y]=ode45(@derivatives_Ex5,tspan, v, [],param);

%% surface plots of phytoplankton and nutrients with seasonal variation 
figure(1)
subplot(3,1,1)
I0=0.5*param.I0*sin((2*pi)/365.*tspan)+param.I0;
plot(tspan, I0)
xlabel("time (d)")
ylabel('I0 (mmol/m².d)')
title('I0 variation')

subplot(3,1,2)
set(gca, 'YDir', 'reverse')
surface(y(:,1:param.n)')
title("phytoplankton (cells/m³) ")
xlabel("time(d)")
ylabel("depth(m)")
shading flat
xticks(linspace(0,800,9))

subplot(3,1,3)
set(gca, 'YDir', 'reverse')
surface(y(:,param.n+1:end)')
title("nutrients (mmol/m³) ")
xlabel("time(d)")
ylabel("depth(m)")
shading flat
xticks(linspace(0,800,9))

