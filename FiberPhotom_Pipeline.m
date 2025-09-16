clear all;close all; clc;


% Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\FX\Clean AUX\895-250827-151656", ...
%     "Y:\Rachael Bell\FP.ACh\Tanks\FX\Clean AUX\896-250827-160450"];% FX AUX Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\895\7TS3\2025-08-27Subj895.mat",...
%     "Y:\Rachael Bell\Extracted mFile Data\May2023-\896\7TS3\2025-08-27Subj896.mat"]; % FX AUX Behav

% Tank_List=['Y:\Rachael Bell\FP.ACh\Tanks\FX\Clean PFC\896-250826-165742', ...
%     "Y:\Rachael Bell\FP.ACh\Tanks\FX\Clean PFC\895-250828-151411"];% FX PFC Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\896\7TS3\2025-08-26Subj896.mat",...
%     "Y:\Rachael Bell\Extracted mFile Data\May2023-\895\7TS3\2025-08-28Subj895.mat"]; % FX PFC Behav


% Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\WT\Clean PFC\917-250821-162631", ...
%     ];% WT PFC Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\917\7TS3\2025-08-21Subj917.mat",...
%     ]; % WT PFC Behav

% Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\WT\Clean AUX\918-250905-164727",...
%     "Y:\Rachael Bell\FP.ACh\Tanks\WT\Clean AUX\916-250904-160031",...
%     "Y:\Rachael Bell\FP.ACh\Tanks\WT\Clean PFC\916-250905-155939",...
%     "Y:\Rachael Bell\FP.ACh\Tanks\WT\Clean PFC\918-250904-164844"];%AUX Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\918\7TS3\2025-09-05Subj918.mat",...
%     "Y:\Rachael Bell\Extracted mFile Data\May2023-\916\7TS3\2025-09-04Subj916.mat",...
%     "Y:\Rachael Bell\Extracted mFile Data\May2023-\916\7TS3\2025-09-05Subj916.mat",...
%     "Y:\Rachael Bell\Extracted mFile Data\May2023-\918\7TS3\2025-09-05Subj918.mat"]; %AUX Behav

Tank_List=[]

Behav_List=[]

Animal_ID_FP="";
for a=1:length(Behav_List)
Animal_ID_Behav(a)=extractBetween(Behav_List(a),"Subj",".");
Location=extractBetween(Tank_List(a),"Clean","\");
end
figurefile_path="Y:\Rachael Bell\FP.ACh\Pooled Graphs\";
cond=["Clean","AD","VD"];


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
 [ToneMatrix_GRAB{i},ToneMatrix_ISO{i},ToneRT{i},ToneHitMatrix_GRAB{i},ToneHitMatrix_ISO{i},...
 ToneFAMatrix_GRAB{i},ToneFAMatrix_ISO{i},ITIMatrix_GRAB{i},ITIMatrix_ISO{i},...
 HitMatrix_GRAB{i,1},HitMatrix_ISO{i,1},FAMatrix_GRAB{i,1},FAMatrix_ISO{i,1},...
 RT_Hit{i,1},RT_FA{i,1},OctaveHitMatrix_GRAB{i},OctaveHitMatrix_ISO{i},...
 OctaveFAMatrix_GRAB{i},OctaveFAMatrix_ISO{i},ITIHitMatrix_GRAB{i},ITIHitMatrix_ISO{i},...
 ITIFAMatrix_GRAB{i},ITIFAMatrix_ISO{i},ToneHitRT{i},ToneFART{i},...
 OctaveHitRT{i},OctaveFART{i},OctaveMatrix_GRAB{i},OctaveMatrix_ISO{i},OctaveRT{i}]=Filter_Tone_Behav(data,Trial_Counter,Epoc_Range,GRAB,ISO,Behav_List{i});
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
 Masterlist.ToneGRAB(i)=ToneMatrix_GRAB(i);
 Masterlist.ToneRT(i)=ToneRT(i);
 Masterlist.OctaveGRAB(i)=OctaveMatrix_GRAB(i);
 Masterlist.OctaveRT(i)=OctaveRT(i);
end
ISO_fs=data.streams.(ISO).fs;
GRAB_fs=data.streams.(GRAB).fs;

%  [FinalRTFA_Behav,FinalRTHits_Behav,HitRate_Behav,OctaveHitRate_Behav]=RateCalc_FP(Behav_List);
% 
% for i=1:length(Behav_List)
%     Masterlist.BehavHitRate(i)=HitRate_Behav(i);
% 
% end
% Masterlist.OctaveHitRate_Behav=OctaveHitRate_Behav;
% 
%  %%
% [AUC_Hits,Amp_Hits]=Masterlist_Calc(Masterlist.HitGRAB,N,Epoc_Range,ISO_fs,ITI,Masterlist.ID,type(1),Location,RT_Hit);
% 
% 
% [AUC_FA,Amps_FA]=Masterlist_Calc(Masterlist.FAGRAB,N,Epoc_Range,ISO_fs,ITI,Masterlist.ID,type(2),Location,RT_FA);
% 
% [AUC_Tone_Overall,Amps_Tone_Overall]=Masterlist_Calc_Tone(Masterlist.ToneGRAB,N,Epoc_Range,ISO_fs,ITI,Masterlist.ID,"Tone",Location,Masterlist.ToneRT);
% 
% [AUC_Octave_Overall,Amps_Octave_Overall]=Masterlist_Calc_Octave(Masterlist.OctaveGRAB,N,Epoc_Range,ISO_fs,ITI,Masterlist.ID,"Octave",Location,Masterlist.OctaveRT);
% 
% 
% AUC=[AUC_Hits;AUC_FA];
% Amps=[Amp_Hits;Amps_FA];
%%
% AUC_Path="Y:\Rachael Bell\FP.ACh\AUC Output sheets\";
% 
% writematrix(Amps_Tone_Overall,AUC_Path+Animal_ID_FP+Condition+Location+"ToneAmp.csv")
% writematrix(Amps_Octave_Overall,AUC_Path+Animal_ID_Behav(:)+Condition+Location+"OctaveAmp.csv")
% writematrix(AUC,AUC_Path+Animal_ID_FP+Condition+Location+" AUC.csv")
% writematrix(Amps,AUC_Path+Animal_ID_FP+Condition+Location+" Amps.csv")

 %%% COME BACK OCTAVE FOR D prime
% for i=1:length(HitRate_Behav)
% WholeOctave{i}=cat(1,(1-cell2mat(HitRate_Behav(i,1))),cell2mat(HitRate_Behav(i,7)));
% end
% TwoThirdOctave(i)=cat(1,(1-HitRate_Behav(i,2)),HitRate_Behav(i,6));
% OneThirdOctave(i)=cat(1,(1-HitRate_Behav(i,3)),HitRate_Behav(i,5));
% end





 %% Pooled Calculations
%plot_phyc_curve(HitRate_Behav,3,'b',Animal_ID_Behav,Location)

%plot_Octave_HitRate(HitRate_Behav,OctaveHitRate_Behav,3)
% for i=1:height(HitRate_Behav)
% plot_Octave_HitRate_FP(HitRate_Behav(i,:),OctaveHitRate_Behav,3,Animal_ID_Behav(i))
% end


close all
for i=1:length(Tank_List)
 
 graph_HitvFA(HitMatrix_GRAB{i},FAMatrix_GRAB{i},Epoc_Range,ISO_fs,ITI,Location{i},"",RT_Hit{i},N,Animal_ID_Behav(i),Condition)

graph_Tone_HitvFA(ToneHitMatrix_GRAB{i},ToneFAMatrix_GRAB{i},Epoc_Range,ISO_fs,ITI,Location(i),"",ToneHitRT{i},N,Animal_ID_Behav(i),tone)

graph_Octave_HitvFA(OctaveHitMatrix_GRAB{i},OctaveFAMatrix_GRAB{i},Epoc_Range,ISO_fs,ITI,Location(i),"",OctaveHitRT{i},N,Animal_ID_Behav(i),octave_step)


end



%%
% 
% RT_Hit=cell2mat(RT_Hit);
% RT_FA=cell2mat(RT_FA);
% 
% HitMatrix_GRAB=cell2mat(HitMatrix_GRAB);
% HitMatrix_ISO=cell2mat(HitMatrix_ISO);
% 
% FAMatrix_GRAB=cell2mat(FAMatrix_GRAB);
% FAMatrix_ISO=cell2mat(FAMatrix_ISO);
% 
% ITIMatrix_GRAB=Tone_Merge(ITIMatrix_GRAB);
% ITIMatrix_ISO=Tone_Merge(ITIMatrix_ISO);
% 
% ToneFAMatrix_GRAB=Tone_Merge(ToneFAMatrix_GRAB);
% ToneFAMatrix_ISO=Tone_Merge(ToneFAMatrix_ISO);
% 
% ToneFART=Tone_Merge(ToneFART);
% 
% ToneHitMatrix_GRAB=Tone_Merge(ToneHitMatrix_GRAB);
% ToneHitMatrix_ISO=Tone_Merge(ToneHitMatrix_ISO);
% 
% ToneHitRT=Tone_Merge(ToneHitRT);
% 
% ToneMatrix_GRAB=Tone_Merge(ToneMatrix_GRAB);
% ToneMatrix_ISO=Tone_Merge(ToneMatrix_ISO);
% 
% OctaveHitMatrix_GRAB=Octave_Merge(OctaveHitMatrix_GRAB);
% OctaveHitMatrix_ISO=Octave_Merge(OctaveHitMatrix_ISO);
% 
% OctaveHitRT=Octave_Merge(OctaveHitRT);
% 
% OctaveFAMatrix_GRAB=Octave_Merge(OctaveFAMatrix_GRAB);
% OctaveFAMatrix_ISO=Octave_Merge(OctaveFAMatrix_ISO);
% 
% OctaveFART=Octave_Merge(OctaveFART);
% 
% 
% 
% 
% % 
% % figure
% % graph_nocallout(HitMatrix_GRAB, HitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),RT_Hit,N,Animal_ID_FP,Condition)
% % %saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Hits.fig")))
% % 
% % figure
% % graph_nocallout(FAMatrix_GRAB, FAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_FA,N,Animal_ID_FP,Condition)
% % %saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" False Alarms.fig")))
% 
% 
% graph_HitvFA(HitMatrix_GRAB,FAMatrix_GRAB,Epoc_Range,ISO_fs,ITI,Location,"",RT_Hit,N,"",Condition)
% 
% 
% %graph_tonecallout(ToneHitMatrix_GRAB, ToneHitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),tone,ToneHitRT,N,Animal_ID_FP)
% % %saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Tone Hits.fig")))
% % 
%  %graph_tonecallout(ToneFAMatrix_GRAB, ToneFAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),tone,ToneFART,N,Animal_ID_FP)
% 
%  graph_Tone_HitvFA(ToneHitMatrix_GRAB,ToneFAMatrix_GRAB,Epoc_Range,ISO_fs,ITI,Location,"",ToneHitRT,N,"",tone)
% 
%   graph_Octave_HitvFA(OctaveHitMatrix_GRAB,OctaveFAMatrix_GRAB,Epoc_Range,ISO_fs,ITI,Location,"",RT_Hit,N,"",octave_step)
% 
%  % %saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Tone False Alarms.fig")))
% % 
% % graph_ITIcallout(ITIMatrix_GRAB, ITIMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(3),ITI_time,N,Animal_ID_FP)
% % %saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" ITI.fig")))
% % 
% % graph_octavecallout(OctaveHitMatrix_GRAB, OctaveHitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),octave_step,OctaveHitRT,N,Animal_ID_FP)
% % %saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Octave Hits.fig")))
% % 
% % graph_octavecallout(OctaveFAMatrix_GRAB, OctaveFAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),octave_step,OctaveFART,N,Animal_ID_FP)
% % %saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Octave False Alarms.fig")))