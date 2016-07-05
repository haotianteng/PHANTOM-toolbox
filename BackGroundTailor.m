if isfield(handles,'fieldHeight')
    fieldHeight=handles.fieldHeight;
else
    fieldHeight=W;
    handles.fieldHeight=fieldHeight;
    set(handles.HeightField,'String',num2str(W))
end

if isfield(handles,'fieldWidth')
    fieldWidth=handles.fieldWidth;
else
    fieldWidth=H;
    handles.fieldWidth=fieldWidth;
    set(handles.WidthField,'String',num2str(H))
end
backGroundIm=zeros(fieldHeight,fieldWidth,3);
backGroundColor=[0,0,1];
if isfield(handles,'backGroundColor')
    backGroundColor=handles.backGroundColor;
    

end
backGroundIm(:,:,1)=backGroundColor(1);
backGroundIm(:,:,2)=backGroundColor(2);
backGroundIm(:,:,3)=backGroundColor(3);
backGroundIm=backGroundIm*255;
handles.backGroundIm=backGroundIm;
%%%%%%%%
handles.stripHeight=str2num(get(handles.HeightStrip,'string'));
stripHeight=handles.stripHeight;
handles.stripWidth=str2num(get(handles.WidthStrip,'string'));
stripWidth=handles.stripWidth;
mindegree=0;%default calculate the degree from 0 degree
% handles.stripHeightResolution=0.01;
stripHeightResolution=handles.stripHeightResolution;
% handles.stripWidthResolution=0.1;
stripWidthResolution=handles.stripWidthResolution;%still unit in degree;
% Generate the Effect picture
Height=ceil(stripHeight/stripHeightResolution)+1;
Width=ceil(stripWidth/stripWidthResolution)+1;
handles.effectIm=zeros(Height,Width,3);
PreTransform;
Transform;
handles.backGroundIm=handles.patternIm;
%%%%%%%%%%%%Here reverse the Color of the anticipant area(Black) and the
%%%%%%%%%%%%outside color(Blue)
RbackGroundIm=handles.backGroundIm(:,:,1);
GbackGroundIm=handles.backGroundIm(:,:,2);
BbackGroundIm=handles.backGroundIm(:,:,3);
RefArea=1:fieldHeight*fieldWidth;
RAreaIn=find(RbackGroundIm==0);
GAreaIn=find(GbackGroundIm==0);
BAreaIn=find(BbackGroundIm==0);
AreaIn=intersect(intersect(RAreaIn,GAreaIn),BAreaIn);
RefArea(AreaIn)=[];%this is area outside the dish project area
RbackGroundIm(AreaIn)=backGroundColor(1)*255;
GbackGroundIm(AreaIn)=backGroundColor(2)*255;
BbackGroundIm(AreaIn)=backGroundColor(3)*255;
RbackGroundIm(RefArea)=0;
GbackGroundIm(RefArea)=0;
BbackGroundIm(RefArea)=0;
handles.backGroundIm(:,:,1)=RbackGroundIm;
handles.backGroundIm(:,:,2)=GbackGroundIm;
handles.backGroundIm(:,:,3)=BbackGroundIm;
%%%%%%%%%%%%Tailor the backgroundIm
handles.patternIm=[];