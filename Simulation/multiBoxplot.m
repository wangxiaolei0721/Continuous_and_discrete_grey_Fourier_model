function multiBoxplot(MatCel,xlab,colrs,lgdtxt,lcn)
% MatCel: a cell array including all matrices. All matrices should have
%         equal number of columns. 
% xlab:   the label tick in each groups.
% colrs:  matrix specifies the color of boxes.
% lgdtxt: text specifies the contents of legend.
% lgdloc: text specifies the location of legend. 
% 
% 
% Example: 
% rng default
% gpd = {randn(100,5), 2*randn(100,5), 4*randn(100,5)};
% xlab = 1:5;
% colr = rand(4,3);
% clf
% multiBoxplot(gpd, xlab, colr, {'11','12','13'},'northwest') 
% 

%% Check inputs
if ~iscell(MatCel)
    error('Input data is not even a cell array!');
elseif min(size(MatCel)) ~= 1
    error('Input should be a row or column array!');
end

ngs = size(MatCel{1},2);        % number of group boxes
nbs = length(MatCel);           % number of boxes in each group

if size(colrs,2)~=nbs
    error('Wrong amount of colors!');
end

if length(xlab)~=ngs
    error('Wrong amount of X labels given');
end

box_width = 0.15;                % widths of the individual box
outlier_size = 4;               % size of outliers in each plot

%%

% Prepare data 
gdata = cell(ngs,nbs); 
for i = 1:ngs
    for j = 1:nbs
        gdata{i,j} = MatCel{j}(:,i);
    end
end 

% Calculate positions of boxes
pos = 1:0.25:nbs*ngs*0.25+1+0.25*ngs;
pos(1:nbs+1:end) = [];

% Extract data and label it in the group
bxv = [];
bxg = [];
for ii=1:ngs
    for jj=1:nbs
        aux = gdata{ii,jj};
        bxv = vertcat(bxv,aux(:));
        bxg = vertcat(bxg,ones(size(aux(:)))*jj+(ii-1)*nbs);
    end
end

% Plot group boxs
boxplot(bxv, bxg, 'positions',pos, ... 
    "Colors","w", "Notch","on", "Widths",box_width, ...  % configuration of box body
    "Symbol","w+", "OutlierSize",outlier_size)  % configuration of outliers 

% Fill boxes with colors
color = repmat(colrs, 1, ngs);

h = findobj(gca,'Tag','Box');
for jj=1:length(h)
   patch(get(h(jj),'XData'),get(h(jj),'YData'),color(1:3,jj)',...
       'FaceAlpha',color(4,jj), 'EdgeColor','none');
end

legend(fliplr(lgdtxt),'location',lcn,'Fontsize',11);

%
hold on
boxplot(bxv, bxg, 'positions',pos,'colors','k', ... 
    "Notch","on", "Widths",box_width, ...  % configuration of box body
    "Symbol","w+", "OutlierSize",outlier_size)  % configuration of outliers 

% change outliers color
outlier_obj = findobj(gcf,'tag','Outliers');
 for j = 1:numel(outlier_obj)
    outlier_obj(j).MarkerEdgeColor = [0.3,0.3, 0.3];
 end
 
hold off

% Set Xlabels
aux = reshape(pos,nbs,[]);
xlabpos = sum(aux,1)./nbs;
set(gca, 'xtick',xlabpos, 'xticklabel',xlab);
end

