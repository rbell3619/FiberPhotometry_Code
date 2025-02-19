function graph_octavecallout(ToneHitMatrix_GRAB, ToneHitMatrix_ISO,Epoc_Range,GRAB_fs,ISO_fs,ITI,loc,type,tone,ToneHitRT,N,Animal_ID)
figure
m=tiledlayout(3,4);
m.TileIndexing='columnmajor';
m.TileSpacing="tight";

for a=1:4
Grab_stream =ToneHitMatrix_GRAB{a};
ISO_stream=ToneHitMatrix_ISO{a};

if N>1
GRAB_avg = zeros(size(Grab_stream(:,1:N:end-N+1))); %This matrix will be what I will index based on sound trails 
for ii = 1:size(Grab_stream,1) %Basicaly for 1 through each of the 210 trials 
    GRAB_avg(ii,:) =  arrayfun(@(i) mean(Grab_stream(ii,i:i+N-1)),1:N:length(Grab_stream)-N+1);
end
minLength1 = size(GRAB_avg,2); %New Length of GRAB signal after downsampling 

meanGRAB=mean(GRAB_avg); %mean overall signal
stdGRAB=std(double(GRAB_avg))/sqrt(size(GRAB_avg,1)); %calculating the STD 
dcGRAB=mean(meanGRAB); %Finding DC offset value

ISO_avg = zeros(size(ISO_stream(:,1:N:end-N+1))); %This matrix will be what I will index based on sound trails 
for ii = 1:size(ISO_stream,1) %Basicaly for 1 through each of the 210 trials 
    ISO_avg(ii,:) =  arrayfun(@(i) mean(ISO_stream(ii,i:i+N-1)),1:N:length(ISO_stream)-N+1);
end
minLength2 = size(ISO_avg,2); %New Length of GRAB signal after downsampling 

meanISO=mean(ISO_avg); %mean overall signal
stdISO=std(double(ISO_avg))/sqrt(size(ISO_avg,1)); %calculating the STD 
dcISO=mean(meanISO); %Finding DC offset value
else
GRAB_avg=Grab_stream;
ISO_avg=ISO_stream;
minLength1 = size(GRAB_avg,2);
minLength2 = size(ISO_avg,2); %New Length of GRAB signal after downsampling %New Length of GRAB signal after downsampling 
meanGRAB=mean(GRAB_avg); %mean overall signal
stdGRAB=std(double(GRAB_avg))/sqrt(size(GRAB_avg,1)); %calculating the STD 
dcGRAB=mean(meanGRAB); %Finding DC offset value
meanISO=mean(ISO_avg); %mean overall signal
stdISO=std(double(ISO_avg))/sqrt(size(ISO_avg,1)); %calculating the STD 
dcISO=mean(meanISO); %Finding DC offset value
end


    nexttile
    ts1 = Epoc_Range(1) + (1:minLength1) / GRAB_fs*N;%GRAB time bector for plotting 
    ts2 = Epoc_Range(1) + (1:minLength2) / ISO_fs*N;%ISO time vector for plotting 

 
    meanGRAB_NoDC=meanGRAB-dcGRAB;%removing DC offset so they plot on top of one another
    meanISO_NoDC=meanISO-dcISO;

    plot(ts1, meanGRAB_NoDC, 'color',[0.4660, 0.6740, 0.1880], 'LineWidth', 3); 
    hold on;
    plot(ts2, meanISO_NoDC, 'color',[0.8500, 0.3250, 0.0980], 'LineWidth', 3);
    axis tight
    legend('GRAB','ISO','FontSize',10,'Location','southeast')
    xlabel('Time, s','FontSize',10)
    ylabel('mV', 'FontSize', 10)
    title("Average Tone Response"+loc+tone{a}+type,'FontSize',10)
    hold off
   
 
zall = zeros(size(GRAB_avg)); 
for i = 1:size(GRAB_avg,1)
    ind = ts2(1,:) < ITI(2) & ts2(1,:) > ITI(1);
    zb = mean(GRAB_avg(i,ind)); % baseline period mean (-12sec to -9sec)
    zsd = std(GRAB_avg(i,ind)); % baseline period stdev
    zall(i,:)=(GRAB_avg(i,:) - zb)/zsd; % Z score per bin
end
zerror = std(zall)/sqrt(size(zall,1));
   
    nexttile
    imagesc(ts2, 1, zall);
    colormap('jet'); 
    %c1 = colorbar;
    caxis([-5 5]);
    title('z-score heatmap','FontSize',10)
    ylabel('Trials', 'FontSize', 10);
 
   
 
    XX = [ts2, fliplr(ts2)];
    YY = [mean(zall)-zerror, fliplr(mean(zall)+zerror)];
    nexttile
    plot(ts2, mean(zall), 'color',[0.8500, 0.3250, 0.0980], 'LineWidth', 3); 
    hold on;
    line([0 0], [-2.5 ,1.5], 'Color', [.7 .7 .7], 'LineWidth', 2)
    line([mean(ToneHitRT{a}) mean(ToneHitRT{a})],[-2.5 ,1.5], 'Color', 'b', 'LineWidth', 2)
   
    
    h = fill(XX, YY, 'r');
    set(h, 'facealpha',.25,'edgecolor','none')

    % Finish up the plot
    axis tight
   ylim([-2.5 1.5])
    xlabel('Time, s','FontSize',10)
    ylabel('Z-score', 'FontSize', 10)
    title(["Response Around Tone Onset",loc+tone{a}+type,Animal_ID],'FontSize',10)
end


end
