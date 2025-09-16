function  [data]=detrend_Df_f(data,time,GRAB,ISO)

t =5; % time threshold below which we will discard
ind = find(time>t,1); % find first index of when time crosses threshold
time = time(ind:end); % reformat vector to only include allowed time
data.streams.(GRAB).data = data.streams.(GRAB).data(ind:end);
data.streams.(ISO).data = data.streams.(ISO).data(ind:end);
data.epocs.PC1_.onset= data.epocs.PC1_.onset -t;
data.epocs.PC1_.offset= data.epocs.PC1_.offset -t;

% figure
% hold on
% plot(time,data.streams.(GRAB).data)
% %plot(time,ISO_fit)
% title('Raw GRAB signal')
% legend('GRAB','FontSize',15)


baseline=polyfit(data.streams.(ISO).data,data.streams.(GRAB).data,1);
ISO_fit=(baseline(1).*data.streams.(ISO).data)+baseline(2);

data.streams.(GRAB).data=data.streams.(GRAB).data-ISO_fit;

% figure
% hold on
% plot(time,data.streams.(GRAB).data)
% %plot(time,ISO_fit)
% title('detrend GRAB signal')
% legend('GRAB','FontSize',15)


% figure
% hold on
% plot(time,data.streams.(GRAB).data)
% title('Normalized GRAB signal dF/F')
% legend('GRAB','FontSize',15)



end
