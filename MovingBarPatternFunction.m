function MovingBar = MovingBarPatternFunction(Direction,BarWidth,MovingSpeed,Color,Height,Width,Time)
%Direnction is described in angle alpha, 90 > alpha > 0. BarWidth,Width unit in
%angle too.Moving speed unit in mm/s. Time unit in seconds.
        BackGroundColor=[0,0,1]; %Blue background.
        XResolution = 0.1;
        YResolution = 0.01;
        Radius = 18;
        Direction = Direction * pi / 180;
        WHRatio = 1/180*pi*Radius;
        BarWidth = BarWidth * WHRatio; %Transfer the barwidth into mm.
        BarMask=zeros(floor(Height * 2 / YResolution) + 1 , floor(Width * 2 / XResolution)+1,3);
        for i=1:3
        BarMask(:,:,i)=BackGroundColor(i)*255;
        end
        [x,y] = meshgrid((-Width:XResolution:Width)*WHRatio,(-Height:YResolution:Height));
        bar = abs(cos(Direction)*x+sin(Direction)*y+Height / 2 * sin(Direction) + Radius * Width /180 * pi* cos(Direction) - MovingSpeed * Time) < BarWidth;
        for i=1:3
            tempObject=BarMask(:,:,i);
            tempObject(bar)=Color(i);
            BarMask(:,:,i)=tempObject;
        end
        MovingBar = BarMask;
end