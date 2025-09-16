function [AUC,Amp]=Masterlist_Calc_Octave(Master_Call_Matrix,N,Epoc_Range,ISO_fs,ITI,Masterlist_ID,type,Location,RT)

for a=1:length(Master_Call_Matrix)
Grab=Master_Call_Matrix{a};
RT_sub=RT{a};
for b=1:4
    Grab_stream=Grab{b};
    RT_oct=RT_sub{b};
if N>1
GRAB_avg = zeros(size(Grab_stream(:,1:N:end-N+1))); %This matrix will be what I will index based on sound trails 
for ii = 1:size(Grab_stream,1) %Basicaly for 1 through each of the 210 trials 
    GRAB_avg(ii,:) =  arrayfun(@(i) mean(Grab_stream(ii,i:i+N-1)),1:N:length(Grab_stream)-N+1);
end
minLength1 = size(GRAB_avg,2); %New Length of GRAB signal after downsampling



else
GRAB_avg=Grab_stream;
minLength1 = size(GRAB_avg,2);

end

 ts2 = Epoc_Range(1) + (1:minLength1) / ISO_fs*N;%ISO time vector for plotting 
   


zall = zeros(size(GRAB_avg)); 
for i = 1:size(GRAB_avg,1)
    ind = ts2(1,:) < ITI(2) & ts2(1,:) > ITI(1);
    zb = mean(GRAB_avg(i,ind)); % baseline period mean (-12sec to -9sec)
    zsd = std(GRAB_avg(i,ind)); % baseline period stdev
    zall(i,:)=(GRAB_avg(i,:) - zb)/zsd; % Z score per bin
end

if height(zall)==1
    Master_Matrix=zall;
else
Master_Matrix=mean(zall);
end
min_val=min(abs(ts2));
zero_idx=abs(ts2)==min_val;
zero_val=Master_Matrix(zero_idx);
Master_Matrix=Master_Matrix-zero_val;


if Location==" PFC"
Response=Master_Matrix(:,ts2(1,:) <=2 & ts2(1,:) >=0);
Reward=Master_Matrix(:,ts2(1,:) <=5 & ts2(1,:) >=2);
Response_AUC(a,b)=sum(Response(Response>0));
Reward_AUC(a,b)=sum(Reward(Reward<0));
Max_amp(a,b)=max(Response);
min_amp(a,b)=min(Reward);

else
Response=Master_Matrix(:,ts2(1,:) <=mean(RT_oct+.5) & ts2(1,:) >=0);
Reward=Master_Matrix(:,ts2(1,:) <=5 & ts2(1,:) >= mean(RT_oct+.5));
Response_AUC(a,b)=sum(Response(Response>0));
Reward_AUC(a,b)=sum(Reward(Reward<0));
Max_amp(a,b)=max(Response);
min_amp(a,b)=min(Reward);
end



end
end

AUC_type=["Cue_AUC","Reward_AUC"];
Amp_type=["Peak_Amp","Peak_Trough"];
octave_step=[" 1 Octave Diff"," 2/3 Octave Diff"," 1/3 Octave Diff"," 0 Octave Diff"];

for a= 1:length(Masterlist_ID)
    for b=1:4
    Response_AUC_Sub(b,:)=[Masterlist_ID(a),Location,type,octave_step(b),AUC_type(1),Response_AUC(a,b)];
    Reward_AUC_Sub(b,:)=[Masterlist_ID(a),Location,type,octave_step(b),AUC_type(2),Reward_AUC(a,b)];

    Amp_Max_Sub(b,:)=[Masterlist_ID(a),Location,type,octave_step(b),Amp_type(1),Max_amp(a,b)];
    Amp_Min_Sub(b,:)=[Masterlist_ID(a),Location,type,octave_step(b),Amp_type(2),min_amp(a,b)];
    end 
    Response_AUC_Master{a,:}=Response_AUC_Sub;
    Reward_AUC_Master{a,:}=Reward_AUC_Sub;
    Amp_max{a,:}=Amp_Max_Sub;
    Amp_min{a,:}=Amp_Min_Sub;
   


end
AUC=[vertcat(Response_AUC_Master{:});vertcat(Reward_AUC_Master{:})];
Amp=[vertcat(Amp_max{:});vertcat(Amp_min{:})];

end


% Positive_Matrix=Master_Matrix(:,ts2(1,:) <=2 & ts2(1,:) >=0);
% Negative_Matrix=Master_Matrix(:,ts2(1,:) <=5 & ts2(1,:) >=0);
% ts3 = 0 + (1:size(Positive_Matrix,2)) / ISO_fs*N;
% ts4=0 + (1:size(Negative_Matrix,2)) / ISO_fs*N;
% 
% 
% min_val=min(abs(ts3));
% zero_idx=abs(ts3)==min_val;
% zero_val=Positive_Matrix(zero_idx);
% 
% 
% Adj_Positive=Positive_Matrix-zero_val;
% 
% Adj_Negative=Negative_Matrix-zero_val;
% Pos_AUC(a,1)=trapz(Adj_Negative(:,ts4(1,:) <=2 & ts4(1,:) >=0 ));
% Neg_AUC(a,1)=trapz(Adj_Negative(:,ts4(1,:) >=2 & ts4(1,:) <=5));

% grid on
% figure 
% plot(ts3,Adj_Positive)
% title(Masterlist_ID(a)+type+"Postive AUC Window")
% 
% grid on
% figure
% plot(ts4,Adj_Negative)
% title(Masterlist_ID(a)+type+"Negative AUC Window")

% Pos_AUC(a,1)=sum(Adj_Positive(Adj_Positive>0));
% Neg_AUC(a,1)=sum(Adj_Negative(Adj_Negative<0));
% 