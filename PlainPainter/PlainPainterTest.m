handles = struct('dishRadius',18);
handles.figure1 = figure;
% handles.spotNumber = 5;
handles.dishRadius = 18;
handles.stripHeightResolution = 0.01;
handles.stripWidthResolution = 0.1;
handles.backGroundColor = [0 0 1];
handles.stripHeight = 10;
handles.stripWidth = 180;
% handles.spotOnTime = 2;
% handles.spotInterval = 0;
% handles.spotSeperateDegrees = 20;
% handles.spotHeight = 5;
% handles.frames = 30; %refresh frames per seconds
% handles.totalFrames=((handles.spotNumber-1)*handles.spotInterval+handles.spotNumber*handles.spotOnTime)*handles.frames;


Test = PlainPainter(handles);