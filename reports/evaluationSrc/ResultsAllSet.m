clc
clear all
close all

format longg

sn=5;  %number of repeat (seeds)

Nodes=[10 20 30 40 50 60 70 80 90 100];
SanFranciscoAll = importdata('SanFranAllSettings.csv');
% SanFrancisco= importdata('SanFranBestSimulation.csv');

% VeniceAll= importdata('SanFranAllSettings.csv');
% Venice= importdata('SanFranBestSimulation.csv');

[rs cs]=size(SanFranciscoAll.data);
% [rv cv]=size(Venice);


% 1:Delivery Probability, 2:Messages drop, 3: Overhead, 4:Latency
San(:,1)=str2double(SanFranciscoAll.textdata(:,2));
San(:,2)=str2double(SanFranciscoAll.textdata(:,3));
San(:,3)=str2double(SanFranciscoAll.textdata(:,4));
San(:,4)=str2double(SanFranciscoAll.textdata(:,5));
San(1,:)=[];
San(:,5)=(SanFranciscoAll.data(:,1));

Set1=1;
Set2=1;
Set3=1;
Set4=1;
Set5=1;
Set6=1;
Set7=1;
Set8=1;
Set9=1;
Set10=1;
Set11=1;
Set12=1;
PrC=1;
FcC=1;
EpC=1;

for i=2:rs+1
    x=string(SanFranciscoAll.textdata(i,6));
   % switch x
        if contains(x,"0.1H0.0S0.8A (1)")
            SanSet1(Set1,:)=San(i-1,:);
            Set1=Set1+1;
          %  break;
        end
        if contains(x,"0.1H0.0S1A (2)")
            SanSet2(Set2,:)=San(i-1,:);
            Set2=Set2+1;
          %  break;
        end
        if contains(x,"0.1H10000.0S0.8A (3)")
            SanSet3(Set3,:)=San(i-1,:);
            Set3=Set3+1;
          %  break;
        end
        if contains(x,"0.1H10000.0S1A (4)")
            SanSet4(Set4,:)=San(i-1,:);
            Set4=Set4+1;
          %  break;
        end
        if contains(x,"0.1H20000.0S0.8A (5)")
            SanSet5(Set5,:)=San(i-1,:);
            Set5=Set5+1;
          %  break;
        end
        if contains(x,"0.1H20000.0S1A (6)")
            SanSet6(Set6,:)=San(i-1,:);
            Set6=Set6+1;
          %  break;
        end
        if contains(x,"0.2H0.0S0.8A (7)")
            SanSet7(Set7,:)=San(i-1,:);
            Set7=Set7+1;
          %  break;
        end
        if contains(x,"0.2H0.0S1A (8)")
            SanSet8(Set8,:)=San(i-1,:);
            Set8=Set8+1;
          %  break;
        end
        if contains(x,"0.2H10000.0S0.8A (9)")
            SanSet9(Set9,:)=San(i-1,:);
            Set9=Set9+1;
          %  break;
        end
        if contains(x,"0.2H10000.0S1A (10)")
            SanSet10(Set10,:)=San(i-1,:);
            Set10=Set10+1;
          %  break;
        end
        if contains(x,"0.2H20000.0S0.8A (11)")
            SanSet11(Set11,:)=San(i-1,:);
            Set11=Set11+1;
          %  break;
        end
        if contains(x,"0.2H20000.0S1A (12)")
            SanSet12(Set12,:)=San(i-1,:);
            Set12=Set12+1;
          %  break;
        end
        if contains(x,"PRoPHET") %x=='PRoPHET'
             SanPr(PrC,:)=San(i-1,:);
             PrC=PrC+1;
          %   break;
        end
        if contains(x,"Fist Contact") %x=='FirstContact'
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
%Set1
DeliverySet110=SanSet1(1,1); 
DropSet110=SanSet1(1,2);
OverheadSet110=SanSet1(1,3);
LatencySet110=SanSet1(1,4);

DeliverySet120=SanSet1(2,1);
DropSet120=SanSet1(2,2);
OverheadSet120=SanSet1(2,3);
LatencySet120=SanSet1(2,4);

DeliverySet130=SanSet1(3,1);
DropSet130=SanSet1(3,2);
OverheadSet130=SanSet1(3,3);
LatencySet130=SanSet1(3,4);

DeliverySet140=SanSet1(4,1);
DropSet140=SanSet1(4,2);
OverheadSet140=SanSet1(4,3);
LatencySet140=SanSet1(4,4);

DeliverySet150=SanSet1(5,1);
DropSet150=SanSet1(5,2);
OverheadSet150=SanSet1(5,3);
LatencySet150=SanSet1(5,4);

DeliverySet160=SanSet1(6,1);
DropSet160=SanSet1(6,2);
OverheadSet160=SanSet1(6,3);
LatencySet160=SanSet1(6,4);

DeliverySet170=SanSet1(7,1);
DropSet170=SanSet1(7,2);
OverheadSet170=SanSet1(7,3);
LatencySet170=SanSet1(7,4);

DeliverySet180=SanSet1(8,1);
DropSet180=SanSet1(8,2);
OverheadSet180=SanSet1(8,3);
LatencySet180=SanSet1(8,4);

DeliverySet190=SanSet1(9,1);
DropSet190=SanSet1(9,2);
OverheadSet190=SanSet1(9,3);
LatencySet190=SanSet1(9,4);

DeliverySet1100=SanSet1(10,1);
DropSet1100=SanSet1(10,2);
OverheadSet1100=SanSet1(10,3);
LatencySet1100=SanSet1(10,4);

DeliverySet1=[DeliverySet110 DeliverySet120 DeliverySet130 DeliverySet140 DeliverySet150 DeliverySet160 DeliverySet170 DeliverySet180 DeliverySet190 DeliverySet1100];
DropSet1=[DropSet110 DropSet120 DropSet130 DropSet140 DropSet150 DropSet160 DropSet170 DropSet180 DropSet190 DropSet1100 ];
OverheadSet1=[OverheadSet110 OverheadSet120 OverheadSet130 OverheadSet140 OverheadSet150 OverheadSet160 OverheadSet170 OverheadSet180 OverheadSet190 OverheadSet1100];
LatencySet1=[LatencySet110 LatencySet120 LatencySet130 LatencySet140 LatencySet150 LatencySet160 LatencySet170 LatencySet180 LatencySet190 LatencySet1100];
%%
%%
%Set2
DeliverySet210=SanSet2(1,1);
DropSet210=SanSet2(1,2);
OverheadSet210=SanSet2(1,3);
LatencySet210=SanSet2(1,4);

DeliverySet220=SanSet2(2,1);
DropSet220=SanSet2(2,2);
OverheadSet220=SanSet2(2,3);
LatencySet220=SanSet2(2,4);

DeliverySet230=SanSet2(3,1);
DropSet230=SanSet2(3,2);
OverheadSet230=SanSet2(3,3);
LatencySet230=SanSet2(3,4);

DeliverySet240=SanSet2(4,1);
DropSet240=SanSet2(4,2);
OverheadSet240=SanSet2(4,3);
LatencySet240=SanSet2(4,4);

DeliverySet250=SanSet2(5,1);
DropSet250=SanSet2(5,2);
OverheadSet250=SanSet2(5,3);
LatencySet250=SanSet2(5,4);

DeliverySet260=SanSet2(6,1);
DropSet260=SanSet2(6,2);
OverheadSet260=SanSet2(6,3);
LatencySet260=SanSet2(6,4);

DeliverySet270=SanSet2(7,1);
DropSet270=SanSet2(7,2);
OverheadSet270=SanSet2(7,3);
LatencySet270=SanSet2(7,4);

DeliverySet280=SanSet2(8,1);
DropSet280=SanSet2(8,2);
OverheadSet280=SanSet2(8,3);
LatencySet280=SanSet2(8,4);

DeliverySet290=SanSet2(9,1);
DropSet290=SanSet2(9,2);
OverheadSet290=SanSet2(9,3);
LatencySet290=SanSet2(9,4);

DeliverySet2100=SanSet2(10,1);
DropSet2100=SanSet2(10,2);
OverheadSet2100=SanSet2(10,3);
LatencySet2100=SanSet2(10,4);

DeliverySet2=[DeliverySet210 DeliverySet220 DeliverySet230 DeliverySet240 DeliverySet250 DeliverySet260 DeliverySet270 DeliverySet280 DeliverySet290 DeliverySet2100];
DropSet2=[DropSet210 DropSet220 DropSet230 DropSet240 DropSet250 DropSet260 DropSet270 DropSet280 DropSet290 DropSet2100 ];
OverheadSet2=[OverheadSet210 OverheadSet220 OverheadSet230 OverheadSet240 OverheadSet250 OverheadSet260 OverheadSet270 OverheadSet280 OverheadSet290 OverheadSet2100];
LatencySet2=[LatencySet210 LatencySet220 LatencySet230 LatencySet240 LatencySet250 LatencySet260 LatencySet270 LatencySet280 LatencySet290 LatencySet2100];
%
%%
%Set3
DeliverySet310=SanSet3(1,1);
DropSet310=SanSet3(1,2);
OverheadSet310=SanSet3(1,3);
LatencySet310=SanSet3(1,4);

DeliverySet320=SanSet3(2,1);
DropSet320=SanSet3(2,2);
OverheadSet320=SanSet3(2,3);
LatencySet320=SanSet3(2,4);

DeliverySet330=SanSet3(3,1);
DropSet330=SanSet3(3,2);
OverheadSet330=SanSet3(3,3);
LatencySet330=SanSet3(3,4);

DeliverySet340=SanSet3(4,1);
DropSet340=SanSet3(4,2);
OverheadSet340=SanSet3(4,3);
LatencySet340=SanSet3(4,4);

DeliverySet350=SanSet3(5,1);
DropSet350=SanSet3(5,2);
OverheadSet350=SanSet3(5,3);
LatencySet350=SanSet3(5,4);

DeliverySet360=SanSet3(6,1);
DropSet360=SanSet3(6,2);
OverheadSet360=SanSet3(6,3);
LatencySet360=SanSet3(6,4);

DeliverySet370=SanSet3(7,1);
DropSet370=SanSet3(7,2);
OverheadSet370=SanSet3(7,3);
LatencySet370=SanSet3(7,4);

DeliverySet380=SanSet3(8,1);
DropSet380=SanSet3(8,2);
OverheadSet380=SanSet3(8,3);
LatencySet380=SanSet3(8,4);

DeliverySet390=SanSet3(9,1);
DropSet390=SanSet3(9,2);
OverheadSet390=SanSet3(9,3);
LatencySet390=SanSet3(9,4);

DeliverySet3100=SanSet3(10,1);
DropSet3100=SanSet3(10,2);
OverheadSet3100=SanSet3(10,3);
LatencySet3100=SanSet3(10,4);

DeliverySet3=[DeliverySet310 DeliverySet320 DeliverySet330 DeliverySet340 DeliverySet350 DeliverySet360 DeliverySet370 DeliverySet380 DeliverySet390 DeliverySet3100];
DropSet3=[DropSet310 DropSet320 DropSet330 DropSet340 DropSet350 DropSet360 DropSet370 DropSet380 DropSet390 DropSet3100 ];
OverheadSet3=[OverheadSet310 OverheadSet320 OverheadSet330 OverheadSet340 OverheadSet350 OverheadSet360 OverheadSet370 OverheadSet380 OverheadSet390 OverheadSet3100];
LatencySet3=[LatencySet310 LatencySet320 LatencySet330 LatencySet340 LatencySet350 LatencySet360 LatencySet370 LatencySet380 LatencySet390 LatencySet3100];

%
%%
%Set4
DeliverySet410=SanSet4(1,1);
DropSet410=SanSet4(1,2);
OverheadSet410=SanSet4(1,3);
LatencySet410=SanSet4(1,4);

DeliverySet420=SanSet4(2,1);
DropSet420=SanSet4(2,2);
OverheadSet420=SanSet4(2,3);
LatencySet420=SanSet4(2,4);

DeliverySet430=SanSet4(3,1);
DropSet430=SanSet4(3,2);
OverheadSet430=SanSet4(3,3);
LatencySet430=SanSet4(3,4);

DeliverySet440=SanSet4(4,1);
DropSet440=SanSet4(4,2);
OverheadSet440=SanSet4(4,3);
LatencySet440=SanSet4(4,4);

DeliverySet450=SanSet4(5,1);
DropSet450=SanSet4(5,2);
OverheadSet450=SanSet4(5,3);
LatencySet450=SanSet4(5,4);

DeliverySet460=SanSet4(6,1);
DropSet460=SanSet4(6,2);
OverheadSet460=SanSet4(6,3);
LatencySet460=SanSet4(6,4);

DeliverySet470=SanSet4(7,1);
DropSet470=SanSet4(7,2);
OverheadSet470=SanSet4(7,3);
LatencySet470=SanSet4(7,4);

DeliverySet480=SanSet4(8,1);
DropSet480=SanSet4(8,2);
OverheadSet480=SanSet4(8,3);
LatencySet480=SanSet4(8,4);

DeliverySet490=SanSet4(9,1);
DropSet490=SanSet4(9,2);
OverheadSet490=SanSet4(9,3);
LatencySet490=SanSet4(9,4);

DeliverySet4100=SanSet4(10,1);
DropSet4100=SanSet4(10,2);
OverheadSet4100=SanSet4(10,3);
LatencySet4100=SanSet4(10,4);

DeliverySet4=[DeliverySet410 DeliverySet420 DeliverySet430 DeliverySet440 DeliverySet450 DeliverySet460 DeliverySet470 DeliverySet480 DeliverySet490 DeliverySet4100];
DropSet4=[DropSet410 DropSet420 DropSet430 DropSet440 DropSet450 DropSet460 DropSet470 DropSet480 DropSet490 DropSet4100 ];
OverheadSet4=[OverheadSet410 OverheadSet420 OverheadSet430 OverheadSet440 OverheadSet450 OverheadSet460 OverheadSet470 OverheadSet480 OverheadSet490 OverheadSet4100];
LatencySet4=[LatencySet410 LatencySet420 LatencySet430 LatencySet440 LatencySet450 LatencySet460 LatencySet470 LatencySet480 LatencySet490 LatencySet4100];
%
%%
%Set5
DeliverySet510=SanSet5(1,1);
DropSet510=SanSet5(1,2);
OverheadSet510=SanSet5(1,3);
LatencySet510=SanSet5(1,4);

DeliverySet520=SanSet5(2,1);
DropSet520=SanSet5(2,2);
OverheadSet520=SanSet5(2,3);
LatencySet520=SanSet5(2,4);

DeliverySet530=SanSet5(3,1);
DropSet530=SanSet5(3,2);
OverheadSet530=SanSet5(3,3);
LatencySet530=SanSet5(3,4);

DeliverySet540=SanSet5(4,1);
DropSet540=SanSet5(4,2);
OverheadSet540=SanSet5(4,3);
LatencySet540=SanSet5(4,4);

DeliverySet550=SanSet5(5,1);
DropSet550=SanSet5(5,2);
OverheadSet550=SanSet5(5,3);
LatencySet550=SanSet5(5,4);

DeliverySet560=SanSet5(6,1);
DropSet560=SanSet5(6,2);
OverheadSet560=SanSet5(6,3);
LatencySet560=SanSet5(6,4);

DeliverySet570=SanSet5(7,1);
DropSet570=SanSet5(7,2);
OverheadSet570=SanSet5(7,3);
LatencySet570=SanSet5(7,4);

DeliverySet580=SanSet5(8,1);
DropSet580=SanSet5(8,2);
OverheadSet580=SanSet5(8,3);
LatencySet580=SanSet5(8,4);

DeliverySet590=SanSet5(9,1);
DropSet590=SanSet5(9,2);
OverheadSet590=SanSet5(9,3);
LatencySet590=SanSet5(9,4);

DeliverySet5100=SanSet5(10,1);
DropSet5100=SanSet5(10,2);
OverheadSet5100=SanSet5(10,3);
LatencySet5100=SanSet5(10,4);

DeliverySet5=[DeliverySet510 DeliverySet520 DeliverySet530 DeliverySet540 DeliverySet550 DeliverySet560 DeliverySet570 DeliverySet580 DeliverySet590 DeliverySet5100];
DropSet5=[DropSet510 DropSet520 DropSet530 DropSet540 DropSet550 DropSet560 DropSet570 DropSet580 DropSet590 DropSet5100 ];
OverheadSet5=[OverheadSet510 OverheadSet520 OverheadSet530 OverheadSet540 OverheadSet550 OverheadSet560 OverheadSet570 OverheadSet580 OverheadSet590 OverheadSet5100];
LatencySet5=[LatencySet510 LatencySet520 LatencySet530 LatencySet540 LatencySet550 LatencySet560 LatencySet570 LatencySet580 LatencySet590 LatencySet5100];

%
%%
%Set6
%

DeliverySet610=SanSet6(1,1);
DropSet610=SanSet6(1,2);
OverheadSet610=SanSet6(1,3);
LatencySet610=SanSet6(1,4);

DeliverySet620=SanSet6(2,1);
DropSet620=SanSet6(2,2);
OverheadSet620=SanSet6(2,3);
LatencySet620=SanSet6(2,4);

DeliverySet630=SanSet6(3,1);
DropSet630=SanSet6(3,2);
OverheadSet630=SanSet6(3,3);
LatencySet630=SanSet6(3,4);

DeliverySet640=SanSet6(4,1);
DropSet640=SanSet6(4,2);
OverheadSet640=SanSet6(4,3);
LatencySet640=SanSet6(4,4);

DeliverySet650=SanSet6(5,1);
DropSet650=SanSet6(5,2);
OverheadSet650=SanSet6(5,3);
LatencySet650=SanSet6(5,4);

DeliverySet660=SanSet6(6,1);
DropSet660=SanSet6(6,2);
OverheadSet660=SanSet6(6,3);
LatencySet660=SanSet6(6,4);

DeliverySet670=SanSet6(7,1);
DropSet670=SanSet6(7,2);
OverheadSet670=SanSet6(7,3);
LatencySet670=SanSet6(7,4);

DeliverySet680=SanSet6(8,1);
DropSet680=SanSet6(8,2);
OverheadSet680=SanSet6(8,3);
LatencySet680=SanSet6(8,4);

DeliverySet690=SanSet6(9,1);
DropSet690=SanSet6(9,2);
OverheadSet690=SanSet6(9,3);
LatencySet690=SanSet6(9,4);

DeliverySet6100=SanSet6(10,1);
DropSet6100=SanSet6(10,2);
OverheadSet6100=SanSet6(10,3);
LatencySet6100=SanSet6(10,4);

DeliverySet6=[DeliverySet610 DeliverySet620 DeliverySet630 DeliverySet640 DeliverySet650 DeliverySet660 DeliverySet670 DeliverySet680 DeliverySet690 DeliverySet6100];
DropSet6=[DropSet610 DropSet620 DropSet630 DropSet640 DropSet650 DropSet660 DropSet670 DropSet680 DropSet690 DropSet6100 ];
OverheadSet6=[OverheadSet610 OverheadSet620 OverheadSet630 OverheadSet640 OverheadSet650 OverheadSet660 OverheadSet670 OverheadSet680 OverheadSet690 OverheadSet6100];
LatencySet6=[LatencySet610 LatencySet620 LatencySet630 LatencySet640 LatencySet650 LatencySet660 LatencySet670 LatencySet680 LatencySet690 LatencySet6100];

%
%%
%Set7

DeliverySet710=SanSet7(1,1);
DropSet710=SanSet7(1,2);
OverheadSet710=SanSet7(1,3);
LatencySet710=SanSet7(1,4);

DeliverySet720=SanSet7(2,1);
DropSet720=SanSet7(2,2);
OverheadSet720=SanSet7(2,3);
LatencySet720=SanSet7(2,4);

DeliverySet730=SanSet7(3,1);
DropSet730=SanSet7(3,2);
OverheadSet730=SanSet7(3,3);
LatencySet730=SanSet7(3,4);

DeliverySet740=SanSet7(4,1);
DropSet740=SanSet7(4,2);
OverheadSet740=SanSet7(4,3);
LatencySet740=SanSet7(4,4);

DeliverySet750=SanSet7(5,1);
DropSet750=SanSet7(5,2);
OverheadSet750=SanSet7(5,3);
LatencySet750=SanSet7(5,4);

DeliverySet760=SanSet7(6,1);
DropSet760=SanSet7(6,2);
OverheadSet760=SanSet7(6,3);
LatencySet760=SanSet7(6,4);

DeliverySet770=SanSet7(7,1);
DropSet770=SanSet7(7,2);
OverheadSet770=SanSet7(7,3);
LatencySet770=SanSet7(7,4);

DeliverySet780=SanSet7(8,1);
DropSet780=SanSet7(8,2);
OverheadSet780=SanSet7(8,3);
LatencySet780=SanSet7(8,4);

DeliverySet790=SanSet7(9,1);
DropSet790=SanSet7(9,2);
OverheadSet790=SanSet7(9,3);
LatencySet790=SanSet7(9,4);

DeliverySet7100=SanSet7(10,1);
DropSet7100=SanSet7(10,2);
OverheadSet7100=SanSet7(10,3);
LatencySet7100=SanSet7(10,4);

DeliverySet7=[DeliverySet710 DeliverySet720 DeliverySet730 DeliverySet740 DeliverySet750 DeliverySet760 DeliverySet770 DeliverySet780 DeliverySet790 DeliverySet7100];
DropSet7=[DropSet710 DropSet720 DropSet730 DropSet740 DropSet750 DropSet760 DropSet770 DropSet780 DropSet790 DropSet7100 ];
OverheadSet7=[OverheadSet710 OverheadSet720 OverheadSet730 OverheadSet740 OverheadSet750 OverheadSet760 OverheadSet770 OverheadSet780 OverheadSet790 OverheadSet7100];
LatencySet7=[LatencySet710 LatencySet720 LatencySet730 LatencySet740 LatencySet750 LatencySet760 LatencySet770 LatencySet780 LatencySet790 LatencySet7100];

%
%%
%Set8

DeliverySet810=SanSet8(1,1);
DropSet810=SanSet8(1,2);
OverheadSet810=SanSet8(1,3);
LatencySet810=SanSet8(1,4);

DeliverySet820=SanSet8(2,1);
DropSet820=SanSet8(2,2);
OverheadSet820=SanSet8(2,3);
LatencySet820=SanSet8(2,4);

DeliverySet830=SanSet8(3,1);
DropSet830=SanSet8(3,2);
OverheadSet830=SanSet8(3,3);
LatencySet830=SanSet8(3,4);

DeliverySet840=SanSet8(4,1);
DropSet840=SanSet8(4,2);
OverheadSet840=SanSet8(4,3);
LatencySet840=SanSet8(4,4);

DeliverySet850=SanSet8(5,1);
DropSet850=SanSet8(5,2);
OverheadSet850=SanSet8(5,3);
LatencySet850=SanSet8(5,4);

DeliverySet860=SanSet8(6,1);
DropSet860=SanSet8(6,2);
OverheadSet860=SanSet8(6,3);
LatencySet860=SanSet8(6,4);

DeliverySet870=SanSet8(7,1);
DropSet870=SanSet8(7,2);
OverheadSet870=SanSet8(7,3);
LatencySet870=SanSet8(7,4);

DeliverySet880=SanSet8(8,1);
DropSet880=SanSet8(8,2);
OverheadSet880=SanSet8(8,3);
LatencySet880=SanSet8(8,4);

DeliverySet890=SanSet8(9,1);
DropSet890=SanSet8(9,2);
OverheadSet890=SanSet8(9,3);
LatencySet890=SanSet8(9,4);

DeliverySet8100=SanSet8(10,1);
DropSet8100=SanSet8(10,2);
OverheadSet8100=SanSet8(10,3);
LatencySet8100=SanSet8(10,4);

DeliverySet8=[DeliverySet810 DeliverySet820 DeliverySet830 DeliverySet840 DeliverySet850 DeliverySet860 DeliverySet870 DeliverySet880 DeliverySet890 DeliverySet8100];
DropSet8=[DropSet810 DropSet820 DropSet830 DropSet840 DropSet850 DropSet860 DropSet870 DropSet880 DropSet890 DropSet8100 ];
OverheadSet8=[OverheadSet810 OverheadSet820 OverheadSet830 OverheadSet840 OverheadSet850 OverheadSet860 OverheadSet870 OverheadSet880 OverheadSet890 OverheadSet8100];
LatencySet8=[LatencySet810 LatencySet820 LatencySet830 LatencySet840 LatencySet850 LatencySet860 LatencySet870 LatencySet880 LatencySet890 LatencySet8100];

%
%%
%Set9

DeliverySet910=SanSet9(1,1);
DropSet910=SanSet9(1,2);
OverheadSet910=SanSet9(1,3);
LatencySet910=SanSet9(1,4);

DeliverySet920=SanSet9(2,1);
DropSet920=SanSet9(2,2);
OverheadSet920=SanSet9(2,3);
LatencySet920=SanSet9(2,4);

DeliverySet930=SanSet9(3,1);
DropSet930=SanSet9(3,2);
OverheadSet930=SanSet9(3,3);
LatencySet930=SanSet9(3,4);

DeliverySet940=SanSet9(4,1);
DropSet940=SanSet9(4,2);
OverheadSet940=SanSet9(4,3);
LatencySet940=SanSet9(4,4);

DeliverySet950=SanSet9(5,1);
DropSet950=SanSet9(5,2);
OverheadSet950=SanSet9(5,3);
LatencySet950=SanSet9(5,4);

DeliverySet960=SanSet9(6,1);
DropSet960=SanSet9(6,2);
OverheadSet960=SanSet9(6,3);
LatencySet960=SanSet9(6,4);

DeliverySet970=SanSet9(7,1);
DropSet970=SanSet9(7,2);
OverheadSet970=SanSet9(7,3);
LatencySet970=SanSet9(7,4);

DeliverySet980=SanSet9(8,1);
DropSet980=SanSet9(8,2);
OverheadSet980=SanSet9(8,3);
LatencySet980=SanSet9(8,4);

DeliverySet990=SanSet9(9,1);
DropSet990=SanSet9(9,2);
OverheadSet990=SanSet9(9,3);
LatencySet990=SanSet9(9,4);

DeliverySet9100=SanSet9(10,1);
DropSet9100=SanSet9(10,2);
OverheadSet9100=SanSet9(10,3);
LatencySet9100=SanSet9(10,4);

DeliverySet9=[DeliverySet910 DeliverySet920 DeliverySet930 DeliverySet940 DeliverySet950 DeliverySet960 DeliverySet970 DeliverySet980 DeliverySet990 DeliverySet9100];
DropSet9=[DropSet910 DropSet920 DropSet930 DropSet940 DropSet950 DropSet960 DropSet970 DropSet980 DropSet990 DropSet9100 ];
OverheadSet9=[OverheadSet910 OverheadSet920 OverheadSet930 OverheadSet940 OverheadSet950 OverheadSet960 OverheadSet970 OverheadSet980 OverheadSet990 OverheadSet9100];
LatencySet9=[LatencySet910 LatencySet920 LatencySet930 LatencySet940 LatencySet950 LatencySet960 LatencySet970 LatencySet980 LatencySet990 LatencySet9100];

%
%%
%Set10
DeliverySet1010=SanSet10(1,1);
DropSet1010=SanSet10(1,2);
OverheadSet1010=SanSet10(1,3);
LatencySet1010=SanSet10(1,4);

DeliverySet1020=SanSet10(2,1);
DropSet1020=SanSet10(2,2);
OverheadSet1020=SanSet10(2,3);
LatencySet1020=SanSet10(2,4);

DeliverySet1030=SanSet10(3,1);
DropSet1030=SanSet10(3,2);
OverheadSet1030=SanSet10(3,3);
LatencySet1030=SanSet10(3,4);

DeliverySet1040=SanSet10(4,1);
DropSet1040=SanSet10(4,2);
OverheadSet1040=SanSet10(4,3);
LatencySet1040=SanSet10(4,4);

DeliverySet1050=SanSet10(5,1);
DropSet1050=SanSet10(5,2);
OverheadSet1050=SanSet10(5,3);
LatencySet1050=SanSet10(5,4);

DeliverySet1060=SanSet10(6,1);
DropSet1060=SanSet10(6,2);
OverheadSet1060=SanSet10(6,3);
LatencySet1060=SanSet10(6,4);

DeliverySet1070=SanSet10(7,1);
DropSet1070=SanSet10(7,2);
OverheadSet1070=SanSet10(7,3);
LatencySet1070=SanSet10(7,4);

DeliverySet1080=SanSet10(8,1);
DropSet1080=SanSet10(8,2);
OverheadSet1080=SanSet10(8,3);
LatencySet1080=SanSet10(8,4);

DeliverySet1090=SanSet10(9,1);
DropSet1090=SanSet10(9,2);
OverheadSet1090=SanSet10(9,3);
LatencySet1090=SanSet10(9,4);

DeliverySet10100=SanSet10(10,1);
DropSet10100=SanSet10(10,2);
OverheadSet10100=SanSet10(10,3);
LatencySet10100=SanSet10(10,4);

DeliverySet10=[DeliverySet1010 DeliverySet1020 DeliverySet1030 DeliverySet1040 DeliverySet1050 DeliverySet1060 DeliverySet1070 DeliverySet1080 DeliverySet1090 DeliverySet10100];
DropSet10=[DropSet1010 DropSet1020 DropSet1030 DropSet1040 DropSet1050 DropSet1060 DropSet1070 DropSet1080 DropSet1090 DropSet10100 ];
OverheadSet10=[OverheadSet1010 OverheadSet1020 OverheadSet1030 OverheadSet1040 OverheadSet1050 OverheadSet1060 OverheadSet1070 OverheadSet1080 OverheadSet1090 OverheadSet10100];
LatencySet10=[LatencySet1010 LatencySet1020 LatencySet1030 LatencySet1040 LatencySet1050 LatencySet1060 LatencySet1070 LatencySet1080 LatencySet1090 LatencySet10100];

%
%%
%Set11

DeliverySet1110=SanSet11(1,1);
DropSet1110=SanSet11(1,2);
OverheadSet1110=SanSet11(1,3);
LatencySet1110=SanSet11(1,4);

DeliverySet1120=SanSet11(2,1);
DropSet1120=SanSet11(2,2);
OverheadSet1120=SanSet11(2,3);
LatencySet1120=SanSet11(2,4);

DeliverySet1130=SanSet11(3,1);
DropSet1130=SanSet11(3,2);
OverheadSet1130=SanSet11(3,3);
LatencySet1130=SanSet11(3,4);

DeliverySet1140=SanSet11(4,1);
DropSet1140=SanSet11(4,2);
OverheadSet1140=SanSet11(4,3);
LatencySet1140=SanSet11(4,4);

DeliverySet1150=SanSet11(5,1);
DropSet1150=SanSet11(5,2);
OverheadSet1150=SanSet11(5,3);
LatencySet1150=SanSet11(5,4);

DeliverySet1160=SanSet11(6,1);
DropSet1160=SanSet11(6,2);
OverheadSet1160=SanSet11(6,3);
LatencySet1160=SanSet11(6,4);

DeliverySet1170=SanSet11(7,1);
DropSet1170=SanSet11(7,2);
OverheadSet1170=SanSet11(7,3);
LatencySet1170=SanSet11(7,4);

DeliverySet1180=SanSet11(8,1);
DropSet1180=SanSet11(8,2);
OverheadSet1180=SanSet11(8,3);
LatencySet1180=SanSet11(8,4);

DeliverySet1190=SanSet11(9,1);
DropSet1190=SanSet11(9,2);
OverheadSet1190=SanSet11(9,3);
LatencySet1190=SanSet11(9,4);

DeliverySet11100=SanSet11(10,1);
DropSet11100=SanSet11(10,2);
OverheadSet11100=SanSet11(10,3);
LatencySet11100=SanSet11(10,4);

DeliverySet11=[DeliverySet1110 DeliverySet1120 DeliverySet1130 DeliverySet1140 DeliverySet1150 DeliverySet1160 DeliverySet1170 DeliverySet1180 DeliverySet1190 DeliverySet11100];
DropSet11=[DropSet1110 DropSet1120 DropSet1130 DropSet1140 DropSet1150 DropSet1160 DropSet1170 DropSet1180 DropSet1190 DropSet11100 ];
OverheadSet11=[OverheadSet1110 OverheadSet1120 OverheadSet1130 OverheadSet1140 OverheadSet1150 OverheadSet1160 OverheadSet1170 OverheadSet1180 OverheadSet1190 OverheadSet11100];
LatencySet11=[LatencySet1110 LatencySet1120 LatencySet1130 LatencySet1140 LatencySet1150 LatencySet1160 LatencySet1170 LatencySet1180 LatencySet1190 LatencySet11100];

%
%%
%Set12

DeliverySet1210=SanSet12(1,1);
DropSet1210=SanSet12(1,2);
OverheadSet1210=SanSet12(1,3);
LatencySet1210=SanSet12(1,4);

DeliverySet1220=SanSet12(2,1);
DropSet1220=SanSet12(2,2);
OverheadSet1220=SanSet12(2,3);
LatencySet1220=SanSet12(2,4);

DeliverySet1230=SanSet12(3,1);
DropSet1230=SanSet12(3,2);
OverheadSet1230=SanSet12(3,3);
LatencySet1230=SanSet12(3,4);

DeliverySet1240=SanSet12(4,1);
DropSet1240=SanSet12(4,2);
OverheadSet1240=SanSet12(4,3);
LatencySet1240=SanSet12(4,4);

DeliverySet1250=SanSet12(5,1);
DropSet1250=SanSet12(5,2);
OverheadSet1250=SanSet12(5,3);
LatencySet1250=SanSet12(5,4);

DeliverySet1260=SanSet12(6,1);
DropSet1260=SanSet12(6,2);
OverheadSet1260=SanSet12(6,3);
LatencySet1260=SanSet12(6,4);

DeliverySet1270=SanSet12(7,1);
DropSet1270=SanSet12(7,2);
OverheadSet1270=SanSet12(7,3);
LatencySet1270=SanSet12(7,4);

DeliverySet1280=SanSet12(8,1);
DropSet1280=SanSet12(8,2);
OverheadSet1280=SanSet12(8,3);
LatencySet1280=SanSet12(8,4);

DeliverySet1290=SanSet12(9,1);
DropSet1290=SanSet12(9,2);
OverheadSet1290=SanSet12(9,3);
LatencySet1290=SanSet12(9,4);

DeliverySet12100=SanSet12(10,1);
DropSet12100=SanSet12(10,2);
OverheadSet12100=SanSet12(10,3);
LatencySet12100=SanSet12(10,4);

DeliverySet12=[DeliverySet1210 DeliverySet1220 DeliverySet1230 DeliverySet1240 DeliverySet1250 DeliverySet1260 DeliverySet1270 DeliverySet1280 DeliverySet1290 DeliverySet12100];
DropSet12=[DropSet1210 DropSet1220 DropSet1230 DropSet1240 DropSet1250 DropSet1260 DropSet1270 DropSet1280 DropSet1290 DropSet12100 ];
OverheadSet12=[OverheadSet1210 OverheadSet1220 OverheadSet1230 OverheadSet1240 OverheadSet1250 OverheadSet1260 OverheadSet1270 OverheadSet1280 OverheadSet1290 OverheadSet12100];
LatencySet12=[LatencySet1210 LatencySet1220 LatencySet1230 LatencySet1240 LatencySet1250 LatencySet1260 LatencySet1270 LatencySet1280 LatencySet1290 LatencySet12100];

%
%%
%Prophet
DeliveryPr10=SanPr(1,1);
DropPr10=SanPr(1,2);
OverheadPr10=SanPr(1,3);
LatencyPr10=SanPr(1,4);

DeliveryPr20=SanPr(2,1);
DropPr20=SanPr(2,2);
OverheadPr20=SanPr(2,3);
LatencyPr20=SanPr(2,4);

DeliveryPr30=SanPr(3,1);
DropPr30=SanPr(3,2);
OverheadPr30=SanPr(3,3);
LatencyPr30=SanPr(3,4);

DeliveryPr40=SanPr(4,1);
DropPr40=SanPr(4,2);
OverheadPr40=SanPr(4,3);
LatencyPr40=SanPr(4,4);

DeliveryPr50=SanPr(5,1);
DropPr50=SanPr(5,2);
OverheadPr50=SanPr(5,3);
LatencyPr50=SanPr(5,4);

DeliveryPr60=SanPr(6,1);
DropPr60=SanPr(6,2);
OverheadPr60=SanPr(6,3);
LatencyPr60=SanPr(6,4);

DeliveryPr70=SanPr(7,1);
DropPr70=SanPr(7,2);
OverheadPr70=SanPr(7,3);
LatencyPr70=SanPr(7,4);

DeliveryPr80=SanPr(8,1);
DropPr80=SanPr(8,2);
OverheadPr80=SanPr(8,3);
LatencyPr80=SanPr(8,4);

DeliveryPr90=SanPr(9,1);
DropPr90=SanPr(9,2);
OverheadPr90=SanPr(9,3);
LatencyPr90=SanPr(9,4);

DeliveryPr100=SanPr(10,1);
DropPr100=SanPr(10,2);
OverheadPr100=SanPr(10,3);
LatencyPr100=SanPr(10,4);

DeliveryPr=[DeliveryPr10 DeliveryPr20 DeliveryPr30 DeliveryPr40 DeliveryPr50 DeliveryPr60 DeliveryPr70 DeliveryPr80 DeliveryPr90 DeliveryPr100];
DropPr=[DropPr10 DropPr20 DropPr30 DropPr40 DropPr50 DropPr60 DropPr70 DropPr80 DropPr90 DropPr100 ];
OverheadPr=[OverheadPr10 OverheadPr20 OverheadPr30 OverheadPr40 OverheadPr50 OverheadPr60 OverheadPr70 OverheadPr80 OverheadPr90 OverheadPr100];
LatencyPr=[LatencyPr10 LatencyPr20 LatencyPr30 LatencyPr40 LatencyPr50 LatencyPr60 LatencyPr70 LatencyPr80 LatencyPr90 LatencyPr100];
%%
%%
%Epidemic
DeliveryEp10=SanEp(1,1);
DropEp10=SanEp(1,2);
OverheadEp10=SanEp(1,3);
LatencyEp10=SanEp(1,4);

DeliveryEp20=SanEp(2,1);
DropEp20=SanEp(2,2);
OverheadEp20=SanEp(2,3);
LatencyEp20=SanEp(2,4);

DeliveryEp30=SanEp(3,1);
DropEp30=SanEp(3,2);
OverheadEp30=SanEp(3,3);
LatencyEp30=SanEp(3,4);

DeliveryEp40=SanEp(4,1);
DropEp40=SanEp(4,2);
OverheadEp40=SanEp(4,3);
LatencyEp40=SanEp(4,4);

DeliveryEp50=SanEp(5,1);
DropEp50=SanEp(5,2);
OverheadEp50=SanEp(5,3);
LatencyEp50=SanEp(5,4);

DeliveryEp60=SanEp(6,1);
DropEp60=SanEp(6,2);
OverheadEp60=SanEp(6,3);
LatencyEp60=SanEp(6,4);

DeliveryEp70=SanEp(7,1);
DropEp70=SanEp(7,2);
OverheadEp70=SanEp(7,3);
LatencyEp70=SanEp(7,4);

DeliveryEp80=SanEp(8,1);
DropEp80=SanEp(8,2);
OverheadEp80=SanEp(8,3);
LatencyEp80=SanEp(8,4);

DeliveryEp90=SanEp(9,1);
DropEp90=SanEp(9,2);
OverheadEp90=SanEp(9,3);
LatencyEp90=SanEp(9,4);

DeliveryEp100=SanEp(10,1);
DropEp100=SanEp(10,2);
OverheadEp100=SanEp(10,3);
LatencyEp100=SanEp(10,4);

DeliveryEp=[DeliveryEp10 DeliveryEp20 DeliveryEp30 DeliveryEp40 DeliveryEp50 DeliveryEp60 DeliveryEp70 DeliveryEp80 DeliveryEp90 DeliveryEp100];
DropEp=[DropEp10 DropEp20 DropEp30 DropEp40 DropEp50 DropEp60 DropEp70 DropEp80 DropEp90 DropEp100 ];
OverheadEp=[OverheadEp10 OverheadEp20 OverheadEp30 OverheadEp40 OverheadEp50 OverheadEp60 OverheadEp70 OverheadEp80 OverheadEp90 OverheadEp100];
LatencyEp=[LatencyEp10 LatencyEp20 LatencyEp30 LatencyEp40 LatencyEp50 LatencyEp60 LatencyEp70 LatencyEp80 LatencyEp90 LatencyEp100];
%%
%%
%First contact
DeliveryFC10=SanFC(1,1);
DropFC10=SanFC(1,2);
OverheadFC10=SanFC(1,3);
LatencyFC10=SanFC(1,4);

DeliveryFC20=SanFC(2,1);
DropFC20=SanFC(2,2);
OverheadFC20=SanFC(2,3);
LatencyFC20=SanFC(2,4);

DeliveryFC30=SanFC(3,1);
DropFC30=SanFC(3,2);
OverheadFC30=SanFC(3,3);
LatencyFC30=SanFC(3,4);

DeliveryFC40=SanFC(4,1);
DropFC40=SanFC(4,2);
OverheadFC40=SanFC(4,3);
LatencyFC40=SanFC(4,4);

DeliveryFC50=SanFC(5,1);
DropFC50=SanFC(5,2);
OverheadFC50=SanFC(5,3);
LatencyFC50=SanFC(5,4);

DeliveryFC60=SanFC(6,1);
DropFC60=SanFC(6,2);
OverheadFC60=SanFC(6,3);
LatencyFC60=SanFC(6,4);

DeliveryFC70=SanFC(7,1);
DropFC70=SanFC(7,2);
OverheadFC70=SanFC(7,3);
LatencyFC70=SanFC(7,4);

DeliveryFC80=SanFC(8,1);
DropFC80=SanFC(8,2);
OverheadFC80=SanFC(8,3);
LatencyFC80=SanFC(8,4);

DeliveryFC90=SanFC(9,1);
DropFC90=SanFC(9,2);
OverheadFC90=SanFC(9,3);
LatencyFC90=SanFC(9,4);

DeliveryFC100=SanFC(10,1);
DropFC100=SanFC(10,2);
OverheadFC100=SanFC(10,3);
LatencyFC100=SanFC(10,4);

DeliveryFC=[DeliveryFC10 DeliveryFC20 DeliveryFC30 DeliveryFC40 DeliveryFC50 DeliveryFC60 DeliveryFC70 DeliveryFC80 DeliveryFC90 DeliveryFC100];
DropFC=[DropFC10 DropFC20 DropFC30 DropFC40 DropFC50 DropFC60 DropFC70 DropFC80 DropFC90 DropFC100 ];
OverheadFC=[OverheadFC10 OverheadFC20 OverheadFC30 OverheadFC40 OverheadFC50 OverheadFC60 OverheadFC70 OverheadFC80 OverheadFC90 OverheadFC100];
LatencyFC=[LatencyFC10 LatencyFC20 LatencyFC30 LatencyFC40 LatencyFC50 LatencyFC60 LatencyFC70 LatencyFC80 LatencyFC90 LatencyFC100];

%%
%Bar
DeliveryValues1 = [DeliverySet1; DeliverySet2; DeliverySet3; DeliverySet4; DeliverySet5; DeliverySet6];

figure
bar(Nodes,DeliveryValues1,'LineWidth',1.5)

set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Delivery (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Delivery') % y-axis label
legend({'0.1H0.0S0.8A (1)', '0.1H0.0S1A (2)', '0.1H10000.0S0.8A (3)', '0.1H10000.0S1A (4)', '0.1H20000.0S0.8A (5)', '0.1H20000.0S1A (6)'}, 'Position',[0.71 0.21 0.1 0.2], 'FontSize',15)
 %xlim([1100 336])
 grid on
  
%%
%Bar
DeliveryValues1 = [DeliverySet7; DeliverySet8; DeliverySet9; DeliverySet10; DeliverySet11; DeliverySet12];

figure
bar(Nodes,DeliveryValues1,'LineWidth',1.5)

set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Delivery (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Delivery') % y-axis label
legend({'0.2H0.0S0.8A (7)', '0.2H0.0S1A (8)', '0.2H10000.0S0.8A (9)', '0.2H10000.0S1A (10)', '0.2H20000.0S0.8A (11)', '0.2H20000.0S1A (12)'}, 'Position',[0.71 0.21 0.1 0.2], 'FontSize',15)

 %xlim([1100 336])
  grid on
  
%%
%Bar
DropValues1 = [DropSet1; DropSet2; DropSet3; DropSet4; DropSet5; DropSet6];

figure
bar(Nodes,DropValues1,'LineWidth',1.5)

set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Drop (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Drop') % y-axis label
legend({'0.1H0.0S0.8A (1)', '0.1H0.0S1A (2)', '0.1H10000.0S0.8A (3)', '0.1H10000.0S1A (4)', '0.1H20000.0S0.8A (5)', '0.1H20000.0S1A (6)'}, 'Position',[0.69 0.23 0.1 0.2], 'FontSize',15)

 %xlim([1100 336])
  grid on
  
%%
%Bar
DropValues1 = [DropSet7; DropSet8; DropSet9; DropSet10; DropSet11; DropSet12];

figure
bar(Nodes,DropValues1,'LineWidth',1.5)

set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Drop (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Drop') % y-axis label
legend({'0.2H0.0S0.8A (7)', '0.2H0.0S1A (8)', '0.2H10000.0S0.8A (9)', '0.2H10000.0S1A (10)', '0.2H20000.0S0.8A (11)', '0.2H20000.0S1A (12)'}, 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
  grid on
  

%%
%Bar
OverheadValues1 = [OverheadSet1; OverheadSet2; OverheadSet3; OverheadSet4; OverheadSet5; OverheadSet6];

figure
bar(Nodes,OverheadValues1,'LineWidth',1.5)

set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Network Overhead (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Overhead') % y-axis label
legend({'0.1H0.0S0.8A (1)', '0.1H0.0S1A (2)', '0.1H10000.0S0.8A (3)', '0.1H10000.0S1A (4)', '0.1H20000.0S0.8A (5)', '0.1H20000.0S1A (6)'}, 'Location', 'northwest','FontSize',15)

 %xlim([1100 336])
  grid on
  
%%
%Bar
OverheadValues1 = [OverheadSet7; OverheadSet8; OverheadSet9; OverheadSet10; OverheadSet11; OverheadSet12];

figure
bar(Nodes,OverheadValues1,'LineWidth',1.5)

set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Network Overhead (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Overhead') % y-axis label
legend({'0.2H0.0S0.8A (7)', '0.2H0.0S1A (8)', '0.2H10000.0S0.8A (9)', '0.2H10000.0S1A (10)', '0.2H20000.0S0.8A (11)', '0.2H20000.0S1A (12)'}, 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
  grid on
  
%%
%Bar
LatencyValues1 = [LatencySet1; LatencySet2; LatencySet3; LatencySet4; LatencySet5; LatencySet6];

figure
bar(Nodes,LatencyValues1,'LineWidth',1.5)

set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Latency (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Latency') % y-axis label
legend({'0.1H0.0S0.8A (1)', '0.1H0.0S1A (2)', '0.1H10000.0S0.8A (3)', '0.1H10000.0S1A (4)', '0.1H20000.0S0.8A (5)', '0.1H20000.0S1A (6)'}, 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
  grid on
  
%%
%Bar
LatencyValues1 = [LatencySet7; LatencySet8; LatencySet9; LatencySet10; LatencySet11; LatencySet12];

figure
bar(Nodes,LatencyValues1,'LineWidth',1.5)

set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
title('Messages Latency (San Francisco)')
xlabel('Nodes') % x-axis label
ylabel('Messages Latency') % y-axis label
legend({'0.2H0.0S0.8A (7)', '0.2H0.0S1A (8)', '0.2H10000.0S0.8A (9)', '0.2H10000.0S1A (10)', '0.2H20000.0S0.8A (11)', '0.2H20000.0S1A (12)'}, 'Location', 'northwest', 'FontSize',15)

 %xlim([1100 336])
  grid on
  

%%
% figure
% plot(Nodes,DeliverySet1,'-<','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet2,'-+','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet3,'-.','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet4,'-_','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet5,'-|','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet6,'-s','LineWidth',1.5)
% hold on
% plot(Nodes,DeliveryPr,'-o','LineWidth',1.5)
% hold on
% plot(Nodes,DeliveryEp,'-x','LineWidth',1.5)
% hold on
% plot(Nodes,DeliveryFC,'-*','LineWidth',1.5)
% 
% 
% set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
% title('Messages Delivery (San Francisco)')
% xlabel('Nodes') % x-axis label
% ylabel('Messages Delivery') % y-axis label
% legend({'0.1H0.0S0.8A (1)', '0.1H0.0S1A (2)', '0.1H10000.0S0.8A (3)', '0.1H10000.0S1A (4)', '0.1H20000.0S0.8A (5)', '0.1H20000.0S1A (6)', 'Prophet', 'Epidemic', 'First Contact'}, 'Location', 'northwest')
% 
%  %xlim([1100 336])
%   grid on
%   
% %%
% figure
% plot(Nodes,DeliverySet7,'-<','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet8,'-+','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet9,'-.','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet10,'-_','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet11,'-|','LineWidth',1.5)
% hold on
% plot(Nodes,DeliverySet12,'-s','LineWidth',1.5)
% hold on
% hold on
% plot(Nodes,DeliveryPr,'-o','LineWidth',1.5)
% hold on
% plot(Nodes,DeliveryEp,'-x','LineWidth',1.5)
% hold on
% plot(Nodes,DeliveryFC,'-*','LineWidth',1.5)
% 
% 
% set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
% title('Messages Delivery (San Francisco)')
% xlabel('Nodes') % x-axis label
% ylabel('Messages Delivery') % y-axis label
% legend({'0.2H0.0S0.8A (7)', '0.2H0.0S1A (8)', '0.2H10000.0S0.8A (9)', '0.2H10000.0S1A (10)', '0.2H20000.0S0.8A (11)', '0.2H20000.0S1A (12)', 'Prophet', 'Epidemic', 'First Contact'}, 'Location', 'northwest')
% 
%  %xlim([1100 336])
%   grid on
%   
% %%
% figure
% plot(Nodes,DropSet1,'-<','LineWidth',1.5)
% hold on
% plot(Nodes,DropPr,'-o','LineWidth',1.5)
% hold on
% plot(Nodes,DropEp,'-x','LineWidth',1.5)
% hold on
% plot(Nodes,DropFC,'-*','LineWidth',1.5)
% 
% 
% set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
% title('Dropped Messages (San Francisco)')
% xlabel('Nodes') % x-axis label
% ylabel('Dropped Messages') % y-axis label
% legend('Blossom','Prophet', 'Epidemic', 'First Contact')
% 
%  %xlim([1100 336])
%   grid on
%   %%
% figure
% plot(Nodes,OverheadSet1,'-<','LineWidth',1.5)
% hold on
% plot(Nodes,OverheadPr,'-o','LineWidth',1.5)
% hold on
% plot(Nodes,OverheadEp,'-x','LineWidth',1.5)
% hold on
% plot(Nodes,OverheadFC,'-*','LineWidth',1.5)
% 
% 
% set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
% title('Network Overhead (San Francisco)')
% xlabel('Nodes') % x-axis label
% ylabel('Network Overhead') % y-axis label
% legend('Blossom','Prophet', 'Epidemic', 'First Contact')
% 
%  %xlim([1100 336])
%   grid on
%   %%
% figure
% plot(Nodes,LatencySet1,'-<','LineWidth',1.5)
% hold on
% plot(Nodes,LatencyPr,'-o','LineWidth',1.5)
% hold on
% plot(Nodes,LatencyEp,'-x','LineWidth',1.5)
% hold on
% plot(Nodes,LatencyFC,'-*','LineWidth',1.5)
% 
% 
% set(gca, 'FontName', 'Times New Roman','FontSize',24,'LineWidth',1.5)
% title('Messages Latency (San Francisco)')
% xlabel('Nodes') % x-axis label
% ylabel('Messages Latency') % y-axis label
% legend('Blossom','Prophet', 'Epidemic', 'First Contact')
% 
%  %xlim([1100 336])
%   grid on