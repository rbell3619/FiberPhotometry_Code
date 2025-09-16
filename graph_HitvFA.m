function graph_HitvFA(HitMatrix_GRAB,FA_Matrix_GRAB,Epoc_Range,ISO_fs,ITI,loc,type,RT_Hits,N,Animal_ID,Condition)
figure
tiledlayout('vertical')
Grab_stream_Hit=HitMatrix_GRAB;
Grab_stream_FA=FA_Matrix_GRAB;

 [GRAB_avg_hit,minLength2_hit]=downsample_fp(Grab_stream_Hit,N);
 [GRAB_avg_FA,minLength2_FA]=downsample_fp(Grab_stream_FA,N);

 ts2 = Epoc_Range(1) + (1:minLength2_hit) / ISO_fs*N;%ISO time vector for plotting 

[Master_Matrix_Hit,zerror_Hit]=zscore_fp(GRAB_avg_hit,ITI,ts2);
[Master_Matrix_FA,zerror_FA]=zscore_fp(GRAB_avg_FA,ITI,ts2);
 
    XX = [ts2, fliplr(ts2)];
    YY_hit = [Master_Matrix_Hit-zerror_Hit, fliplr(Master_Matrix_Hit+zerror_Hit)];
    YY_FA = [Master_Matrix_FA-zerror_FA, fliplr(Master_Matrix_FA+zerror_FA)];

    nexttile 
    hold on;
    plot(ts2, Master_Matrix_Hit, 'color','r', 'LineWidth', 3); 
    plot(ts2, Master_Matrix_FA, 'color',[.8 .8 .8], 'LineWidth', 3); 
   
    line([0 0], [-20 ,20], 'Color', 'k', 'LineWidth', 2)
    line([mean(RT_Hits)+.5 mean(RT_Hits)+.5],[-20 ,20], 'Color', 'g', 'LineWidth', 2)
    
    
    h_hit = fill(XX, YY_hit, 'r');
    set(h_hit, 'facealpha',.25,'edgecolor','none')

    h_FA = fill(XX, YY_FA, [.8 .8 .8]);
    set(h_FA, 'facealpha',.25,'edgecolor','none')

    % Finish up the plot
    axis tight
    ylim([-2.5 1.5])
    xlim([-1,6])
    xlabel('Time, s','FontSize',24)
    ylabel('Z-score', 'FontSize', 24)
    title("Normalized Response Around Tone Onset"+loc+type+Condition,Animal_ID,'FontSize',30)


end
