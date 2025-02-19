clear all;close all; clc;

Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\WT Tanks\Clean PFC Tanks\640-241221-144241",
    "Y:\Rachael Bell\FP.ACh\Tanks\WT Tanks\Clean PFC Tanks\633-241231-135643",
    "Y:\Rachael Bell\FP.ACh\Tanks\WT Tanks\Clean PFC Tanks\634-241231-144451"
];%PFC Clean Tanks

Behav_List=[ "Y:\Rachael Bell\Extracted mFile Data\May2023-\640\7TS3\2024-12-21Subj640.mat",
    "Y:\Rachael Bell\Extracted mFile Data\May2023-\633\7TS3\2024-12-31Subj633.mat",
    "Y:\Rachael Bell\Extracted mFile Data\May2023-\634\7TS3\2024-12-31Subj634.mat"
]; %PFC PFC Behav



Animal_ID_FP="640 633 634 641 ";
for a=1:length(Behav_List)
Animal_ID_Behav(a)=extractBetween(Behav_List(a),"Subj",".");
end
figurefile_path="Y:\Rachael Bell\FP.ACh\Pooled Graphs\";
cond=["Clean","AD","VD"];
loc=[" PFC", " AUX"];

Location=loc(1);
Condition=cond(1);
type=[" Hits"," False Alarms", " ITI"];
tone=[" 4kHz"," 5.03kHz"," 6.35kHz"," 8kHz"," 10.08kHz"," 12.7kHz"," 16kHz"];
ITI_time=[" 9s"," 10s"," 11s"," 12s"," 13s"," 14s"," 15s"];
octave_step=[" 1 Octave Diff"," 2/3 Octave Diff"," 1/3 Octave Diff"," 0 Octave Diff"];
N=1; %Downsampling multiple
GRAB='x465A'; %set what GRAB is 
ISO='x405A'; %set what ISO is 
Trial_Counter='PC1/'; %set what epoc counter 
Camera_Counter='PC2/';
Epoc_Range=[-12, 24]; %-12 seconds before tone onset and 12 seconds after tone onset
ITI=[-8,-3]; %baseline period used to normalize the data -12 seconds before tone onset to -9 seconds before tone onset

%% Individual Calculation
for i=1:length(Tank_List)
  data= TDTbin2mat(Tank_List{i}); %Load tank into work place
  time = (1:length(data.streams.(GRAB).data))/data.streams.(GRAB).fs; %make time vector 
  [data]=detrend_Df_f(data,time,GRAB,ISO);
 [ToneMatrix_GRAB{i},ToneMatrix_ISO{i},ToneHitMatrix_GRAB{i},ToneHitMatrix_ISO{i},...
 ToneFAMatrix_GRAB{i},ToneFAMatrix_ISO{i},ITIMatrix_GRAB{i},ITIMatrix_ISO{i},...
 HitMatrix_GRAB{i,1},HitMatrix_ISO{i,1},FAMatrix_GRAB{i,1},FAMatrix_ISO{i,1},...
 RT_Hit{i,1},RT_FA{i,1},OctaveHitMatrix_GRAB{i},OctaveHitMatrix_ISO{i},...
 OctaveFAMatrix_GRAB{i},OctaveFAMatrix_ISO{i},ITIHitMatrix_GRAB{i},ITIHitMatrix_ISO{i},...
 ITIFAMatrix_GRAB{i},ITIFAMatrix_ISO{i},ToneHitRT{i},ToneFART{i},...
 OctaveHitRT{i},OctaveFART{i}]=Filter_Tone_Behav(data,Trial_Counter,Epoc_Range,GRAB,ISO,Behav_List{i});
 Masterlist.ID(i)=extractBetween(Behav_List(i),"Subj",".");
 Masterlist.HitGRAB(i)=HitMatrix_GRAB(i);
 Masterlist.HitISO(i)=HitMatrix_ISO(i);
 Masterlist.FAGRAB(i)=FAMatrix_GRAB(i);
 Masterlist.FAISO(i)=FAMatrix_ISO(i);
 Masterlist.OctaveHitGRAB(i)=OctaveHitMatrix_GRAB(i);
 Masterlist.OctaveHitISO(i)=OctaveHitMatrix_ISO(i);
 Masterlist.OctaveFAGRAB(i)=OctaveFAMatrix_GRAB(i);
 Masterlist.OctaveFAISO(i)=OctaveFAMatrix_ISO(i);
 Masterlist.RTHit(i)=RT_Hit(i);
 Masterlist.RTFA(i)=RT_FA(i);
 Masterlist.OctaveHitRT(i)=OctaveHitRT(i);
 Masterlist.OctaveFART(i)=OctaveFART(i);

end
ISO_fs=data.streams.(ISO).fs;
GRAB_fs=data.streams.(GRAB).fs;

 [FinalRTFA_Behav,FinalRTHits_Behav,HitRate_Behav,OctaveHitRate_Behav]=RateCalc_FP(Behav_List);

for i=1:length(Behav_List)
    Masterlist.BehavHitRate(i)=HitRate_Behav(i);
    
end
Masterlist.OctaveHitRate_Behav=OctaveHitRate_Behav;

 
[AUC_Hits,Amp_Hits]=Masterlist_Calc(Masterlist.HitGRAB,N,Epoc_Range,ISO_fs,ITI,Masterlist.ID,type(1),Location,RT_Hit);


[AUC_FA,Amps_FA]=Masterlist_Calc(Masterlist.FAGRAB,N,Epoc_Range,ISO_fs,ITI,Masterlist.ID,type(2),Location,RT_FA);


%%
AUC=[AUC_Hits;AUC_FA];
Amps=[Amp_Hits;Amps_FA];

AUC_Path="Y:\Rachael Bell\FP.ACh\AUC Output sheets\";

writematrix(AUC,AUC_Path+Animal_ID_FP+Condition+Location+" AUC.csv")
writematrix(Amps,AUC_Path+Animal_ID_FP+Condition+Location+" Amps.csv")
%[AUC_OctaveHits]=Masterlist_Calc(Masterlist.OctaveHitGRAB,N,Epoc_Range,ISO_fs,ITI,Masterlist.OctaveHitRT);

 %%% COME BACK OCTAVE FOR D prime
% for i=1:length(HitRate_Behav)
% WholeOctave{i}=cat(1,(1-cell2mat(HitRate_Behav(i,1))),cell2mat(HitRate_Behav(i,7)));
% end
% TwoThirdOctave(i)=cat(1,(1-HitRate_Behav(i,2)),HitRate_Behav(i,6));
% OneThirdOctave(i)=cat(1,(1-HitRate_Behav(i,3)),HitRate_Behav(i,5));
% end





 %% Pooled Calculations
plot_phyc_curve(HitRate_Behav,3,'b',Animal_ID_Behav,Location)

%plot_Octave_HitRate(HitRate_Behav,OctaveHitRate_Behav,3)
% for i=1:height(HitRate_Behav)
% plot_Octave_HitRate_FP(HitRate_Behav(i,:),OctaveHitRate_Behav,3,Animal_ID_Behav(i))
% end



RT_Hit=cell2mat(RT_Hit);
RT_FA=cell2mat(RT_FA);

HitMatrix_GRAB=cell2mat(HitMatrix_GRAB);
HitMatrix_ISO=cell2mat(HitMatrix_ISO);

FAMatrix_GRAB=cell2mat(FAMatrix_GRAB);
FAMatrix_ISO=cell2mat(FAMatrix_ISO);

ITIMatrix_GRAB=Tone_Merge(ITIMatrix_GRAB);
ITIMatrix_ISO=Tone_Merge(ITIMatrix_ISO);

ToneFAMatrix_GRAB=Tone_Merge(ToneFAMatrix_GRAB);
ToneFAMatrix_ISO=Tone_Merge(ToneFAMatrix_ISO);

ToneFART=Tone_Merge(ToneFART);

ToneHitMatrix_GRAB=Tone_Merge(ToneHitMatrix_GRAB);
ToneHitMatrix_ISO=Tone_Merge(ToneHitMatrix_ISO);

ToneHitRT=Tone_Merge(ToneHitRT);

ToneMatrix_GRAB=Tone_Merge(ToneMatrix_GRAB);
ToneMatrix_ISO=Tone_Merge(ToneMatrix_ISO);

OctaveHitMatrix_GRAB=Octave_Merge(OctaveHitMatrix_GRAB);
OctaveHitMatrix_ISO=Octave_Merge(OctaveHitMatrix_ISO);

OctaveHitRT=Octave_Merge(OctaveHitRT);

OctaveFAMatrix_GRAB=Octave_Merge(OctaveFAMatrix_GRAB);
OctaveFAMatrix_ISO=Octave_Merge(OctaveFAMatrix_ISO);

OctaveFART=Octave_Merge(OctaveFART);





figure
graph_nocallout(HitMatrix_GRAB, HitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),RT_Hit,N,Animal_ID_FP,Condition)
%saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Hits.fig")))

figure
graph_nocallout(FAMatrix_GRAB, FAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_FA,N,Animal_ID_FP,Condition)
%saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" False Alarms.fig")))

graph_tonecallout(ToneHitMatrix_GRAB, ToneHitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),tone,ToneHitRT,N,Animal_ID_FP)
%saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Tone Hits.fig")))

graph_tonecallout(ToneFAMatrix_GRAB, ToneFAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),tone,ToneFART,N,Animal_ID_FP)
%saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Tone False Alarms.fig")))

graph_ITIcallout(ITIMatrix_GRAB, ITIMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(3),ITI_time,N,Animal_ID_FP)
%saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" ITI.fig")))

graph_octavecallout(OctaveHitMatrix_GRAB, OctaveHitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),octave_step,OctaveHitRT,N,Animal_ID_FP)
%saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Octave Hits.fig")))

graph_octavecallout(OctaveFAMatrix_GRAB, OctaveFAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),octave_step,OctaveFART,N,Animal_ID_FP)
%saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Octave False Alarms.fig")))