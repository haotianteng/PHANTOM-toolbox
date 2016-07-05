function SpotMask = GenSpot(spotSize , SpotPattern , WHRatio , XResolution , YResolution)
        %Gen Spot will generate a spot mask, which is a N * M image matrix,
        %where N refers to the pixels of height, and M refers to the pixels
        %to the width.
        
        
        spotHeight=spotSize*WHRatio;
        spotWidth=spotSize;
        SpotMask=zeros(floor(spotHeight * 2 / YResolution) + 1 , floor(spotWidth * 2 / XResolution)+1,3);
        for i=1:3
        SpotMask(:,:,i)=SpotPattern(i)*255;
        end
        [x,y]=meshgrid(-spotWidth:XResolution:spotWidth,-spotHeight:YResolution:spotHeight);
        circle=x.^2+(y/WHRatio).^2<=(spotSize).^2;
        for i=1:3
            tempObject=SpotMask(:,:,i);
            tempObject(circle)=0;
            SpotMask(:,:,i)=tempObject;
        end

end