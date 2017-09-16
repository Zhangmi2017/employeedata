% read ESM and DRM data from all subjects, 
% read and process pretest and posttest data to get a summary of related traits, 
% exclude rules: num of items; pre and post test completeness;

%% part 1: read daily data
[a,b]=xlsread('subjective',1);
c=b(1,1:42);
c=char(c);
for i=1:42
    eval(['mental.drm_1.',c(i,:),'=a(:,i);']);
end
crea=[];
stress=[];
for i=42:50
    eval(['crea=[crea mental.drm_1.Q',num2str(i),'];']);
end
mental.drm_1.crea=sum(crea,2)/9/9*100;
for i=51:64
    eval(['stress=[stress mental.drm_1.Q',num2str(i),'];']);
end
mental.drm_1.stress=(sum(stress(:,1:3),2)+40-sum(stress(:,4:7),2)+stress(:,8)+20-sum(stress(:,9:10),2)+sum(stress(:,11:12),2)+10-stress(:,13)+stress(:,14))/9/12*100;
[a,b]=xlsread('subjective',2);
c=b(1,1:21);
c=char(c);
for i=1:21
    eval(['mental.esm.',c(i,:),'=a(:,i);']);
end
[a,b]=xlsread('subjective',3);
c=b(1,1:24);
c=char(c);
for i=1:24
    eval(['mental.drm_2.',c(i,:),'=a(:,i);']);
end

save mental mental
%% read pre and post

b=xlsread('preandpost',8);
PandP.QA8=b;
score=sum(PandP.QA8(:,3:13),2)+sum(PandP.QA8(:,15:30),2)+sum(PandP.QA8(:,32:36),2)+sum(PandP.QA8(:,38:46),2)+sum(PandP.QA8(:,48:49),2)+sum(PandP.QA8(:,51:52),2)+(4-PandP.QA8(:,14))+(4-PandP.QA8(:,31))+(4-PandP.QA8(:,37))+(4-PandP.QA8(:,47))+(4-PandP.QA8(:,50));
PandP.TWS=[PandP.QA8(:,2) score];

b=xlsread('preandpost',1);
PandP.QA1=b';
A=sum(PandP.QA1(3:7,:))+sum(6-PandP.QA1(8:11,:));
C=sum(PandP.QA1(12:16,:))+sum(6-PandP.QA1(17:20,:));
N=sum(PandP.QA1(21:25,:))+sum(6-PandP.QA1(26:28,:));
O=sum(PandP.QA1(29:36,:))+sum(6-PandP.QA1(37:38,:));
E=sum(PandP.QA1(39:43,:))+sum(6-PandP.QA1(44:46,:));
PandP.BFI=[PandP.QA1(2,:)' O'/10 C'/9 E'/8 A'/9 N'/8];

%% process follow up data
n=29;
[data,str]=xlsread('followup.xls');
data=[data(:,11:58) data(:,64:68)];
Oscale=data(:,1:48);
ids=data(:,49);
RAT=str(2:end,2:16);
Oscore=zeros(n,6);

for i=1:48
    ii=mod(i,12);
    if(ii==2||ii==4||ii==6||ii==7||ii==9||ii==11)
        Oscale(:,i)=6-Oscale(:,i);
    end
end
    for i=1:48
        a=mod(i,6);
        if a==0
            a=6;
        end
        Oscore(:,a)=Oscore(:,a)+Oscale(:,i);
       
        
    end
    PandP.O=[ids sum(Oscore,2)];
       
   %rat calculate
   answer={'足球' '空调' '地球' '狗' '交通' '茶' '酒精' '等待' '家具' '门' '戒指' '锯子' '知识' '咖啡' '玻璃'};
   RATscore=zeros(n,15);
   for sub=1:n
       for i=1:15
           if size(RAT{sub,i})==size(answer{i})
           if RAT{sub,i}==answer{i}
               RATscore(sub,i)=1;
           end
           end
       end
   end
   RATsum=sum(RATscore,2);
   PandP.RAT=[ids RATsum];
   
   divscore=data(1:n,51:53);
   PandP.div=[ids divscore];
    

%% exclude participants
ori_drmid=union(mental.drm_2.ID,mental.drm_2.ID);
ori_esmid=union(mental.esm.ID,mental.esm.ID);
drmid=[];
esmid=[];
for i=1:length(ori_drmid)
    if length(find(mental.drm_2.ID==ori_drmid(i)))>10% && ~isempty(find(PandP.TWS(:,1)==ori_drmid(i))) && ~isempty(find(PandP.O(:,1)==ori_drmid(i))) &&~isempty(find(PandP.RAT(:,1)==ori_drmid(i))) &&~isempty(find(PandP.div(:,1)==ori_drmid(i)))
%         length(find(mental.drm_2.ID==ori_drmid(i)))
        drmid=[drmid ori_drmid(i)];
    end
end
for i=1:length(ori_esmid)
    if length(find(mental.esm.ID==ori_esmid(i)))>10 %&& ~isempty(find(PandP.TWS(:,1)==ori_esmid(i))) &&~isempty(find(PandP.O(:,1)==ori_esmid(i))) &&~isempty(find(PandP.RAT(:,1)==ori_esmid(i))) &&~isempty(find(PandP.div(:,1)==ori_esmid(i)))
%         length(find(mental.esm.ID==ori_esmid(i)))
        esmid=[esmid ori_esmid(i)];
    end
end
save PandP PandP esmid drmid