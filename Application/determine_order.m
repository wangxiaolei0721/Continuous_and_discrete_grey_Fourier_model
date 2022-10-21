%% clear data and figure
clc;
clear;
close all;
%% add path to MATLAB
addpath('..\','.\benchmark_grey_model')
%% load data
load PM25.mat;
omega=pi/6; % angular frequency
train=72; % train size
figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5, 5, 40,20],'PaperSize',[40,20]);
tiledlayout(2,3,'TileSpacing','Compact','Padding','Compact'); % new subfigure
%% Zhengzhou
nexttile % next subfigure
x=PM25.zhengzhou;
x_detrend=x(1:train)-GM11(x(1:train),0); % remove trend
[ xfreq,xpower]=fourier_transform(x_detrend); % power
plot(xfreq,xpower,'color',[0, 114, 189]/255,'LineWidth',1.5)
xline(xfreq(6),'--','HandleVisibility','off')
xline(xfreq(12),'--','HandleVisibility','off')
text(xfreq(6),800000,['$\rightarrow f$=',num2str(xfreq(6))],'Interpreter','latex')
text(xfreq(12),300000,['$\rightarrow f$=',num2str(xfreq(12))],'Interpreter','latex')
set(gca,'FontName','Book Antiqua','FontSize',12);
xlabel(['Frequency'],'FontSize',14,'Interpreter','latex');
ylabel({'Power'},'FontSize',14);
title("(a) Zhengzhou",'FontWeight','bold','FontSize',14);
%% Anyang
nexttile % next subfigure
x=PM25.anyang;
x_detrend=x(1:train)-GM11(x(1:train),0); % remove trend
[ xfreq,xpower]=fourier_transform(x_detrend); % power
plot(xfreq,xpower,'color',[0, 114, 189]/255,'LineWidth',1.5)
xline(xfreq(6),'--','HandleVisibility','off')
xline(xfreq(12),'--','HandleVisibility','off')
text(xfreq(6),800000,['$\rightarrow f$=',num2str(xfreq(6))],'Interpreter','latex')
text(xfreq(12),300000,['$\rightarrow f$=',num2str(xfreq(12))],'Interpreter','latex')
set(gca,'FontName','Book Antiqua','FontSize',12);
xlabel(['Frequency'],'FontSize',14,'Interpreter','latex');
ylabel({'Power'},'FontSize',14);
title("(b) Anyang",'FontWeight','bold','FontSize',14);
%% Xinxiang
nexttile % next subfigure
x=PM25.xinxiang;
x_detrend=x(1:train)-GM11(x(1:train),0); % remove trend
[ xfreq,xpower]=fourier_transform(x_detrend); % power
plot(xfreq,xpower,'color',[0, 114, 189]/255,'LineWidth',1.5)
xline(xfreq(6),'--','HandleVisibility','off')
xline(xfreq(12),'--','HandleVisibility','off')
text(xfreq(6),800000,['$\rightarrow f$=',num2str(xfreq(6))],'Interpreter','latex')
text(xfreq(12),300000,['$\rightarrow f$=',num2str(xfreq(12))],'Interpreter','latex')
set(gca,'FontName','Book Antiqua','FontSize',12);
xlabel(['Frequency'],'FontSize',14,'Interpreter','latex');
ylabel({'Power'},'FontSize',14);
title("(c) Xinxiang",'FontWeight','bold','FontSize',14);
%% Luoyang
nexttile % next subfigure
x=PM25.luoyang;
x_detrend=x(1:train)-GM11(x(1:train),0); % remove trend
[ xfreq,xpower]=fourier_transform(x_detrend); % power
plot(xfreq,xpower,'color',[0, 114, 189]/255,'LineWidth',1.5)
xline(xfreq(6),'--','HandleVisibility','off')
xline(xfreq(12),'--','HandleVisibility','off')
text(xfreq(6),800000,['$\rightarrow f$=',num2str(xfreq(6))],'Interpreter','latex')
text(xfreq(12),300000,['$\rightarrow f$=',num2str(xfreq(12))],'Interpreter','latex')
set(gca,'FontName','Book Antiqua','FontSize',12);
xlabel(['Frequency'],'FontSize',14,'Interpreter','latex');
ylabel({'Power'},'FontSize',14);
title("(d) Luoyang",'FontWeight','bold','FontSize',14);
%% Shangqiu
nexttile % next subfigure
x=PM25.shangqiu;
x_detrend=x(1:train)-GM11(x(1:train),0); % remove trend
[ xfreq,xpower]=fourier_transform(x_detrend); % power
plot(xfreq,xpower,'color',[0, 114, 189]/255,'LineWidth',1.5)
xline(xfreq(6),'--','HandleVisibility','off')
xline(xfreq(12),'--','HandleVisibility','off')
text(xfreq(6),800000,['$\rightarrow f$=',num2str(xfreq(6))],'Interpreter','latex')
text(xfreq(12),300000,['$\rightarrow f$=',num2str(xfreq(12))],'Interpreter','latex')
set(gca,'FontName','Book Antiqua','FontSize',12);
xlabel(['Frequency'],'FontSize',14,'Interpreter','latex');
ylabel({'Power'},'FontSize',14);
title("(e) Shangqiu",'FontWeight','bold','FontSize',14);
%% Nanyang
nexttile % next subfigure
x=PM25.nanyang;
x_detrend=x(1:train)-GM11(x(1:train),0); % remove trend
[ xfreq,xpower]=fourier_transform(x_detrend); % power
plot(xfreq,xpower,'color',[0, 114, 189]/255,'LineWidth',1.5)
xline(xfreq(6),'--','HandleVisibility','off')
xline(xfreq(12),'--','HandleVisibility','off')
text(xfreq(6),800000,['$\rightarrow f$=',num2str(xfreq(6))],'Interpreter','latex')
text(xfreq(12),300000,['$\rightarrow f$=',num2str(xfreq(12))],'Interpreter','latex')
set(gca,'FontName','Book Antiqua','FontSize',12);
xlabel(['Frequency'],'FontSize',14,'Interpreter','latex');
ylabel({'Power'},'FontSize',14);
title("(f) Nanyang",'FontWeight','bold','FontSize',14);
%% save figure
savefig(gcf,'figure\order.fig');