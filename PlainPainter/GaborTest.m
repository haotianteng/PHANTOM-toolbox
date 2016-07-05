% PlainMovie;
% image = plainMovie(:,:,:,2);
% [gaborimage,phase] = imgaborfilt(image(:,:,3),4,90);
% figure;
% imagesc(gaborimage);
classdef GaborTest
    properties
        FunctionHandles;
    end
    
    methods
        function this =  GaborTest(handles)
        this.FunctionHandles = handles;
        end
    end
end