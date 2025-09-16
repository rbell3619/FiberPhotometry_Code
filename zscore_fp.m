function [Master_Matrix,zerror]=zscore_fp(GRAB_avg,ITI,ts2)

zall = zeros(size(GRAB_avg)); 
for i = 1:size(GRAB_avg,1)
    ind = ts2(1,:) < ITI(2) & ts2(1,:) > ITI(1);
    zb = mean(GRAB_avg(i,ind)); % baseline period mean (-12sec to -9sec)
    zsd = std(GRAB_avg(i,ind)); % baseline period stdev
    zall(i,:)=(GRAB_avg(i,:) - zb)/zsd; % Z score per bin
end
zerror = std(zall)/sqrt(size(zall,1));
if height(zall)==1
    Master_Matrix=zall;
else
Master_Matrix=mean(zall);
end
min_val=min(abs(ts2));
zero_idx=abs(ts2)==min_val;
zero_val=Master_Matrix(zero_idx);
Master_Matrix=Master_Matrix-zero_val;


end
