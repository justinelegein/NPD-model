function dydt = derivatives_Ex3(t,v, param)
% this function calculates change of phytoplankton concentration over the
% time 

n=param.n;
P=v(1:param.n);
N=v(param.n+1:2*param.n);

%phytoplankton

Jp=zeros(1,n+1);

%boundary conditions: closed
Jp(1)=0;
Jp(n+1)=0;

%calculate fluxes: advective flux and diffusive flux
for i=2:n 
    Ja(i)=param.u.*P(i-1);
    Jd(i)=-param.D*(P(i)-P(i-1))/param.Dz ;
    Jp(i)=Jd(i)+Ja(i);
end

%calculate derivative (dp/dt)
yp=zeros(1,n);
for i=1:n
    yp(i)=-(Jp(i+1)-Jp(i))./param.Dz;
end
yp=yp';

%to calculate dp/dt you need g (=specific production rate), this is
%calculated in the function phytofun
[I,g] = phytofun_ex3(v, param);

dpdt=yp+(g-param.m).*P;



%nutrients
Jn=zeros(1,n+1);

%boundary conditions
Jn(1)=0;
Jn(n+1)=-param.D*(param.Nbottom-N(end))/param.Dz ;

%calculate fluxes: only diffusive flux
for i=2:n 
    Jd(i)=-param.D*(N(i)-N(i-1))/param.Dz ;
    Jn(i)=Jd(i);
end

yn=zeros(1,n);
for i=1:n
    yn(i)=-(Jn(i+1)-Jn(i))./param.Dz;
    
end
yn=yn';
dNdt=-param.a*(g.*P)+param.epsilon*param.a*param.m*P+yn;

dydt=[dpdt;dNdt];








