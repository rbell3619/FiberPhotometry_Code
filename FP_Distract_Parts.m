clear all;close all; clc;

Tank_List=['Y:\Rachael Bell\FP.ACh\742-250131-135209'];%AUX Tanks

Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\742\AD\2025-01-31Subj742.mat"]; %AUX Behav


Animal_ID_Behav=extractBetween(Behav_List,"Subj",".");
perform_date=extractBetween(Behav_List,56,65); 
figurefile_path="Y:\Rachael Bell\FP.ACh\Individual Graphs\";
loc=[" PFC", " AUX"];
cond=[" Clean"," AD"," VD"];
depth_options=[" -1.95mm", " -1.65mm", "-.3mm"];

Location=loc(1);
Condition=cond(2);
Probe_depth=depth_options(2);

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

data.epocs.PC1_.onset=data.epocs.PC1_.onset+.123;

data_epoc=TDTfilter(data,Trial_Counter,'Time',Epoc_Range); %filter and extract the data around the tone onset given the tone onset and window 
minLength1=min(cellfun('prodofsize',data_epoc.streams.(ISO).filtered)); %checking the length of ISO 
minLength2=min(cellfun('prodofsize',data_epoc.streams.(GRAB).filtered)); %checking length of GRAB 
ISO_fs=data_epoc.streams.(ISO).fs;
GRAB_fs=data_epoc.streams.(GRAB).fs;

data_epoc.streams.(ISO).filtered = cellfun(@(x) x(1:minLength1), data_epoc.streams.(ISO).filtered, 'UniformOutput',false); %makin all data the same length in ISO
data_epoc.streams.(GRAB).filtered = cellfun(@(x) x(1:minLength2), data_epoc.streams.(GRAB).filtered, 'UniformOutput',false); %making all data the same length in GRAB



Grab_stream=cell2mat(data_epoc.streams.(GRAB).filtered'); %converting signal from cell 2 mat and transposing 
ISO_stream=cell2mat(data_epoc.streams.(ISO).filtered'); %converting signal from cell 2 mat and transposing 

load(Behav_List)
dis_indx=find(dayofdata(:,13)==1);
clean_indx=find(dayofdata(:,13)==0);
dis_behav=dayofdata(dis_indx(1:104,:),1:12);
clean_behav=dayofdata(clean_indx,1:12);

clean_Grab_stream=Grab_stream(clean_indx,:);
clean_ISO_stream=ISO_stream(clean_indx,:);

dis_Grab_stream=Grab_stream(dis_indx(1:104,:),:);
dis_ISO_stream=ISO_stream(dis_indx(1:104,:),:);

[ToneMatrix_GRAB,ToneMatrix_ISO,ToneHitMatrix_GRAB,ToneHitMatrix_ISO,ToneFAMatrix_GRAB,ToneFAMatrix_ISO, ...
    HitMatrix_Clean_GRAB,HitMatrix_Clean_ISO,FAMatrix_Clean_GRAB,FAMatrix_Clean_ISO,RT_Clean_Hit,RT_Clean_FA, ...
    OctaveHitMatrix_GRAB,OctaveHitMatrix_ISO,OctaveFAMatrix_GRAB,OctaveFAMatrix_ISO,ToneHitRT,ToneFART,OctaveHitRT,OctaveFART]=med_assoc_sort_AD(clean_behav,clean_Grab_stream,clean_ISO_stream);

[ToneMatrix_GRAB,ToneMatrix_ISO,ToneHitMatrix_GRAB,ToneHitMatrix_ISO,ToneFAMatrix_GRAB,ToneFAMatrix_ISO, ...
    HitMatrix_Dist_GRAB,HitMatrix_Dist_ISO,FAMatrix_Dist_GRAB,FAMatrix_Dist_ISO,RT_Dist_Hit,RT_Dist_FA, ...
    OctaveHitMatrix_GRAB,OctaveHitMatrix_ISO,OctaveFAMatrix_GRAB,OctaveFAMatrix_ISO,ToneHitRT,ToneFART,OctaveHitRT,OctaveFART]=med_assoc_sort_AD(dis_behav,dis_Grab_stream,dis_ISO_stream);


Omiss_Distact_Rate=(105-length(RT_Dist_FA)-length(RT_Dist_Hit))/105;
Omiss_Clean_Rate=(105-length(RT_Clean_FA)-length(RT_Clean_Hit))/105;


FA_Distract_rate=(105-(Omiss_Distact_Rate*105)-length(RT_Dist_Hit))/105;
FA_Clean_rate=(105-(Omiss_Clean_Rate*105)-length(RT_Clean_Hit))/105;


% behav_plot=plot_phyc_curve(HitRate_Behav,3,'b',Animal_ID_Behav,Location);
% saveas(behav_plot,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" BehavCurve.fig")))



figure
graph_nocallout_individual(HitMatrix_Clean_GRAB, HitMatrix_Clean_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),RT_Clean_Hit,N,Animal_ID_Behav, ...
    "Clean",Probe_depth)
figure
graph_nocallout_individual(FAMatrix_Clean_GRAB, FAMatrix_Clean_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_Clean_FA,N,Animal_ID_Behav, ...
    "Clean",Probe_depth)
figure
graph_nocallout_individual(HitMatrix_Dist_GRAB, HitMatrix_Dist_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),RT_Dist_Hit,N,Animal_ID_Behav, ...
    "Dist",Probe_depth)
figure
graph_nocallout_individual(FAMatrix_Dist_GRAB, FAMatrix_Dist_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_Dist_FA,N,Animal_ID_Behav, ...
    "Dist",Probe_depth)

% saveas(gcf,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" Hits.fig")))

figure
graph_nocallout_individual(FAMatrix_GRAB, FAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_FA,N,Animal_ID_Behav, ...
    Condition,Probe_depth)

% saveas(gcf,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" False Alarms.fig")))





