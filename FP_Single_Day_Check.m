clear all;close all; clc;

Tank_List='Y:\Rachael Bell\FP.ACh\Tanks\WT\Clean PFC\918-250904-164844';%AUX Tanks

Behav_List="Y:\Rachael Bell\Extracted mFile Data\May2023-\918\7TS3\2025-09-05Subj918.mat"; %AUX Behav


Animal_ID_Behav=extractBetween(Behav_List,"Subj",".");
perform_date=extractBetween(Behav_List,56,65); 
figurefile_path="Y:\Rachael Bell\FP.ACh\Individual Graphs\";
cond=[" Clean"," AD"," VD"];
depth_options=[" -1.95mm", " -1.65mm", "-.3mm","-.4mm",""];

Location=string(extractBetween(Tank_List,"Clean","\"));
Condition=cond(1);
Probe_depth=depth_options(5);

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

  data= TDTbin2mat(Tank_List); %Load tank into work place
  time = (1:length(data.streams.(GRAB).data))/data.streams.(GRAB).fs; %make time vector 
  [data]=detrend_Df_f(data,time,GRAB,ISO);
 [ToneMatrix_GRAB,ToneMatrix_ISO,ToneRT,ToneHitMatrix_GRAB,ToneHitMatrix_ISO,ToneFAMatrix_GRAB,ToneFAMatrix_ISO,...
     ITIMatrix_GRAB,ITIMatrix_ISO,HitMatrix_GRAB,HitMatrix_ISO,FAMatrix_GRAB,FAMatrix_ISO,RT_Hit,RT_FA,...
     OctaveHitMatrix_GRAB,OctaveHitMatrix_ISO,OctaveFAMatrix_GRAB,OctaveFAMatrix_ISO,...
    ITIHitMatrix_GRAB,ITIHitMatrix_ISO,ITIFAMatrix_GRAB,ITIFAMatrix_ISO,ToneHitRT,ToneFART,...
    OctaveHitRT,OctaveFART,OctaveMatrix_GRAB,OctaveMatrix_ISO,OctaveRT]=Filter_Tone_Behav(data,Trial_Counter,Epoc_Range,GRAB,ISO,Behav_List);

% [FinalRTFA_Behav,FinalRTHits_Behav,HitRate_Behav,OctaveHitRate_Behav]=RateCalc_FP(Behav_List);
 %behav_plot=plot_phyc_curve(HitRate_Behav,3,'b',Animal_ID_Behav,Location);
% saveas(behav_plot,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" BehavCurve.fig")))

ISO_fs=data.streams.(ISO).fs;
GRAB_fs=data.streams.(GRAB).fs;
% 
% RT_Hit=cell2mat(RT_Hit);
% RT_FA=cell2mat(RT_FA);
% 
% HitMatrix_GRAB=cell2mat(HitMatrix_GRAB);
% HitMatrix_ISO=cell2mat(HitMatrix_ISO);
% 
% FAMatrix_GRAB=cell2mat(FAMatrix_GRAB);
% FAMatrix_ISO=cell2mat(FAMatrix_ISO);


figure
graph_nocallout_individual(HitMatrix_GRAB, HitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),RT_Hit,N,Animal_ID_Behav, ...
    Condition,Probe_depth)

% saveas(gcf,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" Hits.fig")))

figure
graph_nocallout_individual(FAMatrix_GRAB, FAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_FA,N,Animal_ID_Behav, ...
    Condition,Probe_depth)

% saveas(gcf,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" False Alarms.fig")))


%%
for i=1:length(Tank_List)
graph_HitvFA(HitMatrix_GRAB,FAMatrix_GRAB,Epoc_Range,ISO_fs,ITI,Location,"",RT_Hit,N,"",Condition)


%graph_tonecallout(ToneHitMatrix_GRAB, ToneHitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),tone,ToneHitRT,N,Animal_ID_FP)
% %saveas(gcf,fullfile(figurefile_path,(Animal_ID_FP+Location+Condition+" Tone Hits.fig")))
% 
 %graph_tonecallout(ToneFAMatrix_GRAB, ToneFAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),tone,ToneFART,N,Animal_ID_FP)

 graph_Tone_HitvFA(ToneHitMatrix_GRAB,ToneFAMatrix_GRAB,Epoc_Range,ISO_fs,ITI,Location,"",RT_Hit,N,"Old Com",tone)

  graph_Octave_HitvFA(OctaveHitMatrix_GRAB,OctaveFAMatrix_GRAB,Epoc_Range,ISO_fs,ITI,Location,"",RT_Hit,N,"",octave_step)
end
