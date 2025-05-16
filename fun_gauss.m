function [S]=fun_gauss(t,a,t0);

% t= [1:200]*0.5
% t0 = 25;
% a = 8 


S=zeros(size(t));
indx=find(t>=0.0 & t<=2*t0);
S(indx)=exp(-(t(indx)-t0).^2/(a.^2))/(sqrt(pi)*a);
% 
% figure
% plot(t,S)