clear all;close all; clc;

% Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\WT\AD PFC\917-250823-142327"];%WT PFC AD Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\917\AD\2025-08-23Subj917.mat"]; %WT PFC AD Behav

% Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\FX\AD AUX\895-250905-132937"];%WT PFC VD Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\895\AD\2025-08-30Subj895.mat"]; %WT PFC VD Behav

% Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\FX\AD PFC\895-250902-145429"];%WT PFC VD Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\895\AD\2025-09-02Subj895.mat"]; %WT PFC VD Behav

% Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\FX\VD PFC\895-250909-154335"];%WT PFC VD Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\895\AD\2025-09-09Subj895.mat"]; %WT PFC VD Behav
% 
% Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\FX\AD AUX\896-250902-154635"];%WT PFC VD Tanks
% 
% Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\896\AD\2025-09-02Subj896.mat"]; %WT PFC VD Behav
Tank_List=["Y:\Rachael Bell\FP.ACh\Tanks\FX\VD AUX\896-250909-163613"];%WT PFC VD Tanks

Behav_List=["Y:\Rachael Bell\Extracted mFile Data\May2023-\896\AD\2025-09-09Subj896.mat"]; %WT PFC VD Behav

Animal_ID_Behav=extractBetween(Behav_List,"Subj",".");
perform_date=extractBetween(Behav_List,56,65); 
figurefile_path="Y:\Rachael Bell\FP.ACh\Individual Graphs\";
loc=[" PFC", " AUX"];
cond=[" Clean"," AD"," VD"];
depth_options=[" -1.95mm", " -1.65mm", "-.3mm",""];

Location=extractBetween(Tank_List(1),"VD","\");
Condition=cond(2);
Probe_depth=depth_options(4);

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
for i=1:length(Tank_List)
  data= TDTbin2mat(Tank_List{i}); %Load tank into work place
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

load(Behav_List{i})
dis_indx=find(dayofdata(:,13)==1);
clean_indx=find(dayofdata(:,13)==0);
dis_behav{i}=dayofdata(dis_indx(1:104),1:12);
clean_behav{i}=dayofdata(clean_indx(1:104),1:12);

clean_Grab_stream{i}=Grab_stream(clean_indx(1:102),:);
clean_ISO_stream{i}=ISO_stream(clean_indx(1:102),:);

dis_Grab_stream{i}=Grab_stream(dis_indx(1:102),:);
dis_ISO_stream{i}=ISO_stream(dis_indx(1:102),:);

[ToneMatrix_GRAB{i},ToneMatrix_ISO{i},ToneHitMatrix_Clean_GRAB{i},ToneHitMatrix_Clean_ISO{i},ToneFAMatrix_Clean_GRAB{i},ToneFAMatrix_Clean_ISO{i}, ...
    HitMatrix_Clean_GRAB{i},HitMatrix_Clean_ISO{i},FAMatrix_Clean_GRAB{i},FAMatrix_Clean_ISO{i},RT_Clean_Hit{i},RT_Clean_FA{i}, ...
    OctaveHitMatrix_Clean_GRAB{i},OctaveHitMatrix_Clean_ISO{i},OctaveFAMatrix_Clean_GRAB{i},OctaveFAMatrix_Clean_ISO{i},...
    ToneHitRT_Clean{i},ToneFART_Clean{i},OctaveHitRT_Clean{i},OctaveFART_Clean{i}]=med_assoc_sort_AD(clean_behav{i},clean_Grab_stream{i},clean_ISO_stream{i});

[ToneMatrix_GRAB{i},ToneMatrix_ISO{i},ToneHitMatrix_Dist_GRAB{i},ToneHitMatrix_Dist_ISO{i},ToneFAMatrix_Dist_GRAB{i},ToneFAMatrix_Dist_ISO{i}, ...
    HitMatrix_Dist_GRAB{i},HitMatrix_Dist_ISO{i},FAMatrix_Dist_GRAB{i},FAMatrix_Dist_ISO{i},RT_Dist_Hit{i},RT_Dist_FA{i}, ...
    OctaveHitMatrix_Dist_GRAB{i},OctaveHitMatrix_Dist_ISO{i},OctaveFAMatrix_Dist_GRAB{i},OctaveFAMatrix_Dist_ISO{i},ToneHitRT_Dist{i},...
    ToneFART_Dist{i},OctaveHitRT_Dist{i},OctaveFART_Dist{i}]=med_assoc_sort_AD(dis_behav{i},dis_Grab_stream{i},dis_ISO_stream{i});
end

% Omiss_Distact_Rate{i}=(105-length(RT_Dist_FA)-length(RT_Dist_Hit))/105;
% Omiss_Clean_Rate{i}=(105-length(RT_Clean_FA)-length(RT_Clean_Hit))/105;
% 
% 
% FA_Distract_rate=(105-(Omiss_Distact_Rate*105)-length(RT_Dist_Hit))/105;
% FA_Clean_rate=(105-(Omiss_Clean_Rate*105)-length(RT_Clean_Hit))/105;


% behav_plot=plot_phyc_curve(HitRate_Behav,3,'b',Animal_ID_Behav,Location);
% saveas(behav_plot,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" BehavCurve.fig")))
RT_Clean_Hit=cell2mat(RT_Clean_Hit');
RT_Clean_FA=cell2mat(RT_Clean_FA');

HitMatrix_Clean_GRAB=cell2mat(HitMatrix_Clean_GRAB');
HitMatrix_Clean_ISO=cell2mat(HitMatrix_Clean_ISO');

FAMatrix_Clean_GRAB=cell2mat(FAMatrix_Clean_GRAB');
FAMatrix_Clean_ISO=cell2mat(FAMatrix_Clean_ISO');

RT_Dist_Hit=cell2mat(RT_Dist_Hit');
RT_Dist_FA=cell2mat(RT_Dist_FA');

HitMatrix_Dist_GRAB=cell2mat(HitMatrix_Dist_GRAB');
HitMatrix_Dist_ISO=cell2mat(HitMatrix_Dist_ISO');

FAMatrix_Dist_GRAB=cell2mat(FAMatrix_Dist_GRAB');
FAMatrix_Dist_ISO=cell2mat(FAMatrix_Dist_ISO');

ToneHitMatrix_Clean_GRAB=Tone_Merge(ToneHitMatrix_Clean_GRAB);
ToneFAMatrix_Clean_GRAB=Tone_Merge(ToneFAMatrix_Clean_GRAB);

ToneHitMatrix_Dist_GRAB=Tone_Merge(ToneHitMatrix_Dist_GRAB);
ToneFAMatrix_Dist_GRAB=Tone_Merge(ToneFAMatrix_Dist_GRAB);

OctaveHitMatrix_Clean_GRAB=Octave_Merge(OctaveHitMatrix_Clean_GRAB);
OctaveFAMatrix_Clean_GRAB=Octave_Merge(OctaveFAMatrix_Clean_GRAB);

OctaveHitMatrix_Dist_GRAB=Octave_Merge(OctaveHitMatrix_Dist_GRAB);
OctaveFAMatrix_Dist_GRAB=Octave_Merge(OctaveFAMatrix_Dist_GRAB);
% figure
% graph_nocallout(HitMatrix_Clean_GRAB, HitMatrix_Clean_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),RT_Clean_Hit,N,Animal_ID_Behav, ...
%     "Clean")
% figure
% graph_nocallout(FAMatrix_Clean_GRAB, FAMatrix_Clean_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_Clean_FA,N,Animal_ID_Behav, ...
%     "Clean")
% figure
% graph_nocallout(HitMatrix_Dist_GRAB, HitMatrix_Dist_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(1),RT_Dist_Hit,N,Animal_ID_Behav, ...
%     "Dist")
% figure
% graph_nocallout(FAMatrix_Dist_GRAB, FAMatrix_Dist_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_Dist_FA,N,Animal_ID_Behav, ...
%     "Dist")

 graph_Tone_HitvFA(ToneHitMatrix_Clean_GRAB,ToneFAMatrix_Clean_GRAB,Epoc_Range,ISO_fs,ITI,Location," Clean",ToneHitRT_Clean,N,"",tone)
 graph_Tone_HitvFA(ToneHitMatrix_Dist_GRAB,ToneFAMatrix_Dist_GRAB,Epoc_Range,ISO_fs,ITI,Location," Dist",ToneHitRT_Dist,N,"",tone)

  graph_Octave_HitvFA(OctaveHitMatrix_Clean_GRAB,OctaveFAMatrix_Clean_GRAB,Epoc_Range,ISO_fs,ITI,Location," Clean",OctaveHitRT_Clean,N,"",octave_step)
  graph_Octave_HitvFA(OctaveHitMatrix_Dist_GRAB,OctaveFAMatrix_Dist_GRAB,Epoc_Range,ISO_fs,ITI,Location," Dist",OctaveHitRT_Dist,N,"",octave_step)

  graph_HitvFA(HitMatrix_Clean_GRAB,HitMatrix_Dist_GRAB,Epoc_Range,ISO_fs,ITI,Location," Clean Hit(r) vs Dist Hit(g)",RT_Clean_Hit,N,"",Condition)
  graph_Tone_HitvFA(ToneHitMatrix_Clean_GRAB,ToneHitMatrix_Dist_GRAB,Epoc_Range,ISO_fs,ITI,Location," Clean Hit(r) vs Dist Hit(g)",ToneHitRT_Dist,N,"",tone)
  graph_Octave_HitvFA(OctaveHitMatrix_Clean_GRAB,OctaveHitMatrix_Dist_GRAB,Epoc_Range,ISO_fs,ITI,Location," Clean Hit(r) vs Dist Hit(g)",OctaveHitRT_Clean,N,"",octave_step)
  
  % saveas(gcf,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" Hits.fig")))

% figure
% graph_nocallout_individual(FAMatrix_GRAB, FAMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,Location,type(2),RT_FA,N,Animal_ID_Behav, ...
%     Condition,Probe_depth)

% saveas(gcf,fullfile(figurefile_path,(Animal_ID_Behav+Location+Condition+perform_date+" False Alarms.fig")))





