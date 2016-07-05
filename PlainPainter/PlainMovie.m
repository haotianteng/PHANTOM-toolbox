
handles.spotNumber = 5;
handles.dishRadius = 18;
handles.stripHeightResolution = 0.01;
handles.stripWidthResolution = 0.1;
handles.backGroundColor = [0 0 1];
handles.stripHeight = 10;
handles.stripWidth = 180;
handles.spotOnTime = 2;
handles.spotInterval = 0;
handles.spotSeperateDegrees = 20;
handles.spotHeight = 5;
handles.frames = 30; %refresh frames per seconds
handles.totalFrames=((handles.spotNumber-1)*handles.spotInterval+handles.spotNumber*handles.spotOnTime)*handles.frames;
%Parameters obtained from GUI
BeginSpotSize = 1;
EndSpotSize = 5;
%Parameters should be obtained from GUI

Height=ceil(handles.stripHeight/handles.stripHeightResolution)+1;
Width=ceil(handles.stripWidth/handles.stripWidthResolution)+1;
WLRatio = handles.dishRadius * pi / 180; %WLRatio refers to the ratio because of the different unit used in the X coordinate(Degrees) and Y coordinate (mm)
Spots = zeros(4 , handles.totalFrames , handles.spotNumber); 
%The 4 * N * M matrix store the information about the spots display information in the movie.
%Line [1,N,i] store the spotsize of the i spot, if it is zero which means
%that this spot is not shown in this frame. 
%Line [2,N,i] store the pattern/color of the i spot.
%Line [3-4,N,i] store the position (line 3 for X and line 4 for Y) of the i spot.
TimeTrail = 1:handles.totalFrames;
plainMovie = zeros(Height , Width , 3 , handles.totalFrames , 'uint8');
%Variables List Initiation

Duration=handles.spotOnTime+handles.spotInterval;
IlluminaSize = BeginSpotSize +  (EndSpotSize - BeginSpotSize) / (handles.spotOnTime*handles.frames) : (EndSpotSize - BeginSpotSize) / (handles.spotOnTime*handles.frames) : EndSpotSize ;
SpotX=(handles.stripWidth-(handles.spotNumber-1)*handles.spotSeperateDegrees)/2:handles.spotSeperateDegrees:(handles.stripWidth+(handles.spotNumber-1)*handles.spotSeperateDegrees)/2;
SpotY=ones(1,handles.spotNumber)*handles.spotHeight;
SpotsXTrack = zeros(handles.spotNumber,handles.totalFrames);
SpotsYTrack = zeros(handles.spotNumber,handles.totalFrames);
for i = 1:handles.spotNumber
    Spots(1 , (Duration*handles.frames*(i-1)+1):1:(Duration*handles.frames*(i-1)+handles.spotOnTime*handles.frames) , i) = IlluminaSize(1,:);
%     Spots(1 , (Duration*handles.frames*(i-1)+1):1:(Duration*handles.frames*(i-1)+handles.spotOnTime*handles.frames) , i) = BeginSpotSize;
%     XTrail = @(Time)(4*Time / handles.frames +30); %X is the x coordinate of the strip, unit is in degree, from 0 to 180 degrees.
%     YTrail = @(Time)(SpotY(i)+sin(4*Time / handles.frames));%Y is the y coordinate of the strip, unit in mm, from 0 to 10 mm.
    XTrail = @(Time)(90); %X is the x coordinate of the strip, unit is in degree, from 0 to 180 degrees.
    YTrail = @(Time)(i+2);%Y is the y coordinate of the strip, unit in mm, from 0 to 10 mm.

    SpotsXTrack(i,:) = XTrail(TimeTrail);
    SpotsYTrack(i,:) = YTrail(TimeTrail);
    
    Spots(3 , : , i) = SpotsXTrack(i,:);
    Spots(4 , : , i) = SpotsYTrack(i,:);
end
Spots(2 , i , :) = 1;
%Information preparation to generate movie with illumina spots.

plainMovie(:,:,1,:)=handles.backGroundColor(1)*255;
plainMovie(:,:,2,:)=handles.backGroundColor(2)*255;
plainMovie(:,:,3,:)=handles.backGroundColor(3)*255;
for i = 1:handles.spotNumber    
    
    for j = 1:handles.totalFrames        
        SpotSize = Spots(1,j,i);
        
        if SpotSize > 0
            Spot = GenSpot(SpotSize,handles.backGroundColor,WLRatio,handles.stripWidthResolution,handles.stripHeightResolution);
            objectXStart=ceil((Spots(3,j,i) - SpotSize)/handles.stripWidthResolution);
            objectYStart=ceil((Spots(4,j,i) - SpotSize*WLRatio)/handles.stripHeightResolution);
            [objectH,objectW,N]=size(Spot);
            plainMovie(objectYStart:1:objectYStart+objectH-1,objectXStart:1:objectXStart+objectW-1,: ,j)=Spot;
        end
        
    end    
    
end
save('PlainMovie2.mat','plainMovie','-v7.3');
%Render a plain movie