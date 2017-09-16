% whether the difference between esm creativity and drm creativity is
% related to personal traits
% considering 2 aspects: instantaneous and delayed rating of creativity
% instantaneous and delayed rating about emotion-creativity relation
load('corresult1');
load('corresult2');
load('PandP')
%% exclude participants
ori_id = r_ofvalue(1, :);
data=zeros(43, length(ori_id));
cnt=[];
for i = 1 : length(ori_id)
    if ~isempty(find(PandP.TWS(:,1) == ori_id(i))) && ~isempty(find(PandP.O(:,1) == ori_id(i))) &&~isempty(find(PandP.RAT(:,1) == ori_id(i))) &&~isempty(find(PandP.div(:,1) == ori_id(i)))
        data(:,i) = [ori_id(i); PandP.TWS(PandP.TWS(:,1) == ori_id(i),2); PandP.O(PandP.O(:,1) == ori_id(i),2); PandP.RAT(PandP.RAT(:,1) == ori_id(i),2); PandP.div(PandP.div(:,1) == ori_id(i),2:4)'; r_ofvalue(:, i); r_esmcorr(:, i); r_drmcorr(:, i)];
    else cnt = [cnt i];
    end
end
data(:, cnt)=[];
temp=[8; 20; 27; 32; 39];
data(temp, :)=[];

%% relation with trait
data2 = zeros(41, length(data(1, :)));
data2(1:11, :) = 1/2 * log( (1 + data(8:18, :)) ./ (1 - data(8:18, :)) );
data2(12:21, :) = 1/2 * log( (1 + data(19:28, :)) ./ (1 - data(19:28, :)) )- 1/2 * log( (1 + data(29:38, :)) ./ (1 - data(29:38, :)) );
data2(22:31, :) = 1/2 * log( (1 + data(19:28, :)) ./ (1 - data(19:28, :)) );
data2(32:41, :) = 1/2 * log( (1 + data(29:38, :)) ./ (1 - data(29:38, :)) );
data2(isnan(data2)) = 0;
[r, p] = corr(data(2:7, :)', data2');



