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
%% figure setting
fig=figure('unit','centimeters','position',[10,10,30,10],'PaperPosition',[0, 0, 30,10],'PaperSize',[30,10]);
pos=[0.07,0.13,0.2,0.80; 0.31,0.13,0.2,0.80;0.55,0.13,0.2,0.80;0.79,0.13,0.2,0.80  ];
titles=["\sigma=0.10";"\sigma=0.20";"\sigma=0.30";"\sigma=0.40"];
colors = [ 217, 83, 25, 160;0, 114, 189, 160]'/255;
xlabs = {'0','1','2','3','4','5','6'};
labels={'MAE_{F}', 'MAE_{T}'};
%% begin loop
for i=1:dev_length % error deviation
    x_sim_train=x_sim{i}(1:train,:);
    for order=0:order_upper % candidate order
        for k=1:rep  % repetitions
            x_tra_val(:,k)=DGFM(x_sim_train(:,k),omega,order,val);
        end
        %% mean absolute percetage error
        ape=abs((x_tra_val-x_train_val)./x_train_val)*100;
        ape_fit=ape(1:train,:);
        ape_pre=ape(train+1:end,:);
        mape_fit(:,order+1)=mean(ape_fit)';
        mape_pre(:,order+1)=mean(ape_pre)';
    end
    %% multi-group boxplots
    mape_fit_log=log10(mape_fit);
    mape_pre_log=log10(mape_pre);
    mape_box{i,1} = {mape_fit,mape_pre};
    mape_box_log{i,1} = {mape_fit_log,mape_pre_log};
    % plot box i
    axes('position',pos(i,:));
    if i==1
        multiBoxplot(mape_box_log{i,1}, xlabs, colors, labels,'northeast') % mape_box_log{i,1}
    else
        multiBoxplot_legend(mape_box_log{i,1}, xlabs, colors, labels,'northeast')
    end
    grid minor
    title(titles(i),'FontWeight','bold','FontSize',16);
    xlabel(['Fourier order'],'FontSize',12); % xlabel
    if i==1 % ylabel
        text(0,0,['log_{10}(MAE)'],'Rotation',90,'FontName','Book Antiqua','FontSize',12)
    end
    set(gca,'FontName','Book Antiqua','FontSize',12 ,'Ylim',[-1,1.7])
end
%% save figure
savefig(fig,'figure\sim2.fig');
time=toc