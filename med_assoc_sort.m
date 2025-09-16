function [ToneMatrix_GRAB,ToneMatrix_ISO,ToneRT,ToneHitMatrix_GRAB,ToneHitMatrix_ISO,ToneFAMatrix_GRAB,ToneFAMatrix_ISO, ...
    ITIMatrix_GRAB,ITIMatrix_ISO,HitMatrix_GRAB,HitMatrix_ISO,FAMatrix_GRAB,FAMatrix_ISO,RT_Hit,RT_FA, ...
    OctaveHitMatrix_GRAB,OctaveHitMatrix_ISO,OctaveFAMatrix_GRAB,OctaveFAMatrix_ISO,ITIHitMatrix_GRAB, ...
    ITIHitMatrix_ISO,ITIFAMatrix_GRAB,ITIFAMatrix_ISO,ToneHitRT,ToneFART,OctaveHitRT,OctaveFART,OctaveMatrix_GRAB,...
    OctaveMatrix_ISO,OctaveRT]=med_assoc_sort(dayofdata,Grab_stream,ISO_stream)
%ITIMatrix_GRAB,ITIMatrix_ISO,
for i=1:7
    index{i}=dayofdata(:,1)==i;
    ToneMatrix_GRAB{i}=Grab_stream(index{i},:);
    ToneMatrix_ISO{i}=ISO_stream(index{i},:);
    
    index{i}=and(dayofdata(:,1)==i,or((dayofdata(:,2)==1),(dayofdata(:,3)==1)));
    ToneHitMatrix_GRAB{i}=Grab_stream(index{i},:);
    ToneHitMatrix_ISO{i}=ISO_stream(index{i},:);
    RT_left_Hit=dayofdata(index{i},9);
    RT_right_Hit=dayofdata(index{i},11);
    ToneHitRT{i}=[nonzeros(RT_left_Hit);nonzeros(RT_right_Hit)];
    
    index{i}=and(dayofdata(:,1)==i,or((dayofdata(:,4)==1),(dayofdata(:,5)==1)));
    ToneFAMatrix_GRAB{i}=Grab_stream(index{i},:);
    ToneFAMatrix_ISO{i}=ISO_stream(index{i},:);
    RT_left_FA=dayofdata(index{i},10);
    RT_right_FA=dayofdata(index{i},12);
    ToneFART{i}=[nonzeros(RT_left_FA);nonzeros(RT_right_FA)];

    ToneRT{i}=[ToneHitRT{i};ToneFART{i}];
    
    index{i}=find(dayofdata(:,8)==i+8);
    index{i}=index{i}+1;
    index_out=~(index{i}==211);
    jump_out=index{i};
    index{i}=jump_out(index_out);
   
    ITIMatrix_GRAB{i}=Grab_stream(index{i},:);
    ITIMatrix_ISO{i}=ISO_stream(index{i},:);
    
    index{i}=find(dayofdata(:,8)==i+8 & or((dayofdata(:,2)==1),(dayofdata(:,3)==1)));
    index{i}=index{i}+1;
    index_out=~(index{i}==211);
    jump_out=index{i};
    index{i}=jump_out(index_out);
    ITIHitMatrix_GRAB{i}=Grab_stream(index{i},:);
    ITIHitMatrix_ISO{i}=ISO_stream(index{i},:);

    index{i}=find(dayofdata(:,8)==i+8 & or((dayofdata(:,4)==1),(dayofdata(:,5)==1)));
    index{i}=index{i}+1;
    index_out=~(index{i}==211);
    jump_out=index{i};
    index{i}=jump_out(index_out);
    ITIFAMatrix_GRAB{i}=Grab_stream(index{i},:);
    ITIFAMatrix_ISO{i}=ISO_stream(index{i},:);

end
for i=1:4
    for i=1
    Tone_A_GRAB=ToneHitMatrix_GRAB{1,i};
    Tone_B_GRAB=ToneHitMatrix_GRAB{1,i+6};
    Tone_A_ISO=ToneHitMatrix_ISO{1,i};
    Tone_B_ISO=ToneHitMatrix_ISO{1,i+6};
    OctaveHitMatrix_GRAB{i}=[Tone_A_GRAB;Tone_B_GRAB];
    OctaveHitMatrix_ISO{i}=[Tone_A_ISO;Tone_B_ISO];
    
    RT_A_Hit=ToneHitRT{1,i};
    RT_B_Hit=ToneHitRT{1,i+6};
    OctaveHitRT{i}=[RT_A_Hit;RT_B_Hit];
    
    
    Tone_A_GRAB=ToneFAMatrix_GRAB{1,i};
    Tone_B_GRAB=ToneFAMatrix_GRAB{1,i+6};
    Tone_A_ISO=ToneFAMatrix_ISO{1,i};
    Tone_B_ISO=ToneFAMatrix_ISO{1,i+6};
    OctaveFAMatrix_GRAB{i}=[Tone_A_GRAB;Tone_B_GRAB];
    OctaveFAMatrix_ISO{i}=[Tone_A_ISO;Tone_B_ISO];
    
    RT_A_FA=ToneFART{1,i};
    RT_B_FA=ToneFART{1,i+6};
    OctaveFART{i}=[RT_A_FA;RT_B_FA];

    OctaveRT{i}=[OctaveHitRT{i};OctaveFART{i}];
    OctaveMatrix_GRAB{i}=[OctaveHitMatrix_GRAB{i};OctaveFAMatrix_GRAB{i}];
    OctaveMatrix_ISO{i}=[OctaveHitMatrix_ISO{i};OctaveFAMatrix_ISO{i}];
    end
    
    for i=2
    Tone_A_GRAB=ToneHitMatrix_GRAB{1,i};
    Tone_B_GRAB=ToneHitMatrix_GRAB{1,i+4};
    Tone_A_ISO=ToneHitMatrix_ISO{1,i};
    Tone_B_ISO=ToneHitMatrix_ISO{1,i+4};
    OctaveHitMatrix_GRAB{i}=[Tone_A_GRAB;Tone_B_GRAB];
    OctaveHitMatrix_ISO{i}=[Tone_A_ISO;Tone_B_ISO];
    
    RT_A_Hit=ToneHitRT{1,i};
    RT_B_Hit=ToneHitRT{1,i+4};
    OctaveHitRT{i}=[RT_A_Hit;RT_B_Hit];
    
    Tone_A_GRAB=ToneFAMatrix_GRAB{1,i};
    Tone_B_GRAB=ToneFAMatrix_GRAB{1,i+4};
    Tone_A_ISO=ToneFAMatrix_ISO{1,i};
    Tone_B_ISO=ToneFAMatrix_ISO{1,i+4};
    OctaveFAMatrix_GRAB{i}=[Tone_A_GRAB;Tone_B_GRAB];
    OctaveFAMatrix_ISO{i}=[Tone_A_ISO;Tone_B_ISO];
    
    RT_A_FA=ToneFART{1,i};
    RT_B_FA=ToneFART{1,i+4};
    OctaveFART{i}=[RT_A_FA;RT_B_FA];

    OctaveRT{i}=[OctaveHitRT{i};OctaveFART{i}];
    OctaveMatrix_GRAB{i}=[OctaveHitMatrix_GRAB{i};OctaveFAMatrix_GRAB{i}];
    OctaveMatrix_ISO{i}=[OctaveHitMatrix_ISO{i};OctaveFAMatrix_ISO{i}];
    end
    
    for i=3
    Tone_A_GRAB=ToneHitMatrix_GRAB{1,i};
    Tone_B_GRAB=ToneHitMatrix_GRAB{1,i+2};
    Tone_A_ISO=ToneHitMatrix_ISO{1,i};
    Tone_B_ISO=ToneHitMatrix_ISO{1,i+2};
    OctaveHitMatrix_GRAB{i}=[Tone_A_GRAB;Tone_B_GRAB];
    OctaveHitMatrix_ISO{i}=[Tone_A_ISO;Tone_B_ISO];
    
    RT_A_Hit=ToneHitRT{1,i};
    RT_B_Hit=ToneHitRT{1,i+2};
    OctaveHitRT{i}=[RT_A_Hit;RT_B_Hit];
    
    Tone_A_GRAB=ToneFAMatrix_GRAB{1,i};
    Tone_B_GRAB=ToneFAMatrix_GRAB{1,i+2};
    Tone_A_ISO=ToneFAMatrix_ISO{1,i};
    Tone_B_ISO=ToneFAMatrix_ISO{1,i+2};
    OctaveFAMatrix_GRAB{i}=[Tone_A_GRAB;Tone_B_GRAB];
    OctaveFAMatrix_ISO{i}=[Tone_A_ISO;Tone_B_ISO];
    
    RT_A_FA=ToneFART{1,i};
    RT_B_FA=ToneFART{1,i+2};
    OctaveFART{i}=[RT_A_FA;RT_B_FA];

    OctaveRT{i}=[OctaveHitRT{i};OctaveFART{i}];
    OctaveMatrix_GRAB{i}=[OctaveHitMatrix_GRAB{i};OctaveFAMatrix_GRAB{i}];
    OctaveMatrix_ISO{i}=[OctaveHitMatrix_ISO{i};OctaveFAMatrix_ISO{i}];
    end
    
    for i=4
    Tone_A_GRAB=ToneHitMatrix_GRAB{1,i};
    
    Tone_A_ISO=ToneHitMatrix_ISO{1,i};
    
    OctaveHitMatrix_GRAB{i}=[Tone_A_GRAB];
    OctaveHitMatrix_ISO{i}=[Tone_A_ISO];
    
    RT_A_Hit=ToneHitRT{1,i};
    OctaveHitRT{i}=[RT_A_Hit];
    
    Tone_A_GRAB=ToneFAMatrix_GRAB{1,i};
    Tone_A_ISO=ToneFAMatrix_ISO{1,i};
    
    OctaveFAMatrix_GRAB{i}=[Tone_A_GRAB];
    OctaveFAMatrix_ISO{i}=[Tone_A_ISO];
    
    RT_A_FA=ToneFART{1,i};
    OctaveFART{i}=[RT_A_FA];

    OctaveRT{i}=[OctaveHitRT{i};OctaveFART{i}];

    OctaveMatrix_GRAB{i}=[OctaveHitMatrix_GRAB{i};OctaveFAMatrix_GRAB{i}];
    OctaveMatrix_ISO{i}=[OctaveHitMatrix_ISO{i};OctaveFAMatrix_ISO{i}];
    end
    
        
end


    index=or(dayofdata(:,2)==1,dayofdata(:,3)==1);
    HitMatrix_GRAB=Grab_stream(index,:);
    HitMatrix_ISO=ISO_stream(index,:);
        
    index=or(dayofdata(:,4)==1,dayofdata(:,5)==1);
    FAMatrix_GRAB=Grab_stream(index,:);
    FAMatrix_ISO=ISO_stream(index,:); 

    index=dayofdata(:,9)>0;
    RT_left_Hit=dayofdata(index,9);
    index=dayofdata(:,11)>0;
    RT_right_Hit=dayofdata(index,11);
    RT_Hit=[RT_left_Hit;RT_right_Hit];
    
    index=dayofdata(:,10)>0;
    RT_left_FA=dayofdata(index,10);
    index=dayofdata(:,12)>0;
    RT_right_FA=dayofdata(index,12);
    RT_FA=[RT_left_FA;RT_right_FA];

   
end
