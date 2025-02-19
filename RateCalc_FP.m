function  [FinalRTFA_Group2,FinalRTHits_Group2,HitRate_Group2,OctaveHitRate_Group2]=RateCalc_FP(Behav_List)

for subjectnumbers=1:length(Behav_List)
    load(Behav_List(subjectnumbers));
    subject=dayofdata; %calling matrix out of structure
        for NumberOfTones=1:7
              
        ind{NumberOfTones}=subject(:,1)==NumberOfTones;
        HitLeftRT_Group2{subjectnumbers,NumberOfTones}=(subject(ind{NumberOfTones},9));
        FALeftRT_Group2{subjectnumbers,NumberOfTones}=(subject(ind{NumberOfTones},10));
        HitRightRT_Group2{subjectnumbers,NumberOfTones}=(subject(ind{NumberOfTones},11));
        FARightRT_Group2{subjectnumbers,NumberOfTones}=(subject(ind{NumberOfTones},12));
        Hits_Group2{subjectnumbers,NumberOfTones}=[HitLeftRT_Group2{subjectnumbers,NumberOfTones};HitRightRT_Group2{subjectnumbers,NumberOfTones}];
        FA_Group2{subjectnumbers,NumberOfTones}=[FALeftRT_Group2{subjectnumbers,NumberOfTones};FARightRT_Group2{subjectnumbers,NumberOfTones}];
        FinalRTHits_Group2{subjectnumbers, NumberOfTones}=nonzeros(Hits_Group2{subjectnumbers,NumberOfTones});
        FinalRTFA_Group2{subjectnumbers, NumberOfTones}=nonzeros(FA_Group2{subjectnumbers,NumberOfTones});
        
        for NumberOfTones=1:3
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_Group2{subjectnumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_Group2{subjectnumbers,NumberOfTones}=sum(ToneArray_Group2{subjectnumbers,NumberOfTones});
            HitsLeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,2);
             HitsRight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,3);
             FALeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,4);
             FARight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,5);
             OmissLeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,6);
             OmissRight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,7);
             HitRate_Group2{subjectnumbers,NumberOfTones}=FALeft_Group2{subjectnumbers,NumberOfTones}/(FALeft_Group2{subjectnumbers,NumberOfTones}+HitsLeft_Group2{subjectnumbers,NumberOfTones});
        end
        for NumberOfTones=4
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_Group2{subjectnumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_Group2{subjectnumbers,NumberOfTones}=sum(ToneArray_Group2{subjectnumbers,NumberOfTones});
             HitsLeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,2);
             HitsRight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,3);
             FALeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,4);
             FARight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,5);
             OmissLeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,6);
             OmissRight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,7);
             HitRate_Group2{subjectnumbers,NumberOfTones}=(HitsRight_Group2{subjectnumbers,NumberOfTones}+FARight_Group2{subjectnumbers,NumberOfTones})/(HitsRight_Group2{subjectnumbers,NumberOfTones}+FARight_Group2{subjectnumbers,NumberOfTones}+(FALeft_Group2{subjectnumbers,NumberOfTones}+HitsLeft_Group2{subjectnumbers,NumberOfTones}));
             OctaveHitRate_Group2{subjectnumbers,NumberOfTones}=(HitsRight_Group2{subjectnumbers,NumberOfTones}+HitsLeft_Group2{subjectnumbers,NumberOfTones})/(HitsRight_Group2{subjectnumbers,NumberOfTones}+FARight_Group2{subjectnumbers,NumberOfTones}+(FALeft_Group2{subjectnumbers,NumberOfTones}+HitsLeft_Group2{subjectnumbers,NumberOfTones}));
        end
        for NumberOfTones=5:7
             ind{NumberOfTones}=subject(:,1)==NumberOfTones;
             ToneArray_Group2{subjectnumbers,NumberOfTones}=subject(ind{NumberOfTones},:);
             ArraySums_Group2{subjectnumbers,NumberOfTones}=sum(ToneArray_Group2{subjectnumbers,NumberOfTones});
            HitsLeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,2);
             HitsRight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,3);
             FALeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,4);
             FARight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,5);
             OmissLeft_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,6);
             OmissRight_Group2{subjectnumbers,NumberOfTones}=ArraySums_Group2{subjectnumbers,NumberOfTones}(:,7);
             HitRate_Group2{subjectnumbers,NumberOfTones}=HitsRight_Group2{subjectnumbers,NumberOfTones}/(FARight_Group2{subjectnumbers,NumberOfTones}+HitsRight_Group2{subjectnumbers,NumberOfTones});
        end
        end
end

end



