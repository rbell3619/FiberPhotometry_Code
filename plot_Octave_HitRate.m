function plot_Octave_HitRate(HitRate_Laser,OctaveHitRate_Laser,a)
%Octave Hit Rate
tf=isa(OctaveHitRate_Laser,'cell');
if tf==1
NoOctave_Laser=cell2mat(OctaveHitRate_Laser(:,4));
else 
 NoOctave_Laser=OctaveHitRate_Laser;   
end
tf=isa(HitRate_Laser,'cell');
if tf==1
HitRate_Laser=cell2mat(HitRate_Laser);
end
WholeOctave_Laser=cat(1,(1-HitRate_Laser(:,1)),HitRate_Laser(:,7));
TwoThirdOctave_Laser=cat(1,(1-HitRate_Laser(:,2)),HitRate_Laser(:,6));
OneThirdOctave_Laser=cat(1,(1-HitRate_Laser(:,3)),HitRate_Laser(:,5));


FillerNoOct_Laser=NaN(length(NoOctave_Laser),1);
NoOctave_Laser=cat(1,NoOctave_Laser,FillerNoOct_Laser);
AllOctave_Laser=cat(2,WholeOctave_Laser,TwoThirdOctave_Laser,OneThirdOctave_Laser,NoOctave_Laser);
AvgAllOctave_Laser=mean(AllOctave_Laser,'omitnan');
for Octave=1:4
    SEOctave_Laser=((std(AllOctave_Laser,'omitnan'))/(sqrt(length(AllOctave_Laser(~isnan(AllOctave_Laser))))));
end
XOctave=[1,2/3,1/3,0];
figure
R1=errorbar(XOctave,AvgAllOctave_Laser,SEOctave_Laser,'LineWidth',a)
set(gca)
ylim([0 1])
xlabel('Octaves from Characteristic Frequency')
ylabel('Hit Rate')
end