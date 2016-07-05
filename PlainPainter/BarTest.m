Direction = 0.1;
Radius = 18;
BarWidth = 3;
MovingSpeed = 20*1/180*pi*Radius;
XResolution = 0.1;
YResolution = 0.01;
Color = [0,0,0];
Height = 5;
Width = 90;
Frames = 5;
TotalTime = 10;
plainMovie = zeros(floor(Height * 2 / YResolution) + 1 , floor(Width * 2 / XResolution)+1,3,TotalTime*Frames,'uint8');
i=1;
for t = 1/Frames: 1/Frames : TotalTime
    plainMovie(:,:,:,i) = MovingBarPatternFunction(Direction,BarWidth,MovingSpeed,Color,Height,Width,t);
    i = i + 1;
end
save('BarMovie.mat','plainMovie','-v7.3');