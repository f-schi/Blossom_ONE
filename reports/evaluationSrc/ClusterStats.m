clc
clear all
close all

format longg

sn=5;  %number of repeat (seeds)

Nodes=[10 20 30 40 50 60 70 80 90 100];
%BlosSecData = importdata('SanFranBlosSecClusterStats.csv');
BlosSecData = importdata('VeniceBlosSecClusterStats.csv');
 
[rs cs]=size(BlosSecData.data);
% [rv cv]=size(Venice);


% 1:avg, 2:avgEnd,
Sec(:,1)=str2double(BlosSecData.textdata(:,2));
Sec(:,2)=str2double(BlosSecData.textdata(:,3));
Sec(1,:)=[];
Sec(:,3)=(BlosSecData.data(:,1));

BlC=1;

for i=2:rs+1
    x=string(BlosSecData.textdata(i,4));
   % switch x
        if contains(x,"BlosSec")
            BlSec(BlC,:)=Sec(i-1,:);
            BlC=BlC+1;
          %  break;
        end  
end
%%
%Calculate confidential interval
%%
%BlosSec

CiAvgBLSec=zeros(10,1);
CiAvgEndBlSec=zeros(10,1);

for iNode=1:10
    currentStartNode=(iNode - 1) * 5;
    
    AvgBlSec10=zeros(5,1);
    AvgEndBlSec10=zeros(5,1);
    
    for i=1:5
        AvgBlSec10(i)=BlSec(currentStartNode + i, 1);
        AvgEndBlSec10(i)=BlSec(currentStartNode + i, 2);
    end
    ciAvgBlSec10=mean(AvgBlSec10)+(1.96*(std(AvgBlSec10)/sqrt(sn)));
    ciAvgEndBlSec10=mean(AvgEndBlSec10)+(1.96*(std(AvgEndBlSec10)/sqrt(sn)));
 
  
    CiAvgBLSec(iNode) = ciAvgBlSec10;
    CiAvgEndBlSec(iNode) = ciAvgEndBlSec10;
end
%% BLossom

sn=5;  %number of repeat (seeds)

Nodes=[10 20 30 40 50 60 70 80 90 100];
%BlossomData = importdata('SanFranBlossomClusterStats.csv');
BlossomData = importdata('VeniceBlossomClusterStats.csv');
 
[rs cs]=size(BlossomData.data);
% [rv cv]=size(Venice);


% 1:avg, 2:avgEnd,
Sta(:,1)=str2double(BlossomData.textdata(:,2));
Sta(:,2)=str2double(BlossomData.textdata(:,3));
Sta(1,:)=[];
Sta(:,3)=(BlossomData.data(:,1));

BloC=1;

for i=2:rs+1
    x=string(BlossomData.textdata(i,4));
   % switch x
        if contains(x,"Blossom")
            Blossom(BloC,:)=Sta(i-1,:);
            BloC=BloC+1;
          %  break;
        end  
end
%%
%Calculate confidential interval
%%
%BlosSec

CiAvgBlos=zeros(10,1);
CiAvgEndBlos=zeros(10,1);

for iNode=1:10
    currentStartNode=(iNode - 1) * 5;
    
    AvgBlos10=zeros(5,1);
    AvgEndBlos10=zeros(5,1);
    
    for i=1:5
        AvgBlos10(i)=Blossom(currentStartNode + i, 1);
        AvgEndBlos10(i)=Blossom(currentStartNode + i, 2);
    end
    ciAvgBlos10=mean(AvgBlos10)+(1.96*(std(AvgBlos10)/sqrt(sn)));
    ciAvgEndBlos10=mean(AvgEndBlos10)+(1.96*(std(AvgEndBlos10)/sqrt(sn)));
 
  
    CiAvgBlos(iNode) = ciAvgBlos10;
    CiAvgEndBlos(iNode) = ciAvgEndBlos10;
end
%%

%%
figure
plot(Nodes,CiAvgBlos,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiAvgBLSec,'-+','LineWidth',1.5)


set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Avg. Cluster Size (Venice)')
xlabel('Nodes') % x-axis label
ylabel('Avg. Cluster Size') % y-axis label
legend('Blossom', 'BlosSec', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
 grid on

%%
figure
plot(Nodes,CiAvgBlos,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiAvgEndBlSec,'-+','LineWidth',1.5)


set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Avg. Cluster Size at the End (Venice)')
xlabel('Nodes') % x-axis label
ylabel('Avg. Cluster Size') % y-axis label
legend('Blossom', 'BlosSec', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
 grid on
 