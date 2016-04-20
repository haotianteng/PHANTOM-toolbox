
if(handles.surface==handles.g_Solid)
    if(handles.entity==handles.g_Spot)
        spotHeight=handles.dishRadius*handles.spotSize*pi/180;% be ware that this spotHeight is not the handles.spotHeight one is for size, the latter one is for position
        spotWidth=handles.spotSize;
    handles.object=zeros(floor(spotHeight*2/handles.stripHeightResolution)+1,floor(spotWidth*2/handles.stripWidthResolution)+1,3);
    for i=1:3
    handles.object(:,:,i)=handles.backGroundColor(i)*255;
    end
    [x,y]=meshgrid(-spotWidth:handles.stripWidthResolution:spotWidth,-spotHeight:handles.stripHeightResolution:spotHeight);
    circle=x.^2+(y./handles.dishRadius.*180./pi).^2<=(handles.spotSize).^2;
    for i=1:3
        tempObject=handles.object(:,:,i);
        tempObject(circle)=0;
    handles.object(:,:,i)=tempObject;
    end
    else
    end
else
end