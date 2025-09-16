function [ToneMatrix_GRAB,ToneMatrix_ISO,ToneRT,ToneHitMatrix_GRAB,ToneHitMatrix_ISO,ToneFAMatrix_GRAB,ToneFAMatrix_ISO,ITIMatrix_GRAB,ITIMatrix_ISO,...
    HitMatrix_GRAB,HitMatrix_ISO,FAMatrix_GRAB,FAMatrix_ISO,RT_Hit,RT_FA,OctaveHitMatrix_GRAB,OctaveHitMatrix_ISO,OctaveFAMatrix_GRAB,OctaveFAMatrix_ISO,...
    ITIHitMatrix_GRAB,ITIHitMatrix_ISO,ITIFAMatrix_GRAB,ITIFAMatrix_ISO,ToneHitRT,ToneFART,OctaveHitRT,OctaveFART,OctaveMatrix_GRAB,OctaveMatrix_ISO,OctaveRT]=Filter_Tone_Behav(data,Trial_Counter,Epoc_Range,GRAB,ISO,Behav_List)

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
% dis_indx=find(dayofdata(:,13)==1);
% clean_indx=find(dayofdata(:,13)==0);
% dis_behav=dayofdata(dis_indx,1:12);
% clean_behav=dayofdata(clean_indx,1:12);


[ToneMatrix_GRAB,ToneMatrix_ISO,ToneRT,ToneHitMatrix_GRAB,ToneHitMatrix_ISO,ToneFAMatrix_GRAB,ToneFAMatrix_ISO, ...
    ITIMatrix_GRAB,ITIMatrix_ISO,HitMatrix_GRAB,HitMatrix_ISO,FAMatrix_GRAB,FAMatrix_ISO,RT_Hit,RT_FA, ...
    OctaveHitMatrix_GRAB,OctaveHitMatrix_ISO,OctaveFAMatrix_GRAB,OctaveFAMatrix_ISO,ITIHitMatrix_GRAB, ...
    ITIHitMatrix_ISO,ITIFAMatrix_GRAB,ITIFAMatrix_ISO,ToneHitRT,ToneFART,OctaveHitRT,OctaveFART,OctaveMatrix_GRAB,OctaveMatrix_ISO,OctaveRT]=med_assoc_sort(dayofdata,Grab_stream,ISO_stream);
end

