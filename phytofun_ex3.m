function [I,g] = phytofun_ex3(v, param)
%this function calculates the light intensity and the specific production rate

P=v(1:param.n);
N=v(param.n+1:2*param.n);

Q=param.kp*param.Dz*(cumsum(P)-P./2);
I=param.I0*exp(-param.kw.*param.z'-Q);

g=param.gmax.*min(I./(I+param.Hi), N./(N+param.Hn));
end