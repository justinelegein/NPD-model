function [I,g] = phytofun_ex5(t,v, param)
%this function calculates the light intensity and the specific production rate
%when there is a seasonal variation in the incident light intensity

P=v(1:param.n);
N=v(param.n+1:2*param.n);

Q=param.kp*param.Dz*(cumsum(P)-P./2);

I0=0.5*param.I0*sin((2*pi)/365.*t)+param.I0; %I0 changes according to the seasons

I=I0.*exp(-param.kw.*param.z'-Q);

g=param.gmax.*min(I./(I+param.Hi), N./(N+param.Hn));
end