%% clear data and figure
clc;
clear;
close all;
%% add path to MATLAB
addpath('..\')
%% order setting
omega=pi/6; % angular frequency
FN=[2,2,2,2,2,3]; % Fourier order
PN=[0,1,0,0,0,0]; % Polynomial order
%% load data
load PM25.mat;
data=[PM25.zhengzhou,PM25.anyang,PM25.xinxiang,PM25.luoyang,PM25.shangqiu,PM25.nanyang];
date=PM25.datetime;
l=length(data);
test=24; % test size
train=l-test;  % training size
%% figure setting
figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5, 5, 40,20],'PaperSize',[40,20]);
tiledlayout(2,3,'TileSpacing','Compact','Padding','Compact'); % new subfigure
title0=["Zhengzhou", "Anyang", "Xinxiang", "Luoyang","Shangqiu","Nanyang"];
xlim=[dateshift(date(1),'start','month',-2),dateshift(date(end),'start','month',2)];
ylim=[0,180;0,250;0,200;0,200;0,160;0,180];
train_position=[80;100;80;100;80;100];
len={["Actual data","GPM(1,1,0)","DGGM(1,1)","GM(1,1|cos,sin)","DGFM(1,1,2)","GFM(1,1,2)"],...
    ["Actual data","GPM(1,1,1)","DGGM(1,1)","GMSC(1,1)","DGFM(1,1,2)","GFM(1,1,2)"],...
    ["Actual data","GPM(1,1,0)","DGGM(1,1)","GMSC(1,1)","DGFM(1,1,2)","GFM(1,1,2)"],...
    ["Actual data","GPM(1,1,0)","DGGM(1,1)","GMSC(1,1)","DGFM(1,1,2)","GFM(1,1,2)"],...
    ["Actual data","GPM(1,1,0)","DGGM(1,1)","GMSC(1,1)","DGFM(1,1,2)","GFM(1,1,2)"],...
    ["Actual data","GPM(1,1,0)","DGGM(1,1)","GMSC(1,1)","DGFM(1,1,3)","GFM(1,1,3)"]};
%% begin loop 
for i=1:6 % six cities
    x=data(:,i);
    x_fit(:,1)=GMP11(x(1:train),test,PN(i)); % grey model with polynomial
    x_fit(:,2)=DGGM(x(1:train),omega,test); % Grey forecasting method based on a data grouping approach
    x_fit(:,3)=GM11_Gurcan(x(1:train),omega,test );
    x_fit(:,4)=DGFM(x(1:train),omega,FN(i),test);
    x_fit(:,5)=GFM_linear_integral(x(1:train),omega,FN(i),test);
    % mean absolute percetage error
    x_copy=repmat(x,1,5);
    ae=abs(x_fit-x_copy);
    mae_train(i,:)=mean(ae(1:train,:),'omitnan');
    mae_test(i,:)=mean(ae(train+1:train+test,:),'omitnan');
    mae2latex(:,2*i-1)=mae_train(i,:)';
    mae2latex(:,2*i)=mae_test(i,:)';
    % plot subfigure
    nexttile
    plot(date,x,'Color','k','LineStyle','--','Marker','x','MarkerSize',8,'LineWidth',1.5);
    hold on;
    plot(date,x_fit(:,1),'Marker','none','MarkerSize',8,'LineWidth',1.5);
    plot(date,x_fit(:,2),'LineStyle','-','LineWidth',1.5);
    plot(date,x_fit(:,3),'Marker','none','MarkerSize',4,'LineWidth',1.5);
    plot(date,x_fit(:,4),'Marker','none','MarkerSize',4,'LineWidth',1.5);
    plot(date,x_fit(:,5),'Marker','none','MarkerSize',4,'LineWidth',1.5);
    grid on
    set(gca,'FontName','Book Antiqua','FontSize',12,'YLim',ylim(i,:),'XLim',xlim);
    title(title0(i),'FontWeight','bold','FontSize',14);
    xlabel({'Month'});
    xtickformat('yyyy-MM')
    ylabel(['PM_{2.5} concentration (¦Ìg/m^3)'])
    legend(len{i},'FontSize',8,'NumColumns',2);
    xline(date(train),'--','HandleVisibility','off')
end
%% save figure
savefig(gcf,'figure\case_compare_grey.fig');