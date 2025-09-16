function [AUC,Amp]=Masterlist_Calc(Master_Call_Matrix,N,Epoc_Range,ISO_fs,ITI,Masterlist_ID,type,Location,RT)

for a=1:length(Master_Call_Matrix)
Grab_stream =Master_Call_Matrix{a};

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


Master_Matrix=mean(zall);
min_val=min(abs(ts2));
zero_idx=abs(ts2)==min_val;
zero_val=Master_Matrix(zero_idx);
Master_Matrix=Master_Matrix-zero_val;


if Location==" PFC"
Response=Master_Matrix(:,ts2(1,:) <=2 & ts2(1,:) >=0);
figure
plot(Response)
title("Response"+Masterlist_ID(a)+type+Location)
Reward=Master_Matrix(:,ts2(1,:) <=5 & ts2(1,:) >=2);
figure
plot(Reward)
title("Reward "+Masterlist_ID(a)+type+Location)
Response_AUC(a)=sum(Response(Response>0));
Reward_AUC(a)=sum(Reward(Reward<0));
Max_amp(a,1)=max(Response);
min_amp(a,1)=min(Reward);

else
Response=Master_Matrix(:,ts2(1,:) <=mean(cell2mat(RT(a))+.5) & ts2(1,:) >=0);
figure
plot(Response)
title("Response"+Masterlist_ID(a)+type+Location)

Reward=Master_Matrix(:,ts2(1,:) <=5 & ts2(1,:) >= mean(cell2mat(RT(a))+.5));
figure
plot(Reward)
title("Reward "+Masterlist_ID(a)+type+Location)
Response_AUC(a,1)=sum(Response(Response>0));
Reward_AUC(a,1)=sum(Reward(Reward<0));
Max_amp(a,1)=max(Response);
min_amp(a,1)=min(Reward);
end




end

AUC_type=["Response_AUC","Reward_AUC"];
Amp_type=["Peak_Amp","Peak_Trough"];

for a= 1:length(Masterlist_ID)
    Response_AUC_Master(a,:)=[Masterlist_ID(a),Location,type,AUC_type(1),Response_AUC(a)];
    Reward_AUC_Master(a,:)=[Masterlist_ID(a),Location,type,AUC_type(2),Reward_AUC(a)];

    Amp_max(a,:)=[Masterlist_ID(a),Location,type,Amp_type(1),Max_amp(a)];
    Amp_min(a,:)=[Masterlist_ID(a),Location,type,Amp_type(2),min_amp(a)];

end
AUC=[Response_AUC_Master;Reward_AUC_Master];
Amp=[Amp_max;Amp_min];

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