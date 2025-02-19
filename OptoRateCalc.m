function [FinalRTHits_Laser,FinalRTHits_NonLaser,FinalRTFA_Laser,FinalRTFA_NonLaser,HitRate_Laser,HitRate_NonLaser,OctaveHitRate_Laser,OctaveHitRate_NonLaser,Omission_All_Laser,Omission_All_NonLaser]=OptoRateCalc(lengthf,data)
%Seperates Laser Trials and Nonlaser Trials and caculates reaction time for
%false alarms and hits,as well as hit rate for each tone
for LaserTrialNumbers=1:lengthf-2 %Seperating Laser Trials and non laser trials
LaserTrials={};
NonLaserTrials={};
subject=data{1,LaserTrialNumbers}.dayofdata;
LaserIndex=subject(:,13)==1;
LaserTrials{LaserTrialNumbers}=(subject(LaserIndex,:));
NonLaserTrials{LaserTrialNumbers}=subject(~LaserIndex,:);
length_LaserTrial=size(LaserTrials,2);
length_NonLaserTrial=size(NonLaserTrials,2);
for LaserTrialNumbers=1:length_LaserTrial %Laser Trials
    subject=LaserTrials{1,LaserTrialNumbers};
end
    for NumberOfTones=1:7 %Reaction time for Laser Trials
        ind{NumberOfTones}=subject(:,1)==NumberOfTones;
        HitLeftRT_Laser{LaserTrialNumbers,NumberOfTones}=(subject(ind{NumberOfTones},9));
        FALeftRT_Laser{LaserTrialNumbers,NumberOfTones}=(subject(ind{NumberOfTones},10));
        HitRightRT_Laser{LaserTrialNumbers,NumberOfTones}=(subject(ind{NumberOfTones},11));
        FARightRT_Laser{LaserTrialNumbers,NumberOfTones}=(subject(ind{NumberOfTones},12));
        Hits_RT_Laser{LaserTrialNumbers,NumberOfTones}=[HitLeftRT_Laser{LaserTrialNumbers,NumberOfTones};HitRightRT_Laser{LaserTrialNumbers,NumberOfTones}];
        FA_RT_Laser{LaserTrialNumbers,NumberOfTones}=[FALeftRT_Laser{LaserTrialNumbers,NumberOfTones};FARightRT_Laser{LaserTrialNumbers,NumberOfTones}];
        FinalRTHits_Laser{LaserTrialNumbers, NumberOfTones}=nonzeros(Hits_RT_Laser{LaserTrialNumbers,NumberOfTones});
        FinalRTFA_Laser{LaserTrialNumbers, NumberOfTones}=nonzeros(FA_RT_Laser{LaserTrialNumbers,NumberOfTones});
    end
     for NumberOfTones=1:3 
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_Laser{LaserTrialNumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_Laser{LaserTrialNumbers,NumberOfTones}=sum(ToneArray_Laser{LaserTrialNumbers,NumberOfTones});
            HitsLeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,2);
             HitsRight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,3);
             FALeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,4);
             FARight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,5);
             OmissLeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,6);
             OmissRight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,7);
             HitRate_Laser{LaserTrialNumbers,NumberOfTones}=FALeft_Laser{LaserTrialNumbers,NumberOfTones}/(FALeft_Laser{LaserTrialNumbers,NumberOfTones}+HitsLeft_Laser{LaserTrialNumbers,NumberOfTones});
     end
        for NumberOfTones=4
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_Laser{LaserTrialNumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_Laser{LaserTrialNumbers,NumberOfTones}=sum(ToneArray_Laser{LaserTrialNumbers,NumberOfTones});
             HitsLeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,2);
             HitsRight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,3);
             FALeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,4);
             FARight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,5);
             OmissLeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,6);
             OmissRight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,7);
             HitRate_Laser{LaserTrialNumbers,NumberOfTones}=(HitsRight_Laser{LaserTrialNumbers,NumberOfTones}+FARight_Laser{LaserTrialNumbers,NumberOfTones})/(HitsRight_Laser{LaserTrialNumbers,NumberOfTones}+FARight_Laser{LaserTrialNumbers,NumberOfTones}+(FALeft_Laser{LaserTrialNumbers,NumberOfTones}+HitsLeft_Laser{LaserTrialNumbers,NumberOfTones}));
             OctaveHitRate_Laser{LaserTrialNumbers,NumberOfTones}=(HitsRight_Laser{LaserTrialNumbers,NumberOfTones}+HitsLeft_Laser{LaserTrialNumbers,NumberOfTones})/(HitsRight_Laser{LaserTrialNumbers,NumberOfTones}+FARight_Laser{LaserTrialNumbers,NumberOfTones}+(FALeft_Laser{LaserTrialNumbers,NumberOfTones}+HitsLeft_Laser{LaserTrialNumbers,NumberOfTones}));
        end
        
       
        for NumberOfTones=5:7
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_Laser{LaserTrialNumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_Laser{LaserTrialNumbers,NumberOfTones}=sum(ToneArray_Laser{LaserTrialNumbers,NumberOfTones});
            HitsLeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,2);
             HitsRight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,3);
             FALeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,4);
             FARight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,5);
             OmissLeft_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,6);
             OmissRight_Laser{LaserTrialNumbers,NumberOfTones}=ArraySums_Laser{LaserTrialNumbers,NumberOfTones}(:,7);
             HitRate_Laser{LaserTrialNumbers,NumberOfTones}=HitsRight_Laser{LaserTrialNumbers,NumberOfTones}/(FARight_Laser{LaserTrialNumbers,NumberOfTones}+HitsRight_Laser{LaserTrialNumbers,NumberOfTones});
        end


for NonLaserTrialNumbers=1:length_NonLaserTrial
    subject=NonLaserTrials{1,NonLaserTrialNumbers};
end
     for NumberOfTones=1:7 %Reaction time for NonLaser Trials
        ind{NumberOfTones}=subject(:,1)==NumberOfTones;
        HitLeftRT_NonLaser{NonLaserTrialNumbers,NumberOfTones}=(subject(ind{NumberOfTones},9));
        FALeftRT_NonLaser{NonLaserTrialNumbers,NumberOfTones}=(subject(ind{NumberOfTones},10));
        HitRightRT_NonLaser{NonLaserTrialNumbers,NumberOfTones}=(subject(ind{NumberOfTones},11));
        FARightRT_NonLaser{NonLaserTrialNumbers,NumberOfTones}=(subject(ind{NumberOfTones},12));
        Hits_RT_NonLaser{NonLaserTrialNumbers,NumberOfTones}=[HitLeftRT_NonLaser{NonLaserTrialNumbers,NumberOfTones};HitRightRT_NonLaser{NonLaserTrialNumbers,NumberOfTones}];
        FA_RT_NonLaser{NonLaserTrialNumbers,NumberOfTones}=[FALeftRT_NonLaser{NonLaserTrialNumbers,NumberOfTones};FARightRT_NonLaser{NonLaserTrialNumbers,NumberOfTones}];
        FinalRTHits_NonLaser{NonLaserTrialNumbers, NumberOfTones}=nonzeros(Hits_RT_NonLaser{NonLaserTrialNumbers,NumberOfTones});
        FinalRTFA_NonLaser{NonLaserTrialNumbers, NumberOfTones}=nonzeros(FA_RT_NonLaser{NonLaserTrialNumbers,NumberOfTones});
     end

     for NumberOfTones=1:3 %Right HitRate For NonLaser Trials
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_NonLaser{NonLaserTrialNumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}=sum(ToneArray_NonLaser{NonLaserTrialNumbers,NumberOfTones});
            HitsLeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,2);
             HitsRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,3);
             FALeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,4);
             FARight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,5);
             OmissLeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,6);
             OmissRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,7);
             HitRate_NonLaser{NonLaserTrialNumbers,NumberOfTones}=FALeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}/(FALeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}+HitsLeft_NonLaser{NonLaserTrialNumbers,NumberOfTones});
     end
        for NumberOfTones=4
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_NonLaser{NonLaserTrialNumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}=sum(ToneArray_NonLaser{NonLaserTrialNumbers,NumberOfTones});
             HitsLeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,2);
             HitsRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,3);
             FALeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,4);
             FARight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,5);
             OmissLeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,6);
             OmissRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,7);
             HitRate_NonLaser{NonLaserTrialNumbers,NumberOfTones}=(HitsRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}+FARight_NonLaser{NonLaserTrialNumbers,NumberOfTones})/(HitsRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}+FARight_NonLaser{NonLaserTrialNumbers,NumberOfTones}+(FALeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}+HitsLeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}));
             OctaveHitRate_NonLaser{LaserTrialNumbers,NumberOfTones}=(HitsRight_NonLaser{LaserTrialNumbers,NumberOfTones}+HitsLeft_NonLaser{LaserTrialNumbers,NumberOfTones})/(HitsRight_NonLaser{LaserTrialNumbers,NumberOfTones}+FARight_NonLaser{LaserTrialNumbers,NumberOfTones}+(FALeft_NonLaser{LaserTrialNumbers,NumberOfTones}+HitsLeft_NonLaser{LaserTrialNumbers,NumberOfTones}));
        end
       
        for NumberOfTones=5:7
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_NonLaser{NonLaserTrialNumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}=sum(ToneArray_NonLaser{NonLaserTrialNumbers,NumberOfTones});
            HitsLeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,2);
             HitsRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,3);
             FALeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,4);
             FARight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,5);
             OmissLeft_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,6);
             OmissRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}=ArraySums_NonLaser{NonLaserTrialNumbers,NumberOfTones}(:,7);
             HitRate_NonLaser{NonLaserTrialNumbers,NumberOfTones}=HitsRight_NonLaser{NonLaserTrialNumbers,NumberOfTones}/(FARight_NonLaser{NonLaserTrialNumbers,NumberOfTones}+HitsRight_NonLaser{NonLaserTrialNumbers,NumberOfTones});
        end

end
Omission_All_Laser=cellfun(@plus,OmissLeft_Laser,OmissRight_Laser,'Uni',0);
Omission_All_NonLaser=cellfun(@plus,OmissLeft_NonLaser,OmissRight_NonLaser,'Uni',0);