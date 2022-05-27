%% clear data and figure
clc;
clear;
close all;
%% add path to MATLAB
addpath('..\')
%% order setting
omega=pi/6; % angular frequency
FN=[2,2,2,2,2,3]; % Fourier order
%% load data
load PM25.mat;
data=[PM25.zhengzhou,PM25.anyang,PM25.xinxiang,PM25.luoyang,PM25.shangqiu,PM25.nanyang];
train=length(data);
predict=24; 
date=PM25.datetime;
tstart = date(1);
date_predict=dateshift(tstart,'start','month',0:train+predict-1)'; % train + predict date
%% figure setting
fig=figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5, 5, 40,20],'PaperSize',[40,20]);
tile=tiledlayout(2,3,'TileSpacing','Compact','Padding','Compact');
col = [0, 114, 189,255; 125, 46, 142, 255;119, 171, 47,255;217, 83, 24,255]/255;
tit=["Zhengzhou", "Anyang", "Xinxiang", "Luoyang","Shangqiu","Nanyang"];
xlim=[dateshift(date_predict(1),'start','month',-2),dateshift(date_predict(end),'start','month',2)];
date_tick=[date_predict([1:24:108])];
ylim=[0,180;0,250;0,200;0,200;0,160;0,180];
train_position=[160;222;177;175;140;157];
%% bigin loop
for i=1:6 % six cities
    x=data(:,i);
    x_GFM(:,i)=GFM_linear_integral(x(1:train),omega,FN(i),predict);
    x_DGFM(:,i)=DGFM(x(1:train),omega,FN(i),predict);
    x_fit=0.5*x_GFM(1:train,i)+0.5*x_DGFM(1:train,i);
    x_pre=0.5*x_GFM(train+1:end,i)+0.5*x_DGFM(train+1:end,i);
    amend=mean(x(61:end))/mean(x(37:60));
    x_pre_amend=x_pre*amend;
    x_amend(:,i)=[x_fit;x_pre_amend];
    nexttile
    plot(date,x,'Color',[0, 113, 188,200]/255,'Marker','o','MarkerSize',5,'Linestyle',"none",'LineWidth',1.5);
    hold on
    plot(date_predict,x_amend(:,i),'Color',[216, 82, 24,200]/255,'Marker','.','MarkerSize',12,'Linestyle',"-.",'LineWidth',1.5)
    title(tit(i),'FontWeight','bold','FontSize',14);
    xlabel(['Month'],'FontSize',14);
    xtickformat('yyyy-MM')
    ylabel(['PM_{2.5} concentration (μg/m^3)'],'FontSize',12)
    grid on
    set(gca,'FontName','Book Antiqua','FontSize',12,'YLim',ylim(i,:),'XLim',xlim);
    if i==6
        legend(["Actual data","Predicted value"],'location','northwest','FontSize',10);
    end
    xline(date(train),'--','HandleVisibility','off')
    text(date(train-25),train_position(i),"training",'FontSize',12,'FontName','Book Antiqua')
end
%% annotation
annotation(gcf,'arrow',[0.571 0.552]-0.32,[0.912 0.912]);
annotation(gcf,'arrow',[0.571 0.552],[0.912 0.912]);
annotation(gcf,'arrow',[0.571 0.552]+0.32,[0.912 0.912]);
annotation(gcf,'arrow',[0.571 0.552]-0.32,[0.912 0.912]-0.5);
annotation(gcf,'arrow',[0.571 0.552],[0.912 0.912]-0.5);
annotation(gcf,'arrow',[0.571 0.552]+0.32,[0.912 0.912]-0.5);
%% mean absolute percetage error
mae_DGFM_train=mean(abs(x_DGFM(1:train,:)-data));
mae_GFM_train=mean(abs(x_GFM(1:train,:)-data));
%% save figure
savefig(gcf,'figure\case_pre.fig');