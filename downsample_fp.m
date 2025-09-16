function  [GRAB_avg,minLength1]=downsample_fp(Grab_stream,N)

if N>1
GRAB_avg = zeros(size(Grab_stream(:,1:N:end-N+1))); %This matrix will be what I will index based on sound trails 
for ii = 1:size(Grab_stream,1) %Basicaly for 1 through each of the 210 trials 
    GRAB_avg(ii,:) =  arrayfun(@(i) mean(Grab_stream(ii,i:i+N-1)),1:N:length(Grab_stream)-N+1);
end
minLength1 = size(GRAB_avg,2); %New Length of GRAB signal after downsampling 

meanGRAB=mean(GRAB_avg); %mean overall signal
stdGRAB=std(double(GRAB_avg))/sqrt(size(GRAB_avg,1)); %calculating the STD 
dcGRAB=mean(meanGRAB); %Finding DC offset value

minLength2 = size(GRAB_avg,2); %New Length of GRAB signal after downsampling 

else
GRAB_avg=Grab_stream;

minLength1 = size(GRAB_avg,2);
meanGRAB=mean(GRAB_avg); %mean overall signal
stdGRAB=std(double(GRAB_avg))/sqrt(size(GRAB_avg,1)); %calculating the STD 
dcGRAB=mean(meanGRAB); %Finding DC offset value
end



end
