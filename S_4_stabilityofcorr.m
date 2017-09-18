% exam the stability of emotion-creativity relationship
% correlation-correlation-ttest����(too many exams?)

load('corresult2');
data = [r_esmcorr; r_drmcorr];
data2 = [r2_esmcorr; r2_drmcorr];
temp = [1, 8, 13, 20];
data(temp, :) = [];
data2(temp, :) = [];
data_z = 1/2 * log( (1 + data) ./ (1 - data) );
data_z(isnan(data_z)) = 0;
data2_z = 1/2 * log( (1 + data2) ./ (1 - data2) );
data2_z(isnan(data2_z)) = 0;

[corr_matched, p_matched] = corr(data_z(1 : 10, :), data_z(11 : 20, :));
[corr_unmatched, p_unmatched] = corr(data2_z(1 : 10, :), data2_z(11 : 20, :));
corr_matched_z = 1/2 * log( (1 + corr_matched) ./ (1 - corr_matched) );
corr_unmatched_z = 1/2 * log( (1 + corr_unmatched) ./ (1 - corr_unmatched) );
corr_matched_z2 = diag(corr_matched_z);
corr_unmatched_z2 = diag(corr_unmatched_z); 

[h_matched, pp_matched, ci_matched, stats_matched] = ttest(corr_matched_z2', 0, 'tail', 'right');
[h_unmatched, pp_unmatched, ci_unmatched, stats_unmatched] = ttest(corr_unmatched_z2', 0, 'tail', 'right');