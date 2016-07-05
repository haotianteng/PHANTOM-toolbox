%%%%%%%Print and transform handles.effectIm into the handles.backgroundIm, stored the consequence in the handles.patternIm 
EffectIndex = [];
handles.patternIm=handles.backGroundIm;
[Height,Width,N]=size(handles.effectIm);
[PHeight,PWidth,N2]=size(handles.backGroundIm);
REffectIm=reshape(handles.effectIm(:,:,1),1,Height*Width);
GEffectIm=reshape(handles.effectIm(:,:,2),1,Height*Width);
BEffectIm=reshape(handles.effectIm(:,:,3),1,Height*Width);
RCoor=find(REffectIm==255*handles.backGroundColor(1));
GCoor=find(GEffectIm==255*handles.backGroundColor(2));
BCoor=find(BEffectIm==255*handles.backGroundColor(3));
EffectIndex=c_Intersect(c_Intersect(RCoor,GCoor),BCoor);
RefIndex=1:Height*Width;
RefIndex(EffectIndex)=[];%exclude the pixal that is background
patternIm=reshape(handles.patternIm,1,PHeight*PWidth*3);
effectIm=reshape(handles.effectIm,1,Height*Width*3);
for i=1:3
patternIm(handles.Coor(RefIndex)+(i-1)*PHeight*PWidth)=effectIm(RefIndex+(i-1)*Height*Width)*255;
end
% toc(tstart);
handles.patternIm=uint8(reshape(patternIm,PHeight,PWidth,3));




