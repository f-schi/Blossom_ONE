clc
clear all
close all

format longg

sn=5;  %number of repeat (seeds)

Nodes=[10 20 30 40 50 60 70 80 90 100];
%BlosSecData = importdata('SanFranBlosSec.csv');
BlosSecData = importdata('VeniceBlosSec.csv');
 
[rs cs]=size(BlosSecData.data);
% [rv cv]=size(Venice);


% 1:Delivery Probability, 2:Messages drop, 3: Overhead, 4:Latency
Sec(:,1)=str2double(BlosSecData.textdata(:,2));
Sec(:,2)=str2double(BlosSecData.textdata(:,3));
Sec(:,3)=str2double(BlosSecData.textdata(:,4));
Sec(:,4)=str2double(BlosSecData.textdata(:,5));
Sec(1,:)=[];
Sec(:,5)=(BlosSecData.data(:,1));

BlC=1;
PrC=1;
FcC=1;
EpC=1;

for i=2:rs+1
    x=string(BlosSecData.textdata(i,6));
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

CiDeliveryBLSec=zeros(10,1);
CiDropBlSec=zeros(10,1);
CiOverheadBlSec=zeros(10,1);
CiLatencyBlSec=zeros(10,1);

for iNode=1:10
    currentStartNode=(iNode - 1) * 5;
    
    DeliveryBlSec10=zeros(5,1);
    DropBlSec10=zeros(5,1);
    OverheadBlSec10=zeros(5,1);
    LatencyBlSec10=zeros(5,1);
    
    for i=1:5
        DeliveryBlSec10(i)=BlSec(currentStartNode + i, 1);
        DropBlSec10(i)=BlSec(currentStartNode + i, 2);
        OverheadBlSec10(i)=BlSec(currentStartNode + i, 3);
        LatencyBlSec10(i)=BlSec(currentStartNode + i, 4);
    end
    
    ciDeliveryBlSec10=mean(DeliveryBlSec10)+(1.96*(std(DeliveryBlSec10)/sqrt(sn)));
    ciDropBlSec10=mean(DropBlSec10)+(1.96*(std(DropBlSec10)/sqrt(sn)));
    ciOverheadBLSec10=mean(OverheadBlSec10)+(1.96*(std(OverheadBlSec10)/sqrt(sn)));
    LatencyBLSec10=mean(LatencyBlSec10)+(1.96*(std(LatencyBlSec10)/sqrt(sn)));
    
  
    CiDeliveryBLSec(iNode) = ciDeliveryBlSec10;
    CiDropBlSec(iNode) = ciDropBlSec10;
    CiOverheadBlSec(iNode) = ciOverheadBLSec10;
    CiLatencyBlSec(iNode) = LatencyBLSec10;
end
%%
%Blossom
%SanFrancisco= importdata('SanFranBestSimulation.csv');
SanFrancisco= importdata('VeniceBestSimulation.csv');

% VeniceAll= importdata('SanFranAllSettings.csv');
% Venice= importdata('SanFranBestSimulation.csv');

[rs cs]=size(SanFrancisco.data);
% [rv cv]=size(Venice);


% 1:Delivery Probability, 2:Messages drop, 3: Overhead, 4:Latency
San(:,1)=str2double(SanFrancisco.textdata(:,2));
San(:,2)=str2double(SanFrancisco.textdata(:,3));
San(:,3)=str2double(SanFrancisco.textdata(:,4));
San(:,4)=str2double(SanFrancisco.textdata(:,5));
San(1,:)=[];
San(:,5)=(SanFrancisco.data(:,1));

BlC=1;
PrC=1;
FcC=1;
EpC=1;

for i=2:rs+1
    x=string(SanFrancisco.textdata(i,6));
   % switch x
        if contains(x,"Blossom")
            SanBl(BlC,:)=San(i-1,:);
            BlC=BlC+1;
          %  break;
        end
        if contains(x,"PRoPHET") %x=='PRoPHET'
             SanPr(PrC,:)=San(i-1,:);
             PrC=PrC+1;
          %   break;
        end
        if contains(x,"FirstContact") %x=='FirstContact'
             SanFC(FcC,:)=San(i-1,:);
             FcC=FcC+1;
            % break;
        end
        if contains(x,"Epidemic")  %x=='Epidemic'
             SanEp(EpC,:)=San(i-1,:);
             EpC=EpC+1;           
        end    
end


DeliveryBl10=[SanBl(1,1) SanBl(11,1) SanBl(21,1) SanBl(31,1) SanBl(41,1)];
DropBl10=[SanBl(1,2) SanBl(11,2) SanBl(21,2) SanBl(31,2) SanBl(41,2)];
OverheadBl10=[SanBl(1,3) SanBl(11,3) SanBl(21,3) SanBl(31,3) SanBl(41,3)];
LatencyBl10=[SanBl(1,4) SanBl(11,4) SanBl(21,4) SanBl(31,4) SanBl(41,4)];

DeliveryBl20=[SanBl(2,1) SanBl(12,1) SanBl(22,1) SanBl(32,1) SanBl(42,1)];
DropBl20=[SanBl(2,2) SanBl(12,2) SanBl(22,2) SanBl(32,2) SanBl(42,2)];
OverheadBl20=[SanBl(2,3) SanBl(12,3) SanBl(22,3) SanBl(32,3) SanBl(42,3)];
LatencyBl20=[SanBl(2,4) SanBl(12,4) SanBl(22,4) SanBl(32,4) SanBl(42,4)];

DeliveryBl30=[SanBl(3,1) SanBl(13,1) SanBl(23,1) SanBl(33,1) SanBl(43,1)];
DropBl30=[SanBl(3,2) SanBl(13,2) SanBl(23,2) SanBl(33,2) SanBl(43,2)];
OverheadBl30=[SanBl(3,3) SanBl(13,3) SanBl(23,3) SanBl(33,3) SanBl(43,3)];
LatencyBl30=[SanBl(3,4) SanBl(13,4) SanBl(23,4) SanBl(33,4) SanBl(43,4)];

DeliveryBl40=[SanBl(4,1) SanBl(14,1) SanBl(24,1) SanBl(34,1) SanBl(44,1)];
DropBl40=[SanBl(4,2) SanBl(14,2) SanBl(24,2) SanBl(34,2) SanBl(44,2)];
OverheadBl40=[SanBl(4,3) SanBl(14,3) SanBl(24,3) SanBl(34,3) SanBl(44,3)];
LatencyBl40=[SanBl(4,4) SanBl(14,4) SanBl(24,4) SanBl(34,4) SanBl(44,4)];

DeliveryBl50=[SanBl(5,1) SanBl(15,1) SanBl(25,1) SanBl(35,1) SanBl(45,1)];
DropBl50=[SanBl(5,2) SanBl(15,2) SanBl(25,2) SanBl(35,2) SanBl(45,2)];
OverheadBl50=[SanBl(5,3) SanBl(15,3) SanBl(25,3) SanBl(35,3) SanBl(45,3)];
LatencyBl50=[SanBl(5,4) SanBl(15,4) SanBl(25,4) SanBl(35,4) SanBl(45,4)];

DeliveryBl60=[SanBl(6,1) SanBl(16,1) SanBl(26,1) SanBl(36,1) SanBl(46,1)];
DropBl60=[SanBl(6,2) SanBl(16,2) SanBl(26,2) SanBl(36,2) SanBl(46,2)];
OverheadBl60=[SanBl(6,3) SanBl(16,3) SanBl(26,3) SanBl(36,3) SanBl(46,3)];
LatencyBl60=[SanBl(6,4) SanBl(16,4) SanBl(26,4) SanBl(36,4) SanBl(46,4)];

DeliveryBl70=[SanBl(7,1) SanBl(17,1) SanBl(27,1) SanBl(37,1) SanBl(47,1)];
DropBl70=[SanBl(7,2) SanBl(17,2) SanBl(27,2) SanBl(37,2) SanBl(47,2)];
OverheadBl70=[SanBl(7,3) SanBl(17,3) SanBl(27,3) SanBl(37,3) SanBl(47,3)];
LatencyBl70=[SanBl(7,4) SanBl(17,4) SanBl(27,4) SanBl(37,4) SanBl(47,4)];

DeliveryBl80=[SanBl(8,1) SanBl(18,1) SanBl(28,1) SanBl(38,1) SanBl(48,1)];
DropBl80=[SanBl(8,2) SanBl(18,2) SanBl(28,2) SanBl(38,2) SanBl(48,2)];
OverheadBl80=[SanBl(8,3) SanBl(18,3) SanBl(28,3) SanBl(38,3) SanBl(48,3)];
LatencyBl80=[SanBl(8,4) SanBl(18,4) SanBl(28,4) SanBl(38,4) SanBl(48,4)];


DeliveryBl90=[SanBl(9,1) SanBl(19,1) SanBl(29,1) SanBl(39,1) SanBl(49,1)];
DropBl90=[SanBl(9,2) SanBl(19,2) SanBl(29,2) SanBl(39,2) SanBl(49,2)];
OverheadBl90=[SanBl(9,3) SanBl(19,3) SanBl(29,3) SanBl(39,3) SanBl(49,3)];
LatencyBl90=[SanBl(9,4) SanBl(19,4) SanBl(29,4) SanBl(39,4) SanBl(49,4)];

DeliveryBl100=[SanBl(10,1) SanBl(20,1) SanBl(30,1) SanBl(40,1) SanBl(50,1)];
DropBl100=[SanBl(10,2) SanBl(20,2) SanBl(30,2) SanBl(40,2) SanBl(50,2)];
OverheadBl100=[SanBl(10,3) SanBl(20,3) SanBl(30,3) SanBl(40,3) SanBl(50,3)];
LatencyBl100=[SanBl(10,4) SanBl(20,4) SanBl(30,4) SanBl(40,4) SanBl(50,4)];
%%%%%
ciDeliveryBlSan10=mean(DeliveryBl10)+(1.96*(std(DeliveryBl10)/sqrt(sn)));
ciDropBlSan10=mean(DropBl10)+(1.96*(std(DropBl10)/sqrt(sn)));
ciOverheadBLSan10=mean(OverheadBl10)+(1.96*(std(OverheadBl10)/sqrt(sn)));
LatencyBLSan10=mean(LatencyBl10)+(1.96*(std(LatencyBl10)/sqrt(sn)));

ciDeliveryBlSan20=mean(DeliveryBl20)+(1.96*(std(DeliveryBl20)/sqrt(sn)));
ciDropBlSan20=mean(DropBl20)+(1.96*(std(DropBl20)/sqrt(sn)));
ciOverheadBLSan20=mean(OverheadBl20)+(1.96*(std(OverheadBl20)/sqrt(sn)));
LatencyBLSan20=mean(LatencyBl20)+(1.96*(std(LatencyBl20)/sqrt(sn)));

ciDeliveryBlSan30=mean(DeliveryBl30)+(1.96*(std(DeliveryBl30)/sqrt(sn)));
ciDropBlSan30=mean(DropBl30)+(1.96*(std(DropBl30)/sqrt(sn)));
ciOverheadBLSan30=mean(OverheadBl30)+(1.96*(std(OverheadBl30)/sqrt(sn)));
LatencyBLSan30=mean(LatencyBl30)+(1.96*(std(LatencyBl30)/sqrt(sn)));

ciDeliveryBlSan40=mean(DeliveryBl40)+(1.96*(std(DeliveryBl40)/sqrt(sn)));
ciDropBlSan40=mean(DropBl40)+(1.96*(std(DropBl40)/sqrt(sn)));
ciOverheadBLSan40=mean(OverheadBl40)+(1.96*(std(OverheadBl40)/sqrt(sn)));
LatencyBLSan40=mean(LatencyBl40)+(1.96*(std(LatencyBl40)/sqrt(sn)));

ciDeliveryBlSan50=mean(DeliveryBl50)+(1.96*(std(DeliveryBl50)/sqrt(sn)));
ciDropBlSan50=mean(DropBl50)+(1.96*(std(DropBl50)/sqrt(sn)));
ciOverheadBLSan50=mean(OverheadBl50)+(1.96*(std(OverheadBl50)/sqrt(sn)));
LatencyBLSan50=mean(LatencyBl50)+(1.96*(std(LatencyBl50)/sqrt(sn)));

ciDeliveryBlSan60=mean(DeliveryBl60)+(1.96*(std(DeliveryBl60)/sqrt(sn)));
ciDropBlSan60=mean(DropBl60)+(1.96*(std(DropBl60)/sqrt(sn)));
ciOverheadBLSan60=mean(OverheadBl60)+(1.96*(std(OverheadBl60)/sqrt(sn)));
LatencyBLSan60=mean(LatencyBl60)+(1.96*(std(LatencyBl60)/sqrt(sn)));

ciDeliveryBlSan70=mean(DeliveryBl70)+(1.96*(std(DeliveryBl70)/sqrt(sn)));
ciDropBlSan70=mean(DropBl70)+(1.96*(std(DropBl70)/sqrt(sn)));
ciOverheadBLSan70=mean(OverheadBl70)+(1.96*(std(OverheadBl70)/sqrt(sn)));
LatencyBLSan70=mean(LatencyBl70)+(1.96*(std(LatencyBl70)/sqrt(sn)));

ciDeliveryBlSan80=mean(DeliveryBl80)+(1.96*(std(DeliveryBl80)/sqrt(sn)));
ciDropBlSan80=mean(DropBl80)+(1.96*(std(DropBl80)/sqrt(sn)));
ciOverheadBLSan80=mean(OverheadBl80)+(1.96*(std(OverheadBl80)/sqrt(sn)));
LatencyBLSan80=mean(LatencyBl80)+(1.96*(std(LatencyBl80)/sqrt(sn)));

ciDeliveryBlSan90=mean(DeliveryBl90)+(1.96*(std(DeliveryBl90)/sqrt(sn)));
ciDropBlSan90=mean(DropBl90)+(1.96*(std(DropBl90)/sqrt(sn)));
ciOverheadBLSan90=mean(OverheadBl90)+(1.96*(std(OverheadBl90)/sqrt(sn)));
LatencyBLSan90=mean(LatencyBl90)+(1.96*(std(LatencyBl90)/sqrt(sn)));

ciDeliveryBlSan100=mean(DeliveryBl100)+(1.96*(std(DeliveryBl100)/sqrt(sn)));
ciDropBlSan100=mean(DropBl100)+(1.96*(std(DropBl100)/sqrt(sn)));
ciOverheadBLSan100=mean(OverheadBl100)+(1.96*(std(OverheadBl100)/sqrt(sn)));
LatencyBLSan100=mean(LatencyBl100)+(1.96*(std(LatencyBl100)/sqrt(sn)));

CiDeliveryBLSan=[ciDeliveryBlSan10 ciDeliveryBlSan20 ciDeliveryBlSan30 ciDeliveryBlSan40 ciDeliveryBlSan50 ciDeliveryBlSan60 ciDeliveryBlSan70 ciDeliveryBlSan80 ciDeliveryBlSan90 ciDeliveryBlSan100];
CiDropBlSan=[ciDropBlSan10 ciDropBlSan20 ciDropBlSan30 ciDropBlSan40 ciDropBlSan50 ciDropBlSan60 ciDropBlSan70 ciDropBlSan80 ciDropBlSan90 ciDropBlSan100 ];
CiOverheadBlSan=[ciOverheadBLSan10 ciOverheadBLSan20 ciOverheadBLSan30 ciOverheadBLSan40 ciOverheadBLSan50 ciOverheadBLSan60 ciOverheadBLSan70 ciOverheadBLSan80 ciOverheadBLSan90 ciOverheadBLSan100];
CiLatencyBlSan=[LatencyBLSan10 LatencyBLSan20 LatencyBLSan30 LatencyBLSan40 LatencyBLSan50 LatencyBLSan60 LatencyBLSan70 LatencyBLSan80 LatencyBLSan90 LatencyBLSan100];


%%
figure
plot(Nodes,CiDeliveryBLSan,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiDeliveryBLSec,'-+','LineWidth',1.5)


set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Delivery (Venice)')
xlabel('Nodes') % x-axis label
ylabel('Messages Delivery') % y-axis label
legend('Blossom', 'BlosSec', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
 grid on

%%
figure
plot(Nodes,CiDropBlSan,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiDropBlSec,'-+','LineWidth',1.5)


set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Dropped Messages (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Dropped Messages') % y-axis label
legend('Blossom', 'BlosSec', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
 grid on
 
%%
figure
plot(Nodes,CiLatencyBlSan,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiLatencyBlSec,'-+','LineWidth',1.5)


set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Latency (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Latency') % y-axis label
legend('Blossom', 'BlosSec', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
 grid on

%%
figure
plot(Nodes,CiOverheadBlSan,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiOverheadBlSec,'-+','LineWidth',1.5)


set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Network Overhead (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Network Overhead') % y-axis label
legend('Blossom', 'BlosSec', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
 grid on

