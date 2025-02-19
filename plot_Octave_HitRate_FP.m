function plot_Octave_HitRate_FP(HitRate,OctaveHitRate,a,ID_Behav)
%Octave Hit Rate
tf=isa(OctaveHitRate,'cell');
if tf==1
NoOctave=cell2mat(OctaveHitRate(:,4));
else 
 NoOctave=OctaveHitRate;   
end
tf=isa(HitRate,'cell');
if tf==1
HitRate=cell2mat(HitRate);
end
WholeOctave=cat(1,(1-HitRate(:,1)),HitRate(:,7));
TwoThirdOctave=cat(1,(1-HitRate(:,2)),HitRate(:,6));
OneThirdOctave=cat(1,(1-HitRate(:,3)),HitRate(:,5));


FillerNoOct=NaN(length(NoOctave),1);
NoOctave=cat(1,NoOctave,FillerNoOct);
AllOctave=cat(2,WholeOctave,TwoThirdOctave,OneThirdOctave,NoOctave);
AvgAllOctave=mean(AllOctave,'omitnan');
for Octave=1:4
    SEOctave=((std(AllOctave,'omitnan'))/(sqrt(length(AllOctave(~isnan(AllOctave))))));
end
XOctave=[1,2/3,1/3,0];
R1=errorbar(XOctave,AvgAllOctave,SEOctave,'LineWidth',a)
set(gca)
ylim([0 1])
xlabel("Octaves from Center Frequency"+ID_Behav)
ylabel('Hit Rate')
end