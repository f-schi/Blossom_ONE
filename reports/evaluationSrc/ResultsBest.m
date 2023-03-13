clc
clear all
close all

format longg

sn=5;  %number of repeat (seeds)

Nodes=[10 20 30 40 50 60 70 80 90 100];
% SanFranciscoAll= importdata('SanFranAllSettings.csv');
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
%%
%Calculate confidential interval
%%
%Blossom
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
%%
%Prophet
DeliveryPr10=[SanPr(1,1) SanPr(11,1) SanPr(21,1) SanPr(31,1) SanPr(41,1)];
DropPr10=[SanPr(1,2) SanPr(11,2) SanPr(21,2) SanPr(31,2) SanPr(41,2)];
OverheadPr10=[SanPr(1,3) SanPr(11,3) SanPr(21,3) SanPr(31,3) SanPr(41,3)];
LatencyPr10=[SanPr(1,4) SanPr(11,4) SanPr(21,4) SanPr(31,4) SanPr(41,4)];

DeliveryPr20=[SanPr(2,1) SanPr(12,1) SanPr(22,1) SanPr(32,1) SanPr(42,1)];
DropPr20=[SanPr(2,2) SanPr(12,2) SanPr(22,2) SanPr(32,2) SanPr(42,2)];
OverheadPr20=[SanPr(2,3) SanPr(12,3) SanPr(22,3) SanPr(32,3) SanPr(42,3)];
LatencyPr20=[SanPr(2,4) SanPr(12,4) SanPr(22,4) SanPr(32,4) SanPr(42,4)];

DeliveryPr30=[SanPr(3,1) SanPr(13,1) SanPr(23,1) SanPr(33,1) SanPr(43,1)];
DropPr30=[SanPr(3,2) SanPr(13,2) SanPr(23,2) SanPr(33,2) SanPr(43,2)];
OverheadPr30=[SanPr(3,3) SanPr(13,3) SanPr(23,3) SanPr(33,3) SanPr(43,3)];
LatencyPr30=[SanPr(3,4) SanPr(13,4) SanPr(23,4) SanPr(33,4) SanPr(43,4)];

DeliveryPr40=[SanPr(4,1) SanPr(14,1) SanPr(24,1) SanPr(34,1) SanPr(44,1)];
DropPr40=[SanPr(4,2) SanPr(14,2) SanPr(24,2) SanPr(34,2) SanPr(44,2)];
OverheadPr40=[SanPr(4,3) SanPr(14,3) SanPr(24,3) SanPr(34,3) SanPr(44,3)];
LatencyPr40=[SanPr(4,4) SanPr(14,4) SanPr(24,4) SanPr(34,4) SanPr(44,4)];

DeliveryPr50=[SanPr(5,1) SanPr(15,1) SanPr(25,1) SanPr(35,1) SanPr(45,1)];
DropPr50=[SanPr(5,2) SanPr(15,2) SanPr(25,2) SanPr(35,2) SanPr(45,2)];
OverheadPr50=[SanPr(5,3) SanPr(15,3) SanPr(25,3) SanPr(35,3) SanPr(45,3)];
LatencyPr50=[SanPr(5,4) SanPr(15,4) SanPr(25,4) SanPr(35,4) SanPr(45,4)];

DeliveryPr60=[SanPr(6,1) SanPr(16,1) SanPr(26,1) SanPr(36,1) SanPr(46,1)];
DropPr60=[SanPr(6,2) SanPr(16,2) SanPr(26,2) SanPr(36,2) SanPr(46,2)];
OverheadPr60=[SanPr(6,3) SanPr(16,3) SanPr(26,3) SanPr(36,3) SanPr(46,3)];
LatencyPr60=[SanPr(6,4) SanPr(16,4) SanPr(26,4) SanPr(36,4) SanPr(46,4)];

DeliveryPr70=[SanPr(7,1) SanPr(17,1) SanPr(27,1) SanPr(37,1) SanPr(47,1)];
DropPr70=[SanPr(7,2) SanPr(17,2) SanPr(27,2) SanPr(37,2) SanPr(47,2)];
OverheadPr70=[SanPr(7,3) SanPr(17,3) SanPr(27,3) SanPr(37,3) SanPr(47,3)];
LatencyPr70=[SanPr(7,4) SanPr(17,4) SanPr(27,4) SanPr(37,4) SanPr(47,4)];

DeliveryPr80=[SanPr(8,1) SanPr(18,1) SanPr(28,1) SanPr(38,1) SanPr(48,1)];
DropPr80=[SanPr(8,2) SanPr(18,2) SanPr(28,2) SanPr(38,2) SanPr(48,2)];
OverheadPr80=[SanPr(8,3) SanPr(18,3) SanPr(28,3) SanPr(38,3) SanPr(48,3)];
LatencyPr80=[SanPr(8,4) SanPr(18,4) SanPr(28,4) SanPr(38,4) SanPr(48,4)];


DeliveryPr90=[SanPr(9,1) SanPr(19,1) SanPr(29,1) SanPr(39,1) SanPr(49,1)];
DropPr90=[SanPr(9,2) SanPr(19,2) SanPr(29,2) SanPr(39,2) SanPr(49,2)];
OverheadPr90=[SanPr(9,3) SanPr(19,3) SanPr(29,3) SanPr(39,3) SanPr(49,3)];
LatencyPr90=[SanPr(9,4) SanPr(19,4) SanPr(29,4) SanPr(39,4) SanPr(49,4)];

DeliveryPr100=[SanPr(10,1) SanPr(20,1) SanPr(30,1) SanPr(40,1) SanPr(50,1)];
DropPr100=[SanPr(10,2) SanPr(20,2) SanPr(30,2) SanPr(40,2) SanPr(50,2)];
OverheadPr100=[SanPr(10,3) SanPr(20,3) SanPr(30,3) SanPr(40,3) SanPr(50,3)];
LatencyPr100=[SanPr(10,4) SanPr(20,4) SanPr(30,4) SanPr(40,4) SanPr(50,4)];
%%%%%
ciDeliveryPrSan10=mean(DeliveryPr10)+(1.96*(std(DeliveryPr10)/sqrt(sn)));
ciDropPrSan10=mean(DropPr10)+(1.96*(std(DropPr10)/sqrt(sn)));
ciOverheadPrSan10=mean(OverheadPr10)+(1.96*(std(OverheadPr10)/sqrt(sn)));
LatencyPrSan10=mean(LatencyPr10)+(1.96*(std(LatencyPr10)/sqrt(sn)));

ciDeliveryPrSan20=mean(DeliveryPr20)+(1.96*(std(DeliveryPr20)/sqrt(sn)));
ciDropPrSan20=mean(DropPr20)+(1.96*(std(DropPr20)/sqrt(sn)));
ciOverheadPrSan20=mean(OverheadPr20)+(1.96*(std(OverheadPr20)/sqrt(sn)));
LatencyPrSan20=mean(LatencyPr20)+(1.96*(std(LatencyPr20)/sqrt(sn)));

ciDeliveryPrSan30=mean(DeliveryPr30)+(1.96*(std(DeliveryPr30)/sqrt(sn)));
ciDropPrSan30=mean(DropPr30)+(1.96*(std(DropPr30)/sqrt(sn)));
ciOverheadPrSan30=mean(OverheadPr30)+(1.96*(std(OverheadPr30)/sqrt(sn)));
LatencyPrSan30=mean(LatencyPr30)+(1.96*(std(LatencyPr30)/sqrt(sn)));

ciDeliveryPrSan40=mean(DeliveryPr40)+(1.96*(std(DeliveryPr40)/sqrt(sn)));
ciDropPrSan40=mean(DropPr40)+(1.96*(std(DropPr40)/sqrt(sn)));
ciOverheadPrSan40=mean(OverheadPr40)+(1.96*(std(OverheadPr40)/sqrt(sn)));
LatencyPrSan40=mean(LatencyPr40)+(1.96*(std(LatencyPr40)/sqrt(sn)));

ciDeliveryPrSan50=mean(DeliveryPr50)+(1.96*(std(DeliveryPr50)/sqrt(sn)));
ciDropPrSan50=mean(DropPr50)+(1.96*(std(DropPr50)/sqrt(sn)));
ciOverheadPrSan50=mean(OverheadPr50)+(1.96*(std(OverheadPr50)/sqrt(sn)));
LatencyPrSan50=mean(LatencyPr50)+(1.96*(std(LatencyPr50)/sqrt(sn)));

ciDeliveryPrSan60=mean(DeliveryPr60)+(1.96*(std(DeliveryPr60)/sqrt(sn)));
ciDropPrSan60=mean(DropPr60)+(1.96*(std(DropPr60)/sqrt(sn)));
ciOverheadPrSan60=mean(OverheadPr60)+(1.96*(std(OverheadPr60)/sqrt(sn)));
LatencyPrSan60=mean(LatencyPr60)+(1.96*(std(LatencyPr60)/sqrt(sn)));

ciDeliveryPrSan70=mean(DeliveryPr70)+(1.96*(std(DeliveryPr70)/sqrt(sn)));
ciDropPrSan70=mean(DropPr70)+(1.96*(std(DropPr70)/sqrt(sn)));
ciOverheadPrSan70=mean(OverheadPr70)+(1.96*(std(OverheadPr70)/sqrt(sn)));
LatencyPrSan70=mean(LatencyPr70)+(1.96*(std(LatencyPr70)/sqrt(sn)));

ciDeliveryPrSan80=mean(DeliveryPr80)+(1.96*(std(DeliveryPr80)/sqrt(sn)));
ciDropPrSan80=mean(DropPr80)+(1.96*(std(DropPr80)/sqrt(sn)));
ciOverheadPrSan80=mean(OverheadPr80)+(1.96*(std(OverheadPr80)/sqrt(sn)));
LatencyPrSan80=mean(LatencyPr80)+(1.96*(std(LatencyPr80)/sqrt(sn)));

ciDeliveryPrSan90=mean(DeliveryPr90)+(1.96*(std(DeliveryPr90)/sqrt(sn)));
ciDropPrSan90=mean(DropPr90)+(1.96*(std(DropPr90)/sqrt(sn)));
ciOverheadPrSan90=mean(OverheadPr90)+(1.96*(std(OverheadPr90)/sqrt(sn)));
LatencyPrSan90=mean(LatencyPr90)+(1.96*(std(LatencyPr90)/sqrt(sn)));

ciDeliveryPrSan100=mean(DeliveryPr100)+(1.96*(std(DeliveryPr100)/sqrt(sn)));
ciDropPrSan100=mean(DropPr100)+(1.96*(std(DropPr100)/sqrt(sn)));
ciOverheadPrSan100=mean(OverheadPr100)+(1.96*(std(OverheadPr100)/sqrt(sn)));
LatencyPrSan100=mean(LatencyPr100)+(1.96*(std(LatencyPr100)/sqrt(sn)));

CiDeliveryPrSan=[ciDeliveryPrSan10 ciDeliveryPrSan20 ciDeliveryPrSan30 ciDeliveryPrSan40 ciDeliveryPrSan50 ciDeliveryPrSan60 ciDeliveryPrSan70 ciDeliveryPrSan80 ciDeliveryPrSan90 ciDeliveryPrSan100];
CiDropPrSan=[ciDropPrSan10 ciDropPrSan20 ciDropPrSan30 ciDropPrSan40 ciDropPrSan50 ciDropPrSan60 ciDropPrSan70 ciDropPrSan80 ciDropPrSan90 ciDropPrSan100 ];
CiOverheadPrSan=[ciOverheadPrSan10 ciOverheadPrSan20 ciOverheadPrSan30 ciOverheadPrSan40 ciOverheadPrSan50 ciOverheadPrSan60 ciOverheadPrSan70 ciOverheadPrSan80 ciOverheadPrSan90 ciOverheadPrSan100];
CiLatencyPrSan=[LatencyPrSan10 LatencyPrSan20 LatencyPrSan30 LatencyPrSan40 LatencyPrSan50 LatencyPrSan60 LatencyPrSan70 LatencyPrSan80 LatencyPrSan90 LatencyPrSan100];
%%
%%
%Epidemic
DeliveryEp10=[SanEp(1,1) SanEp(11,1) SanEp(21,1) SanEp(31,1) SanEp(41,1)];
DropEp10=[SanEp(1,2) SanEp(11,2) SanEp(21,2) SanEp(31,2) SanEp(41,2)];
OverheadEp10=[SanEp(1,3) SanEp(11,3) SanEp(21,3) SanEp(31,3) SanEp(41,3)];
LatencyEp10=[SanEp(1,4) SanEp(11,4) SanEp(21,4) SanEp(31,4) SanEp(41,4)];

DeliveryEp20=[SanEp(2,1) SanEp(12,1) SanEp(22,1) SanEp(32,1) SanEp(42,1)];
DropEp20=[SanEp(2,2) SanEp(12,2) SanEp(22,2) SanEp(32,2) SanEp(42,2)];
OverheadEp20=[SanEp(2,3) SanEp(12,3) SanEp(22,3) SanEp(32,3) SanEp(42,3)];
LatencyEp20=[SanEp(2,4) SanEp(12,4) SanEp(22,4) SanEp(32,4) SanEp(42,4)];

DeliveryEp30=[SanEp(3,1) SanEp(13,1) SanEp(23,1) SanEp(33,1) SanEp(43,1)];
DropEp30=[SanEp(3,2) SanEp(13,2) SanEp(23,2) SanEp(33,2) SanEp(43,2)];
OverheadEp30=[SanEp(3,3) SanEp(13,3) SanEp(23,3) SanEp(33,3) SanEp(43,3)];
LatencyEp30=[SanEp(3,4) SanEp(13,4) SanEp(23,4) SanEp(33,4) SanEp(43,4)];

DeliveryEp40=[SanEp(4,1) SanEp(14,1) SanEp(24,1) SanEp(34,1) SanEp(44,1)];
DropEp40=[SanEp(4,2) SanEp(14,2) SanEp(24,2) SanEp(34,2) SanEp(44,2)];
OverheadEp40=[SanEp(4,3) SanEp(14,3) SanEp(24,3) SanEp(34,3) SanEp(44,3)];
LatencyEp40=[SanEp(4,4) SanEp(14,4) SanEp(24,4) SanEp(34,4) SanEp(44,4)];

DeliveryEp50=[SanEp(5,1) SanEp(15,1) SanEp(25,1) SanEp(35,1) SanEp(45,1)];
DropEp50=[SanEp(5,2) SanEp(15,2) SanEp(25,2) SanEp(35,2) SanEp(45,2)];
OverheadEp50=[SanEp(5,3) SanEp(15,3) SanEp(25,3) SanEp(35,3) SanEp(45,3)];
LatencyEp50=[SanEp(5,4) SanEp(15,4) SanEp(25,4) SanEp(35,4) SanEp(45,4)];

DeliveryEp60=[SanEp(6,1) SanEp(16,1) SanEp(26,1) SanEp(36,1) SanEp(46,1)];
DropEp60=[SanEp(6,2) SanEp(16,2) SanEp(26,2) SanEp(36,2) SanEp(46,2)];
OverheadEp60=[SanEp(6,3) SanEp(16,3) SanEp(26,3) SanEp(36,3) SanEp(46,3)];
LatencyEp60=[SanEp(6,4) SanEp(16,4) SanEp(26,4) SanEp(36,4) SanEp(46,4)];

DeliveryEp70=[SanEp(7,1) SanEp(17,1) SanEp(27,1) SanEp(37,1) SanEp(47,1)];
DropEp70=[SanEp(7,2) SanEp(17,2) SanEp(27,2) SanEp(37,2) SanEp(47,2)];
OverheadEp70=[SanEp(7,3) SanEp(17,3) SanEp(27,3) SanEp(37,3) SanEp(47,3)];
LatencyEp70=[SanEp(7,4) SanEp(17,4) SanEp(27,4) SanEp(37,4) SanEp(47,4)];

DeliveryEp80=[SanEp(8,1) SanEp(18,1) SanEp(28,1) SanEp(38,1) SanEp(48,1)];
DropEp80=[SanEp(8,2) SanEp(18,2) SanEp(28,2) SanEp(38,2) SanEp(48,2)];
OverheadEp80=[SanEp(8,3) SanEp(18,3) SanEp(28,3) SanEp(38,3) SanEp(48,3)];
LatencyEp80=[SanEp(8,4) SanEp(18,4) SanEp(28,4) SanEp(38,4) SanEp(48,4)];


DeliveryEp90=[SanEp(9,1) SanEp(19,1) SanEp(29,1) SanEp(39,1) SanEp(49,1)];
DropEp90=[SanEp(9,2) SanEp(19,2) SanEp(29,2) SanEp(39,2) SanEp(49,2)];
OverheadEp90=[SanEp(9,3) SanEp(19,3) SanEp(29,3) SanEp(39,3) SanEp(49,3)];
LatencyEp90=[SanEp(9,4) SanEp(19,4) SanEp(29,4) SanEp(39,4) SanEp(49,4)];

DeliveryEp100=[SanEp(10,1) SanEp(20,1) SanEp(30,1) SanEp(40,1) SanEp(50,1)];
DropEp100=[SanEp(10,2) SanEp(20,2) SanEp(30,2) SanEp(40,2) SanEp(50,2)];
OverheadEp100=[SanEp(10,3) SanEp(20,3) SanEp(30,3) SanEp(40,3) SanEp(50,3)];
LatencyEp100=[SanEp(10,4) SanEp(20,4) SanEp(30,4) SanEp(40,4) SanEp(50,4)];
%%%%%
ciDeliveryEpSan10=mean(DeliveryEp10)+(1.96*(std(DeliveryEp10)/sqrt(sn)));
ciDropEpSan10=mean(DropEp10)+(1.96*(std(DropEp10)/sqrt(sn)));
ciOverheadEpSan10=mean(OverheadEp10)+(1.96*(std(OverheadEp10)/sqrt(sn)));
LatencyEpSan10=mean(LatencyEp10)+(1.96*(std(LatencyEp10)/sqrt(sn)));

ciDeliveryEpSan20=mean(DeliveryEp20)+(1.96*(std(DeliveryEp20)/sqrt(sn)));
ciDropEpSan20=mean(DropEp20)+(1.96*(std(DropEp20)/sqrt(sn)));
ciOverheadEpSan20=mean(OverheadEp20)+(1.96*(std(OverheadEp20)/sqrt(sn)));
LatencyEpSan20=mean(LatencyEp20)+(1.96*(std(LatencyEp20)/sqrt(sn)));

ciDeliveryEpSan30=mean(DeliveryEp30)+(1.96*(std(DeliveryEp30)/sqrt(sn)));
ciDropEpSan30=mean(DropEp30)+(1.96*(std(DropEp30)/sqrt(sn)));
ciOverheadEpSan30=mean(OverheadEp30)+(1.96*(std(OverheadEp30)/sqrt(sn)));
LatencyEpSan30=mean(LatencyEp30)+(1.96*(std(LatencyEp30)/sqrt(sn)));

ciDeliveryEpSan40=mean(DeliveryEp40)+(1.96*(std(DeliveryEp40)/sqrt(sn)));
ciDropEpSan40=mean(DropEp40)+(1.96*(std(DropEp40)/sqrt(sn)));
ciOverheadEpSan40=mean(OverheadEp40)+(1.96*(std(OverheadEp40)/sqrt(sn)));
LatencyEpSan40=mean(LatencyEp40)+(1.96*(std(LatencyEp40)/sqrt(sn)));

ciDeliveryEpSan50=mean(DeliveryEp50)+(1.96*(std(DeliveryEp50)/sqrt(sn)));
ciDropEpSan50=mean(DropEp50)+(1.96*(std(DropEp50)/sqrt(sn)));
ciOverheadEpSan50=mean(OverheadEp50)+(1.96*(std(OverheadEp50)/sqrt(sn)));
LatencyEpSan50=mean(LatencyEp50)+(1.96*(std(LatencyEp50)/sqrt(sn)));

ciDeliveryEpSan60=mean(DeliveryEp60)+(1.96*(std(DeliveryEp60)/sqrt(sn)));
ciDropEpSan60=mean(DropEp60)+(1.96*(std(DropEp60)/sqrt(sn)));
ciOverheadEpSan60=mean(OverheadEp60)+(1.96*(std(OverheadEp60)/sqrt(sn)));
LatencyEpSan60=mean(LatencyEp60)+(1.96*(std(LatencyEp60)/sqrt(sn)));

ciDeliveryEpSan70=mean(DeliveryEp70)+(1.96*(std(DeliveryEp70)/sqrt(sn)));
ciDropEpSan70=mean(DropEp70)+(1.96*(std(DropEp70)/sqrt(sn)));
ciOverheadEpSan70=mean(OverheadEp70)+(1.96*(std(OverheadEp70)/sqrt(sn)));
LatencyEpSan70=mean(LatencyEp70)+(1.96*(std(LatencyEp70)/sqrt(sn)));

ciDeliveryEpSan80=mean(DeliveryEp80)+(1.96*(std(DeliveryEp80)/sqrt(sn)));
ciDropEpSan80=mean(DropEp80)+(1.96*(std(DropEp80)/sqrt(sn)));
ciOverheadEpSan80=mean(OverheadEp80)+(1.96*(std(OverheadEp80)/sqrt(sn)));
LatencyEpSan80=mean(LatencyEp80)+(1.96*(std(LatencyEp80)/sqrt(sn)));

ciDeliveryEpSan90=mean(DeliveryEp90)+(1.96*(std(DeliveryEp90)/sqrt(sn)));
ciDropEpSan90=mean(DropEp90)+(1.96*(std(DropEp90)/sqrt(sn)));
ciOverheadEpSan90=mean(OverheadEp90)+(1.96*(std(OverheadEp90)/sqrt(sn)));
LatencyEpSan90=mean(LatencyEp90)+(1.96*(std(LatencyEp90)/sqrt(sn)));

ciDeliveryEpSan100=mean(DeliveryEp100)+(1.96*(std(DeliveryEp100)/sqrt(sn)));
ciDropEpSan100=mean(DropEp100)+(1.96*(std(DropEp100)/sqrt(sn)));
ciOverheadEpSan100=mean(OverheadEp100)+(1.96*(std(OverheadEp100)/sqrt(sn)));
LatencyEpSan100=mean(LatencyEp100)+(1.96*(std(LatencyEp100)/sqrt(sn)));

CiDeliveryEpSan=[ciDeliveryEpSan10 ciDeliveryEpSan20 ciDeliveryEpSan30 ciDeliveryEpSan40 ciDeliveryEpSan50 ciDeliveryEpSan60 ciDeliveryEpSan70 ciDeliveryEpSan80 ciDeliveryEpSan90 ciDeliveryEpSan100];
CiDropEpSan=[ciDropEpSan10 ciDropEpSan20 ciDropEpSan30 ciDropEpSan40 ciDropEpSan50 ciDropEpSan60 ciDropEpSan70 ciDropEpSan80 ciDropEpSan90 ciDropEpSan100 ];
CiOverheadEpSan=[ciOverheadEpSan10 ciOverheadEpSan20 ciOverheadEpSan30 ciOverheadEpSan40 ciOverheadEpSan50 ciOverheadEpSan60 ciOverheadEpSan70 ciOverheadEpSan80 ciOverheadEpSan90 ciOverheadEpSan100];
CiLatencyEpSan=[LatencyEpSan10 LatencyEpSan20 LatencyEpSan30 LatencyEpSan40 LatencyEpSan50 LatencyEpSan60 LatencyEpSan70 LatencyEpSan80 LatencyEpSan90 LatencyEpSan100];
%%
%%
%First contact
DeliveryFC10=[SanFC(1,1) SanFC(11,1) SanFC(21,1) SanFC(31,1) SanFC(41,1)];
DropFC10=[SanFC(1,2) SanFC(11,2) SanFC(21,2) SanFC(31,2) SanFC(41,2)];
OverheadFC10=[SanFC(1,3) SanFC(11,3) SanFC(21,3) SanFC(31,3) SanFC(41,3)];
LatencyFC10=[SanFC(1,4) SanFC(11,4) SanFC(21,4) SanFC(31,4) SanFC(41,4)];

DeliveryFC20=[SanFC(2,1) SanFC(12,1) SanFC(22,1) SanFC(32,1) SanFC(42,1)];
DropFC20=[SanFC(2,2) SanFC(12,2) SanFC(22,2) SanFC(32,2) SanFC(42,2)];
OverheadFC20=[SanFC(2,3) SanFC(12,3) SanFC(22,3) SanFC(32,3) SanFC(42,3)];
LatencyFC20=[SanFC(2,4) SanFC(12,4) SanFC(22,4) SanFC(32,4) SanFC(42,4)];

DeliveryFC30=[SanFC(3,1) SanFC(13,1) SanFC(23,1) SanFC(33,1) SanFC(43,1)];
DropFC30=[SanFC(3,2) SanFC(13,2) SanFC(23,2) SanFC(33,2) SanFC(43,2)];
OverheadFC30=[SanFC(3,3) SanFC(13,3) SanFC(23,3) SanFC(33,3) SanFC(43,3)];
LatencyFC30=[SanFC(3,4) SanFC(13,4) SanFC(23,4) SanFC(33,4) SanFC(43,4)];

DeliveryFC40=[SanFC(4,1) SanFC(14,1) SanFC(24,1) SanFC(34,1) SanFC(44,1)];
DropFC40=[SanFC(4,2) SanFC(14,2) SanFC(24,2) SanFC(34,2) SanFC(44,2)];
OverheadFC40=[SanFC(4,3) SanFC(14,3) SanFC(24,3) SanFC(34,3) SanFC(44,3)];
LatencyFC40=[SanFC(4,4) SanFC(14,4) SanFC(24,4) SanFC(34,4) SanFC(44,4)];

DeliveryFC50=[SanFC(5,1) SanFC(15,1) SanFC(25,1) SanFC(35,1) SanFC(45,1)];
DropFC50=[SanFC(5,2) SanFC(15,2) SanFC(25,2) SanFC(35,2) SanFC(45,2)];
OverheadFC50=[SanFC(5,3) SanFC(15,3) SanFC(25,3) SanFC(35,3) SanFC(45,3)];
LatencyFC50=[SanFC(5,4) SanFC(15,4) SanFC(25,4) SanFC(35,4) SanFC(45,4)];

DeliveryFC60=[SanFC(6,1) SanFC(16,1) SanFC(26,1) SanFC(36,1) SanFC(46,1)];
DropFC60=[SanFC(6,2) SanFC(16,2) SanFC(26,2) SanFC(36,2) SanFC(46,2)];
OverheadFC60=[SanFC(6,3) SanFC(16,3) SanFC(26,3) SanFC(36,3) SanFC(46,3)];
LatencyFC60=[SanFC(6,4) SanFC(16,4) SanFC(26,4) SanFC(36,4) SanFC(46,4)];

DeliveryFC70=[SanFC(7,1) SanFC(17,1) SanFC(27,1) SanFC(37,1) SanFC(47,1)];
DropFC70=[SanFC(7,2) SanFC(17,2) SanFC(27,2) SanFC(37,2) SanFC(47,2)];
OverheadFC70=[SanFC(7,3) SanFC(17,3) SanFC(27,3) SanFC(37,3) SanFC(47,3)];
LatencyFC70=[SanFC(7,4) SanFC(17,4) SanFC(27,4) SanFC(37,4) SanFC(47,4)];

DeliveryFC80=[SanFC(8,1) SanFC(18,1) SanFC(28,1) SanFC(38,1) SanFC(48,1)];
DropFC80=[SanFC(8,2) SanFC(18,2) SanFC(28,2) SanFC(38,2) SanFC(48,2)];
OverheadFC80=[SanFC(8,3) SanFC(18,3) SanFC(28,3) SanFC(38,3) SanFC(48,3)];
LatencyFC80=[SanFC(8,4) SanFC(18,4) SanFC(28,4) SanFC(38,4) SanFC(48,4)];


DeliveryFC90=[SanFC(9,1) SanFC(19,1) SanFC(29,1) SanFC(39,1) SanFC(49,1)];
DropFC90=[SanFC(9,2) SanFC(19,2) SanFC(29,2) SanFC(39,2) SanFC(49,2)];
OverheadFC90=[SanFC(9,3) SanFC(19,3) SanFC(29,3) SanFC(39,3) SanFC(49,3)];
LatencyFC90=[SanFC(9,4) SanFC(19,4) SanFC(29,4) SanFC(39,4) SanFC(49,4)];

DeliveryFC100=[SanFC(10,1) SanFC(20,1) SanFC(30,1) SanFC(40,1) SanFC(50,1)];
DropFC100=[SanFC(10,2) SanFC(20,2) SanFC(30,2) SanFC(40,2) SanFC(50,2)];
OverheadFC100=[SanFC(10,3) SanFC(20,3) SanFC(30,3) SanFC(40,3) SanFC(50,3)];
LatencyFC100=[SanFC(10,4) SanFC(20,4) SanFC(30,4) SanFC(40,4) SanFC(50,4)];
%%%%%
ciDeliveryFCSan10=mean(DeliveryFC10)+(1.96*(std(DeliveryFC10)/sqrt(sn)));
ciDropFCSan10=mean(DropFC10)+(1.96*(std(DropFC10)/sqrt(sn)));
ciOverheadFCSan10=mean(OverheadFC10)+(1.96*(std(OverheadFC10)/sqrt(sn)));
LatencyFCSan10=mean(LatencyFC10)+(1.96*(std(LatencyFC10)/sqrt(sn)));

ciDeliveryFCSan20=mean(DeliveryFC20)+(1.96*(std(DeliveryFC20)/sqrt(sn)));
ciDropFCSan20=mean(DropFC20)+(1.96*(std(DropFC20)/sqrt(sn)));
ciOverheadFCSan20=mean(OverheadFC20)+(1.96*(std(OverheadFC20)/sqrt(sn)));
LatencyFCSan20=mean(LatencyFC20)+(1.96*(std(LatencyFC20)/sqrt(sn)));

ciDeliveryFCSan30=mean(DeliveryFC30)+(1.96*(std(DeliveryFC30)/sqrt(sn)));
ciDropFCSan30=mean(DropFC30)+(1.96*(std(DropFC30)/sqrt(sn)));
ciOverheadFCSan30=mean(OverheadFC30)+(1.96*(std(OverheadFC30)/sqrt(sn)));
LatencyFCSan30=mean(LatencyFC30)+(1.96*(std(LatencyFC30)/sqrt(sn)));

ciDeliveryFCSan40=mean(DeliveryFC40)+(1.96*(std(DeliveryFC40)/sqrt(sn)));
ciDropFCSan40=mean(DropFC40)+(1.96*(std(DropFC40)/sqrt(sn)));
ciOverheadFCSan40=mean(OverheadFC40)+(1.96*(std(OverheadFC40)/sqrt(sn)));
LatencyFCSan40=mean(LatencyFC40)+(1.96*(std(LatencyFC40)/sqrt(sn)));

ciDeliveryFCSan50=mean(DeliveryFC50)+(1.96*(std(DeliveryFC50)/sqrt(sn)));
ciDropFCSan50=mean(DropFC50)+(1.96*(std(DropFC50)/sqrt(sn)));
ciOverheadFCSan50=mean(OverheadFC50)+(1.96*(std(OverheadFC50)/sqrt(sn)));
LatencyFCSan50=mean(LatencyFC50)+(1.96*(std(LatencyFC50)/sqrt(sn)));

ciDeliveryFCSan60=mean(DeliveryFC60)+(1.96*(std(DeliveryFC60)/sqrt(sn)));
ciDropFCSan60=mean(DropFC60)+(1.96*(std(DropFC60)/sqrt(sn)));
ciOverheadFCSan60=mean(OverheadFC60)+(1.96*(std(OverheadFC60)/sqrt(sn)));
LatencyFCSan60=mean(LatencyFC60)+(1.96*(std(LatencyFC60)/sqrt(sn)));

ciDeliveryFCSan70=mean(DeliveryFC70)+(1.96*(std(DeliveryFC70)/sqrt(sn)));
ciDropFCSan70=mean(DropFC70)+(1.96*(std(DropFC70)/sqrt(sn)));
ciOverheadFCSan70=mean(OverheadFC70)+(1.96*(std(OverheadFC70)/sqrt(sn)));
LatencyFCSan70=mean(LatencyFC70)+(1.96*(std(LatencyFC70)/sqrt(sn)));

ciDeliveryFCSan80=mean(DeliveryFC80)+(1.96*(std(DeliveryFC80)/sqrt(sn)));
ciDropFCSan80=mean(DropFC80)+(1.96*(std(DropFC80)/sqrt(sn)));
ciOverheadFCSan80=mean(OverheadFC80)+(1.96*(std(OverheadFC80)/sqrt(sn)));
LatencyFCSan80=mean(LatencyFC80)+(1.96*(std(LatencyFC80)/sqrt(sn)));

ciDeliveryFCSan90=mean(DeliveryFC90)+(1.96*(std(DeliveryFC90)/sqrt(sn)));
ciDropFCSan90=mean(DropFC90)+(1.96*(std(DropFC90)/sqrt(sn)));
ciOverheadFCSan90=mean(OverheadFC90)+(1.96*(std(OverheadFC90)/sqrt(sn)));
LatencyFCSan90=mean(LatencyFC90)+(1.96*(std(LatencyFC90)/sqrt(sn)));

ciDeliveryFCSan100=mean(DeliveryFC100)+(1.96*(std(DeliveryFC100)/sqrt(sn)));
ciDropFCSan100=mean(DropFC100)+(1.96*(std(DropFC100)/sqrt(sn)));
ciOverheadFCSan100=mean(OverheadFC100)+(1.96*(std(OverheadFC100)/sqrt(sn)));
LatencyFCSan100=mean(LatencyFC100)+(1.96*(std(LatencyFC100)/sqrt(sn)));

CiDeliveryFCSan=[ciDeliveryFCSan10 ciDeliveryFCSan20 ciDeliveryFCSan30 ciDeliveryFCSan40 ciDeliveryFCSan50 ciDeliveryFCSan60 ciDeliveryFCSan70 ciDeliveryFCSan80 ciDeliveryFCSan90 ciDeliveryFCSan100];
CiDropFCSan=[ciDropFCSan10 ciDropFCSan20 ciDropFCSan30 ciDropFCSan40 ciDropFCSan50 ciDropFCSan60 ciDropFCSan70 ciDropFCSan80 ciDropFCSan90 ciDropFCSan100 ];
CiOverheadFCSan=[ciOverheadFCSan10 ciOverheadFCSan20 ciOverheadFCSan30 ciOverheadFCSan40 ciOverheadFCSan50 ciOverheadFCSan60 ciOverheadFCSan70 ciOverheadFCSan80 ciOverheadFCSan90 ciOverheadFCSan100];
CiLatencyFCSan=[LatencyFCSan10 LatencyFCSan20 LatencyFCSan30 LatencyFCSan40 LatencyFCSan50 LatencyFCSan60 LatencyFCSan70 LatencyFCSan80 LatencyFCSan90 LatencyFCSan100];
%%
figure
plot(Nodes,CiDeliveryBLSan,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiDeliveryFCSan,'-*','LineWidth',1.5)
hold on
plot(Nodes,CiDeliveryEpSan,'-x','LineWidth',1.5)
hold on
plot(Nodes,CiDeliveryPrSan,'-o','LineWidth',1.5)




set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Delivery (Venice)')
xlabel('Nodes') % x-axis label
ylabel('Messages Delivery') % y-axis label
legend('Bloosom', 'First Contact', 'Epidemic', 'PRoPHET', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
  grid on
  %%
figure
plot(Nodes,CiDropBlSan,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiDropFCSan,'-*','LineWidth',1.5)
hold on
plot(Nodes,CiDropEpSan,'-x','LineWidth',1.5)
hold on
plot(Nodes,CiDropPrSan,'-o','LineWidth',1.5)




set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Dropped Messages (Venice)')
xlabel('Nodes') % x-axis label
ylabel('Dropped Messages') % y-axis label
legend('Blossom', 'First Contact', 'Epidemic', 'PRoPHET', 'Location', 'best', 'FontSize',15)

 %xlim([1100 336])
  grid on
  %%
figure
plot(Nodes,CiOverheadBlSan,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiOverheadFCSan,'-*','LineWidth',1.5)
hold on
plot(Nodes,CiOverheadEpSan,'-x','LineWidth',1.5)
hold on
plot(Nodes,CiOverheadPrSan,'-o','LineWidth',1.5)




set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Network Overhead (Venice)')
xlabel('Nodes') % x-axis label
ylabel('Network Overhead') % y-axis label
legend('Blossom', 'First Contact', 'Epidemic', 'PRoPHET', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
  grid on
  %%
figure
plot(Nodes,CiLatencyBlSan,'-<','LineWidth',1.5)
hold on
plot(Nodes,CiLatencyFCSan,'-*','LineWidth',1.5)
hold on
plot(Nodes,CiLatencyEpSan,'-x','LineWidth',1.5)
hold on
plot(Nodes,CiLatencyPrSan,'-o','LineWidth',1.5)




set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Latency (Venice)')
xlabel('Nodes') % x-axis label
ylabel('Messages Latency') % y-axis label
legend('Blossom', 'First Contact', 'Epidemic', 'PRoPHET', 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
  grid on