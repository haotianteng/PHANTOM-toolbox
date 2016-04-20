handles.stripHeight=str2num(get(handles.HeightStrip,'string'));
stripHeight=handles.stripHeight;

handles.stripWidth=str2num(get(handles.WidthStrip,'string'));
stripWidth=handles.stripWidth;

mindegree=0;%default calculate the degree from 0 degree

stripHeightResolution=0.01;
stripWidthResolution=0.1;%still unit in degree;

% Generate the Effect picture
Height=ceil(stripHeight/stripHeightResolution)+1;
Width=ceil(stripWidth/stripWidthResolution)+1;
handles.effectIm=zeros(Height,Width,3);
handles.effectIm(:,:,1)=handles.backGroundColor(1)*255;
handles.effectIm(:,:,2)=handles.backGroundColor(2)*255;
handles.effectIm(:,:,3)=handles.backGroundColor(3)*255;


if OrderFrame(CurrentFrame)>0
    SpotIndex=OrderFrame(CurrentFrame);
    objectXStart=ceil((SpotX(SpotIndex)-mindegree-handles.spotSize)/handles.stripWidthResolution);
    objectYStart=ceil((SpotY(SpotIndex)-handles.spotSize*handles.dishRadius*pi/180)/handles.stripHeightResolution);
    [objectH,objectW,N]=size(handles.object);
    handles.effectIm(objectYStart:1:objectYStart+objectH-1,objectXStart:1:objectXStart+objectW-1,:)=handles.object;
end
