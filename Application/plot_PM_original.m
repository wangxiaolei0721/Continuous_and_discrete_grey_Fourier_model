%% clear data and figure
clc;
clear;
close all;
%% add path to MATLAB
addpath('..\','.\benchmark_grey_model')
%% load data
load PM25.mat;
data=[PM25.zhengzhou,PM25.anyang,PM25.xinxiang,PM25.luoyang,PM25.shangqiu,PM25.nanyang];
date=PM25.datetime;
%% figure setting
figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5, 5, 40,20],'PaperSize',[40,20]);
tiledlayout(2,3,'TileSpacing','Compact','Padding','Compact'); % new subfigure
col = [0, 114, 189,255; 125, 46, 142, 255;119, 171, 47,255;217, 83, 24,255]/255;
title0=["Zhengzhou", "Anyang", "Xinxiang", "Luoyang","Shangqiu","Nanyang"];
xlim=[dateshift(date(1),'start','month',-2),dateshift(date(end),'start','month',2)];
ylim=[0,180;0,250;0,200;0,200;0,160;0,180];
train_position=[160;222;177;175;140;157];
%% bigin loop
for i=1:6 % six cities
    x=data(:,i);
    x_fit(:,i)=GM11(x,0);
    nexttile
    semilogy(date,x,'Color',[0, 113, 188,200]/255,'Marker','o','MarkerSize',5,'Linestyle',"-.",'LineWidth',1.5);
    hold on
    semilogy(date,x_fit(:,i),'Color',[216, 82, 24,200]/255,'Marker','.','MarkerSize',10,'Linestyle',"-.",'LineWidth',1.5)
    title(title0(i),'FontWeight','bold','FontSize',14);
    xlabel(['Month']);
    xtickformat('yyyy-MM')
    ylabel(['PM_{2.5} concentration (μg/m^3)'])
    grid on
    set(gca,'FontName','Book Antiqua','FontSize',12,'YLim',ylim(i,:),'XLim',xlim);
     if i==3
        legend(["Actual data","Fitting data by GM(1,1)"],'location','northeast','FontSize',10);
    end
end
%% save figure
savefig(gcf,'figure\case_plot.fig');