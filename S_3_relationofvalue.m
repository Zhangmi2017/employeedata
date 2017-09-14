% the correlation and diffference between ESM and DRM ratings of same emotion
% compare between the matched item pairs
% r_ofvalue: correlation between esm and drm ratings of emotion k from subject i 
% delta_e:  difference between esm and drm ratings of emotion k from subject i 
load('match');
load('PandP');
%% calculate individual r and delta_e
n = length(matched2.idindex);
r_ofvalue = zeros(12,n);
% trait = zeros(12, n);
delta_e = zeros(12,n);
for i = 1 : n
    index = find(matched2.id == matched2.idindex(i));
    r_ofvalue(1,i) = matched2.idindex(i);
    delta_e(1,i) = matched2.idindex(i);
%       trait(1,i) = matched2.idindex(i);
    for k = 1 : 11
                eval(['esm = matched2.Q',num2str(k+20),'(index);']);
                eval(['drm = matched2.Q',num2str(k+64),'(index);']);   
                r_ofvalue(k+1, i) = corr(esm',drm');
                delta_e(k+1, i) = mean(esm-drm);
    end
%     trait(2,i) = PandP.TWS(find(PandP.TWS(:,1) == matched2.idindex(i)),2);
%     trait(3,i) = PandP.O(find(PandP.O(:,1) == matched2.idindex(i)),2);
%     trait(4,i) = PandP.RAT(find(PandP.RAT(:,1) == matched2.idindex(i)),2);
%     trait(5:7,i) = PandP.div(find(PandP.div(:,1) == matched2.idindex(i)),2:4)';
%     trait(8:12,i) = PandP.BFI(find(PandP.BFI(:,1) == matched2.idindex(i)),2:6)';
%     
end
%% examnation of correlation coefficient
z_r_ofvalue = 1/2 * log( (1 + r_ofvalue(2:end, :)) ./ (1 - r_ofvalue(2:end, :)) );
h = zeros(1, 11);
p = zeros(1, 11);
ci = zeros(2, 11);
t = zeros(1, 11);
df = zeros(1, 11);
sd = zeros(1, 11);
for k = 1 : 11
[h(1,k), p(1,k), ci(:,k), stats] = ttest(z_r_ofvalue(k,:)');
t(1,k) = stats.tstat;
df(1,k) = stats.df;
sd(1,k) = stats.sd;
end
% color map presentation
figure;
x = matched2.idindex;
y = {'relaxed', 'tired', 'happy', 'stressed', 'concentrated', 'sleepy', 'creative', 'active', 'angry', 'depressed', 'interested'};
imagesc(r_ofvalue(2 : end, :));
set(gca,'xticklabel', x);
set(gca,'yticklabel', y);
colorbar;

%% examnation of delta_e

h_e = zeros(1, 11);
p_e = zeros(1, 11);
ci_e = zeros(2, 11);
t_e = zeros(1, 11);
df_e = zeros(1, 11);
sd_e = zeros(1, 11);
for k = 1 : 11
[h_e(1,k), p_e(1,k), ci_e(:,k), stats] = ttest(delta_e(k+1,:)');
t_e(1,k) = stats.tstat;
df_e(1,k) = stats.df;
sd_e(1,k) = stats.sd;
end
% color map presentation
figure;
imagesc(delta_e(2 : end, :));
set(gca,'xticklabel', x);
set(gca,'yticklabel', y);
colorbar;

