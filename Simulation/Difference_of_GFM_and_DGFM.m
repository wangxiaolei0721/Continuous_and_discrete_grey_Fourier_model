%% clear data and figure
clc;
clear;
close all;
tic
%% add path to MATLAB
addpath('..\')
%% parameter setting
omega=pi/6; % angular frequency
order_upper=6; % maximal order
dev=[0.1;0.2;0.3;0.4]; % error deviation
dev_length=length(dev);
rep=1000; % repetitions
%%  load data
load simulation_case.mat;
train=48; % train data
val=24; % validation data
train_val=train+val; % train data + validation data
x_train_val=repmat(x(1:train_val),1,rep);
%% begin loop
for i=1:dev_length % error deviation
    x_train=x_sim{i}(1:train,:);
    for order=0:order_upper % candidate order
        for k=1:rep  % repetitions
            x_tra_val(:,k)=GFM_linear_integral(x_train(:,k),omega,order,val);
            y_tra_val(:,k)=DGFM(x_train(:,k),omega,order,val);
        end
        %% mean absolute percetage error
        xerror=abs(x_tra_val-x_train_val);
        xerror_fit=xerror(1:train,:);
        xerror_tra=xerror(train+1:end,:);
        xerror_mean_fit(:,order+1)=mean(xerror_fit)';
        xerror_mean_tra(:,order+1)=mean(xerror_tra)';
        %% mean absolute percetage error
        yerror=abs(y_tra_val-x_train_val);
        yerror_fit=yerror(1:train,:);
        yerror_tra=yerror(train+1:end,:);
        yerror_mean_fit(:,order+1)=mean(yerror_fit)';
        yerror_mean_tra(:,order+1)=mean(yerror_tra)';
    end
    %% GFM error
    xerror_mean_fit_ave(i,:)=mean(xerror_mean_fit,1);
    xerror_mean_tra_ave(i,:)=mean(xerror_mean_tra,1);
    xerror_mean_fit_var(i,:)=var(xerror_mean_fit);
    xerror_mean_tra_var(i,:)=var(xerror_mean_tra);
    %% DGFM error
    yerror_mean_fit_ave(i,:)=mean(yerror_mean_fit,1);
    yerror_mean_tra_ave(i,:)=mean(yerror_mean_tra,1);
    yerror_mean_fit_var(i,:)=var(yerror_mean_fit);
    yerror_mean_tra_var(i,:)=var(yerror_mean_tra);
end
di_error_fit=xerror_mean_fit_ave-yerror_mean_fit_ave;
di_error_tra=xerror_mean_tra_ave-yerror_mean_tra_ave;
di_var_fit=xerror_mean_fit_var-yerror_mean_fit_var;
di_var_tra=xerror_mean_tra_var-yerror_mean_tra_var;
%% begin plot
order=[0:6];
figure('unit','centimeters','position',[10,5,30,20],'PaperPosition',[0, 0, 30,20],'PaperSize',[30,20]);
subplot(2,2,1)
plot(order,di_error_fit','LineWidth',1,"Marker","o")
yline(0,'--','HandleVisibility','off')
title('Mean$_\mathrm{GFM}$($\mathrm{MAE}_{F}$) $-$ Mean$_\mathrm{DGFM}$($\mathrm{MAE}_{F}$)','interpreter','latex')
xlabel('Fourier order')
legend(["\sigma=0.10","\sigma=0.20","\sigma=0.30","\sigma=0.40"])
set(gca,'FontName','Book Antiqua','FontSize',12 ,'Xlim',[-0.5,6.5])
subplot(2,2,2)
plot(order,di_error_tra','LineWidth',1,"Marker","o")
yline(0,'--','HandleVisibility','off')
title('Mean$_\mathrm{GFM}$($\mathrm{MAE}_{T}$) $-$ Mean$_\mathrm{DGFM}$($\mathrm{MAE}_{T}$)','interpreter','latex')
xlabel('Fourier order')
set(gca,'FontName','Book Antiqua','FontSize',12 ,'Xlim',[-0.5,6.5])
subplot(2,2,3)
plot(order,di_var_fit','LineWidth',1,"Marker","o")
yline(0,'--','HandleVisibility','off')
title('Var$_\mathrm{GFM}$($\mathrm{MAE}_{F}$) $-$ Var$_\mathrm{GFM}$($\mathrm{MAE}_{F}$)','interpreter','latex')
xlabel('Fourier order')
set(gca,'FontName','Book Antiqua','FontSize',12 ,'Xlim',[-0.5,6.5])
subplot(2,2,4)
plot(order,di_var_tra','LineWidth',1,"Marker","o")
yline(0,'--','HandleVisibility','off')
title('Var$_\mathrm{GFM}$($\mathrm{MAE}_{T}$) $-$ Var$_\mathrm{GFM}$($\mathrm{MAE}_{T}$)','interpreter','latex')
xlabel('Fourier order')
set(gca,'FontName','Book Antiqua','FontSize',12,'Xlim',[-0.5,6.5])
%% save figure
savefig(gcf,'figure\sim3.fig');
time=toc