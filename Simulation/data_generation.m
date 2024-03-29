clc; 
clear; 
close all;
%% parameter setting
omega=pi/6; % angular frequency
order=3; % Fourier order
time=[1:72]'; % time
time_length=length(time);
dev=[0.1;0.2;0.3;0.4]; % error deviation
dev_length=length(dev);
rep=1000; % repetitions
par=[0.01;5;0;1;1;1;1;-1;-1]; %par=[-0.01;5;0;-1;1;-1;1];[-0.01;5;0;1;1;-1;-1;1;1];为微分方程的参数 par=[-0.01;5;0;-1;1;-1;1];
%% data generation
x=datageneration( omega,order,time,par); % original time series without error
xrep=repmat(x,1,rep);
for i=1:dev_length  % error deviation
    for j=1:rep   % repetitions
        rng(j); % random seed
        noise(:,j)=dev(i)*randn(time_length,1); % random noise
    end
    x_sim{i}=xrep+noise;
end
plot(x)
save simulation_case.mat

%%
function data = datageneration ( omega,order,time,par)
% data_generation function
% input
% omega: angular frequency
% n: Fourier order
% time: time t
% par=[alpha,eta,A_0,A_1,B_1,\cdots,A_n,B_n]
t1=time(1); % t_1
time_length=length(time);
alpha=par(1);
eta=par(2);
Theta=par(3:end);
T=zeros(2*order+1,2*order+1); % convert matrix T
T(1,1)=-alpha;
for i=1:order
    T(2*i:2*i+1,2*i:2*i+1)=[-alpha,i*omega;-i*omega,-alpha];
end
theta=T\Theta;
%% initial vaule
timet1=repmat(t1,1,order);
omega_order=omega*[1:order];
sint1=sin(omega_order.*timet1);
cost1=cos(omega_order.*timet1);
cossint1=zeros(1,2*order);
for i=1:order
    cossint1(:,2*i-1:2*i)=[cost1(:,i),sint1(:,i)];
end
c0=eta-[1,cossint1]*theta;
c=exp(-alpha*t1)*c0;
%% time sponse
one=ones(time_length,1);
times=repmat(time(1:end),1,order); % t
ome=omega*repmat([1:order],time_length,1); % n*omega
sint=sin(times.*ome); % sin n*omega*t
cost=cos(times.*ome); % cos n*omega*t
for i=1:order
    cossint(:,2*i-1:2*i)=[cost(:,i),sint(:,i)];
end
expt=c*exp(alpha*time(1:end));
trit=[one,cossint]*theta;
data=expt+trit;
end