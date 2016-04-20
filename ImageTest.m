% Screen('CloseAll')
% Screen('Preference','SkipSyncTests',1)
% win1=Screen('OpenWindow',2);
% Im=zeros(512,512);
% Im(256,:)=1;
% Im(:,256)=1;
% Im=Im*255;
% % Screen('ColorRange', win1 , 1);
% ROIPos=[0,0,512,512];
% DisplayPos=[20,20,532,532];
% textureIndex=Screen('MakeTexture', win1, Im);
% Screen('DrawTexture', win1, textureIndex,ROIPos,DisplayPos);
% Screen('Flip', win1)
a=load('Movie2.mat');
TempMovie=a.TempMovie;
GetMD5(TempMovie,'bin');
Opt.Input='bin';
DataHash(TempMovie,Opt);
% Opt.Input='ascii';
% DataHash(TempMovie,Opt);
