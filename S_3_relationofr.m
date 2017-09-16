% compare of creative-emotion correlations from esm and drm in both matched
% data and unmatched data
load('mental');
load('match');
load('PandP');
%% compare of creative-emotion correlations from esm and drm in matched data
% calculate individual r
n = length(matched2.idindex);
r_esmcorr = zeros(12,n);
r_drmcorr = zeros(12,n);
for i = 1 : n
    index = find(matched2.id == matched2.idindex(i));
    r_esmcorr(1,i) = matched2.idindex(i);
    r_drmcorr(1,i) = matched2.idindex(i);
    crea_esm = matched2.Q27(index);
    crea_drm = matched2.Q71(index);
    for k = 1 : 11
        eval(['esm = matched2.Q',num2str(k+20),'(index);']);
        eval(['drm = matched2.Q',num2str(k+64),'(index);']);
        r_esmcorr(k+1, i) = corr(crea_esm',esm');
        r_drmcorr(k+1, i) = corr(crea_drm',drm');
    end
end
% pairwised ttest
h_matched = zeros(1, 11);
p_matched = zeros(1, 11);
ci_matched = zeros(2, 11);
t_matched = zeros(1, 11);
df_matched = zeros(1, 11);
sd_matched = zeros(1, 11);
z_r_esmcorr = 1/2 * log( (1 + r_esmcorr(2:end, :)) ./ (1 - r_esmcorr(2:end, :)) );
z_r_drmcorr = 1/2 * log( (1 + r_drmcorr(2:end, :)) ./ (1 - r_drmcorr(2:end, :)) );
% dif_z = abs( z_r_esmcorr-z_r_drmcorr );
for k = 1 : 11
    [h_matched(1,k), p_matched(1,k), ci_matched(:,k), stats] = ttest(z_r_esmcorr(k, :), z_r_drmcorr(k, :));
    %     [h_matched(1,k), p_matched(1,k), ci_matched(:,k), stats] = ttest(dif_z(k, :));
    t_matched(1,k) = stats.tstat;
    df_matched(1,k) = stats.df;
    sd_matched(1,k) = stats.sd;
end
x = matched2.idindex;
y = {'relaxed', 'tired', 'happy', 'stressed', 'concentrated', 'sleepy', 'active', 'angry', 'depressed', 'interested'};
figure;
diff1=z_r_esmcorr-z_r_drmcorr;
diff1(7,:)=[];
imagesc(diff1);
set(gca,'xticklabel', x, 'FontSize',16);
set(gca,'yticklabel', y, 'FontSize',16);
colorbar;

%%  compare of creative-emotion correlations from esm and drm in unmatched data
ids = intersect(esmid, drmid);
% calculate individual r
n = length(ids);
r2_esmcorr = zeros(12,n);
r2_drmcorr = zeros(12,n);
for i = 1 : n
    index = find(mental.esm.ID == ids(i));
    r2_esmcorr(1,i) = ids(i);
    index2 = find(mental.drm_2.ID == ids(i));
    r2_drmcorr(1,i) = ids(i);
    crea_esm = mental.esm.Q27(index);
    crea_drm = mental.drm_2.Q71(index2);
    for k = 1 : 11
        eval(['esm = mental.esm.Q',num2str(k+20),'(index);']);
        eval(['drm = mental.drm_2.Q',num2str(k+64),'(index2);']);
        r2_esmcorr(k+1, i) = corr(crea_esm,esm);
        r2_drmcorr(k+1, i) = corr(crea_drm,drm);
    end
end
% pairwised ttest
h_unmatched = zeros(1, 11);
p_unmatched = zeros(1, 11);
ci_unmatched = zeros(2, 11);
t_unmatched = zeros(1, 11);
df_unmatched = zeros(1, 11);
sd_unmatched = zeros(1, 11);
z_r2_esmcorr = 1/2 * log( (1 + r2_esmcorr(2:end, :)) ./ (1 - r2_esmcorr(2:end, :)) );
z_r2_drmcorr = 1/2 * log( (1 + r2_drmcorr(2:end, :)) ./ (1 - r2_drmcorr(2:end, :)) );
% dif_z2 = abs( z_r2_esmcorr-z_r2_drmcorr );
for k = 1 : 11
    [h_unmatched(1,k), p_unmatched(1,k), ci_unmatched(:,k), stats] = ttest(z_r2_esmcorr(k, :), z_r2_drmcorr(k, :));
    %         [h_unmatched(1,k), p_unmatched(1,k), ci_unmatched(:,k), stats] = ttest(dif_z2(k, :));
    t_unmatched(1,k) = stats.tstat;
    df_unmatched(1,k) = stats.df;
    sd_unmatched(1,k) = stats.sd;
end
x = ids;
y = {'relaxed', 'tired', 'happy', 'stressed', 'concentrated', 'sleepy', 'active', 'angry', 'depressed', 'interested'};
figure;
diff2=z_r2_esmcorr-z_r2_drmcorr;
diff2(7,:)=[];
imagesc(diff2);
% set(gca,'xticklabel', x, 'FontSize',16);
set(gca,'yticklabel', y, 'FontSize',16);
colorbar;
save corresult2  r_esmcorr  r_drmcorr  r2_esmcorr  r2_drmcorr