% % tstart=tic();
% % DataHash(a);
% % toc(tstart);
% % tstart=tic();
% % GetMD5('C:\UQ\GoodhillIntern\ZerbrafishProject\a.mat','File')
% % toc(tstart);
% 
% a=rand(800,1200,3);
a=zeros(1,1800);
tstart=tic();
% a=reshape(a,800*1200,3);
for i=1:1800
a(i)=i;
end
toc(tstart);
% a=rand(800,1200,3);
% a=uint8(a);
% tstart=tic();
% a=reshape(a,800*1200,3);
% toc(tstart);
% a=zeros(2,...
%     1);
