function x_fit = GMP11( x,f,order )
% grey model with polynomial function
% input:
% x: time series data
% f: predicted step 
% order: polynomial order
% output:
% x_fit: fitting and predicting data
% reference:
% Baolei Wei, Naiming Xie, Aqin Hu.
% Optimal solution for novel grey polynomial prediction model,
% Applied Mathematical Modelling,2018,62:717-727.
%% start
l=length(x);
x1=cumsum(x);  % accumulative series
z1=(x1(2:end)+x1(1:end-1))/2; % neighbor mean series
%% estimate parameter
k=[2:l]';
for i=0:order
    b(:,i+1)=(k.^(i+1)-(k-1).^(i+1))/(i+1);
end
B=[-z1,b];
Y=x(2:end);
p=(B'*B)\B'*Y;
alpha=p(1);
beta=p(2:end);
M=diag(1:order,1)+diag(repmat(alpha,1,order+1));
gama=M\beta;
% time sponse function
k=[1:l+f]';
for i=0:order
    g(:,i+1)=k.^i;
end
x1_fit=(x(1)-sum(gama))*exp(-alpha*(k-1))+g*gama;
x_fit=[NaN;diff(x1_fit)];
end