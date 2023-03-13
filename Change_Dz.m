clear all
clc
% define parameters

param.D=43.2; %m²/d   
param.Dz=1;
param.depth=100; %m
param.n=param.depth/param.Dz; %m
param.kp=6*10^-12; %m²/cell
param.kw=0.045; %1/m
param.gmax=0.04*24; %1/d
param.I0=450*86400; %µmol/m².d    
param.m=0.01*24;%1/d
param.Hn=0.02;%mmol/m³
param.Hi=20*86400; %µmol/m².d
param.a=10^-9; %mmol/cell
param.epsilon=0.5;
param.u=0.04*24; %m/d
param.Nbottom=100;%m


%define grid
param.z=0.5*param.Dz:param.Dz:param.depth-0.5*param.Dz;

%define initial conditions
P0=zeros(1,param.n)';
P0(:)=14*10^7; % cells/m²
N0=zeros(1, param.n)';
N0(end)=100; %mmol/m³
v=[P0 ;N0];

tspan=1:201; %days

%% plot of phytoplankton when Dz changes

Dz_values=[0.5,1,2,3];
legende=strings(length(Dz_values),1);
colors=[0.3,0.9,0.8;0.3,0.7,0.5;0.3,0.6,0.1;0.3,0.3,0.4];


figure(1)
for i=1:length(Dz_values)
    param.Dz=Dz_values(i);
    param.n=round(param.depth/param.Dz);
    param.z=0.5*param.Dz:param.Dz:param.depth-0.5*param.Dz;
    %define initial conditions
    P0=zeros(1,param.n)';
    P0(:)=14*10^7; % cells/m²
    N0=zeros(1, param.n)';
    N0(end)=100; %mmol/m³
    v=[P0 ;N0];
    [t,y]=ode45(@derivatives_Ex3,tspan, v, [],param);
    plot(y(end,1:param.n), -param.z, col=colors(i,:)) %phytoplankton on last time point
    legende(i)=(strcat('Dz =', num2str(Dz_values(i))));
    hold on
end
legend(legende)
xlabel("phytoplankton concentration (cells/m³)")
ylabel("depth (m)")
title('phytoplankton after 200 days')

%% plot of nutrients when Dz changes
colors=[0.3,0.9,0.8;0.3,0.7,0.5;0.3,0.6,0.1;0.3,0.3,0.4];

figure(2)
for i=1:length(Dz_values)
    param.Dz=Dz_values(i);
    param.n=round(param.depth/param.Dz);
    param.z=0.5*param.Dz:param.Dz:param.depth-0.5*param.Dz;
    %define initial conditions
    P0=zeros(1,param.n)';
    P0(:)=14*10^7; % cells/m²
    N0=zeros(1, param.n)';
    N0(end)=100; %mmol/m³
    v=[P0 ;N0];
    [t,y]=ode45(@derivatives_Ex3,tspan, v, [],param);
    plot(y(end,param.n+1:end), -param.z, col=colors(i,:)) %nutrients on last time point
    legende(i)=(strcat('Dz =', num2str(Dz_values(i))));
    hold on
end
legend(legende)
xlabel("nutrient concentration (mmol/m³)")
ylabel("depth (m)")
title('nutrients after 200 days')
