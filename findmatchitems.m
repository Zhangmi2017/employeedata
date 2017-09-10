%% find matched ESM&DRM pairs
% rule:same person & year & month & day & drm time cover esm moment

ids=union(mental.esm.ID,mental.esm.ID);
ids(ids==41)=[];
ids(ids==71)=[];
esmtime=mental.esm.hour*60+mental.esm.min;
btime=mental.drm_2.begin_h*60+mental.drm_2.begin_m;
etime=mental.drm_2.end_h*60+mental.drm_2.end_m;
matched2.id=[];
matched2.month=[];
matched2.day=[];
matched2.time=[];
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
        matched2.time=[matched2.time,esmtime(i)];
        for k=1:11
            eval(['match.Q',num2str(k+20),'=[match.Q',num2str(k+20),',mental.esm.Q',num2str(k+20),'(i)];']);
        end
        for k=1:11
            eval(['match.Q',num2str(k+64),'=[match.Q',num2str(k+64),',mental.drm_2.Q',num2str(k+64),'(index)];']);
        end
    end
end
save match matched2