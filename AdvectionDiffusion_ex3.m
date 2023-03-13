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
param.I0=450*86400; %µmol/m².d    %has to be high
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
P0(:)=14*10^7; % cells/m³
N0=zeros(1, param.n)';
N0(end)=100; %mmol/m³
v=[P0 ;N0]; 


tspan=1:401; %days

%calculate the phytoplankton concentration as function of time and depth
[t,y]=ode45(@derivatives_Ex3,tspan, v, [],param);

%calculate light intensity
[I] = phytofun_ex3(v, param);


%% plot of phytoplankton and nutrients in function of depth z 
colors=[ 0.3,1,0.9;0.3,0.9,0.8;0.3,0.8,0.7;0.3,0.6,0.5;0.3,0.5,0.4;0.3,0.4,0.3;0,0.45,0.7];

figure(1)
subplot(1,2,1)
plot(y(6,1:param.n), -param.z, col=colors(1,:))
hold on
plot(y(31,1:param.n), -param.z, col=colors(2,:))
hold on
plot(y(51,1:param.n), -param.z, col=colors(3,:))
hold on
plot(y(101,1:param.n), -param.z, col=colors(4,:))
hold on
plot(y(201,1:param.n), -param.z, col=colors(5,:))
hold on
plot(y(301,1:param.n), -param.z, col=colors(6,:))
hold on
plot(y(end,1:param.n), -param.z, col=colors(7,:))
title("phytoplankton")
xlabel("phytoplankton concentration (cells/m³)")
ylabel("depth (m)")
legend("time = 5 d", "time = 30 d", "time = 50 d", "time = 100 d", "time = 200 d","time = 300 d", "time = 400 d")

subplot(1,2,2)
plot(y(6,param.n+1:end), -param.z, col=colors(1,:))
hold on
plot(y(31,param.n+1:end), -param.z, col=colors(2,:))
hold on
plot(y(51,param.n+1:end), -param.z, col=colors(3,:))
hold on
plot(y(101,param.n+1:end), -param.z, col=colors(4,:))
hold on
plot(y(201,param.n+1:end), -param.z, col=colors(5,:))
hold on
plot(y(301,param.n+1:end), -param.z, col=colors(6,:))
hold on
plot(y(end,param.n+1:end), -param.z, col=colors(7,:))
title("nutrients")
xlabel("nutrient concentration (mmol/m³)")
ylabel("depth (m)")
legend("time = 5 d","time = 30 d", "time = 50 d", "time = 100 d", "time = 200 d", "time = 300 d", "time= 400 d")

%% Plot of the light intensity
figure(2)
plot(I, -param.z)
title("light intensity")
xlabel("light intensity (µmol/m².d)")
ylabel("depth (m)")

%% Surface plots of phytoplankton and nutrients

figure(3)
subplot(2,1,1)
set(gca, 'YDir', 'reverse')
surface(y(:,1:param.n)')
title("phytoplankton (cells/m³) ")
xlabel("time(d)")
ylabel("depth(m)")
shading flat
colorbar
subplot(2,1,2)
set(gca, 'YDir', 'reverse')
surface(y(:,param.n+1:end)')
title("nutrients (mmol/m³) ")
xlabel("time(d)")
ylabel("depth(m)")
shading flat
colorbar



%% Plot of limiting resource
figure(4)

N= y(end,param.n+1:end)';

I_lim= I./(I+param.Hi);
N_lim= N./(N+param.Hn);
plot(I_lim, -param.z)
hold on
plot(N_lim, -param.z)
title("plot of limiting resource (light/nutrients)")
xlabel("nutrients/ light")
ylabel("depth (m)")
legend("light", "nutrients")
