%% find matched ESM&DRM pairs
% rule:same person & year & month & day & drm time cover esm moment
load('mental');
load('PandP');
ids=intersect(esmid,drmid);
ids(ids==41)=[];
ids(ids==71)=[];
esmtime=mental.esm.hour*60+mental.esm.min;
btime=mental.drm_2.begin_h*60+mental.drm_2.begin_m;
etime=mental.drm_2.end_h*60+mental.drm_2.end_m;
matched2.id=[];
matched2.month=[];
matched2.day=[];
matched2.esmtime=[];
matched2.drmbtime=[];
matched2.drmetime=[];
for k=1:11
    eval(['matched2.Q',num2str(k+20),'=[];']);
end
for k=1:11
    eval(['matched2.Q',num2str(k+64),'=[];']);
end
for i=1:length(mental.esm.year)
    index=find((mental.drm_2.ID==mental.esm.ID(i)) & (mental.drm_2.month==mental.esm.month(i)) & (mental.drm_2.day==mental.esm.day(i)) & (btime<esmtime(i)) & (etime>esmtime(i)));
    if length(index)==1
        matched2.id=[matched2.id,mental.esm.ID(i)];
        matched2.month=[matched2.month,mental.esm.month(i)];
        matched2.day=[matched2.day,mental.esm.day(i)];
        matched2.esmtime=[matched2.esmtime,esmtime(i)];
        matched2.drmbtime=[matched2.drmbtime,btime(index)];
        matched2.drmetime=[matched2.drmetime,etime(index)];
        for k=1:11
            eval(['matched2.Q',num2str(k+20),'=[matched2.Q',num2str(k+20),',mental.esm.Q',num2str(k+20),'(i)];']);
        end
        for k=1:11
            eval(['matched2.Q',num2str(k+64),'=[matched2.Q',num2str(k+64),',mental.drm_2.Q',num2str(k+64),'(index)];']);
        end
    end
end
%% exclude participants
ori_id=union(matched2.id,matched2.id);
id_new=[];
for i=1:length(ori_id)
    if length(find(matched2.id==ori_id(i)))>5 %&& ~isempty(find(ids == ori_id(i), 1))
        id_new=[id_new ori_id(i)];
    end
end
index=[];
for i=1:length(id_new)
    index=[index,find(matched2.id== id_new(i))];
end

        matched2.id=matched2.id(index);
        matched2.month=matched2.month(index);
        matched2.day=matched2.day(index);
        matched2.esmtime=matched2.esmtime(index);
        matched2.drmbtime=matched2.drmbtime(index);
        matched2.drmetime=matched2.drmetime(index);
        for k=1:11
            eval(['matched2.Q',num2str(k+20),'=matched2.Q',num2str(k+20),'(index);']);
        end
        for k=1:11
            eval(['matched2.Q',num2str(k+64),'=matched2.Q',num2str(k+64),'(index);']);
        end
   matched2.idindex=id_new;
    
save match matched2