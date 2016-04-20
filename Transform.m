%%%%%%%Print the distored handles.effectIm into the handles.backgroundIm, stored the consequence in the handles.patternIm 
y0=0;%y0 is the horizontal offset of the projector;
z0=handles.z0;%zo is the offset of the height of the projector to dish
gamma=handles.gamma;%gamma is the projector incline degree
gamma=gamma*pi/180;
d0=[cos(gamma),0,sin(gamma)];
ex=[0,1,0];
ey=cross(d0,ex);
mindegree=0;
% tstart=tic();
[Height,Width,N]=size(handles.effectIm);
handles.cylindricalCoordinate=zeros(Height,Width,2);%first is the Theta coordinate, and the next one is relative Z coordinate
%Generate related mesh coordinate
[handles.cylindricalCoordinate(:,:,1),handles.cylindricalCoordinate(:,:,2)]=meshgrid(mindegree:handles.stripWidthResolution:handles.stripWidth,0:handles.stripHeightResolution:handles.stripHeight);
handles.cylindricalCoordinate(:,:,1)=handles.cylindricalCoordinate(:,:,1)./360.*2*pi;

[PHeight,PWidth,N2]=size(handles.backGroundIm);
R=handles.dishRadius;
D=handles.distance;
Hratio=handles.fieldHeight/handles.physicalHeight*D;
Wratio=handles.fieldWidth/handles.physicalWidth*D;%60 and 104 is the General length of the projector image


%
handles.bodyCoordinate=zeros(Height,Width,3);%first is the X coordinate, and the next one is Y coordinate and third one is Z coordinate
handles.bodyCoordinate(:,:,1)=R+D-R.*sin(handles.cylindricalCoordinate(:,:,1));
handles.bodyCoordinate(:,:,2)=y0+R.*cos(handles.cylindricalCoordinate(:,:,1));
handles.bodyCoordinate(:,:,3)=z0-handles.cylindricalCoordinate(:,:,2);


handles.patternIm=handles.backGroundIm;
handles.projectCoordinate=zeros(Height,Width,2);%first is the X ,second is the Y

% for i=1:Height
%     for j=1:Width
%         d=reshape(handles.bodyCoordinate(i,j,:),1,3);
%         handles.projectCoordinate(i,j,1)=(d-d*d0'*d0)*ex'./(d*d0')*ratio;
%         handles.projectCoordinate(i,j,2)=((d-d*d0'*d0)*ey')./(d*d0')*ratio;
%         
% % abs(handles.projectCoordinate(i,j,1))<(handles.fieldWidth/2)&&abs(handles.projectCoordinate(i,j,2))<(handles.fieldHeight/2)&&
%         if(handles.effectIm(i,j,3)==0)
%             handles.patternIm(round(handles.projectCoordinate(i,j,2)+handles.fieldHeight/2),round(handles.projectCoordinate(i,j,1)+handles.fieldWidth/2),:)=handles.effectIm(i,j,:);
%         end
%         
%     end
% end
dx=handles.bodyCoordinate(:,:,1);
dy=handles.bodyCoordinate(:,:,2);
dz=handles.bodyCoordinate(:,:,3);
dH=dx*d0(1)+dy*d0(2)+dz*d0(3);

%         d=reshape(handles.bodyCoordinate(i,j,:),1,3);
%         handles.projectCoordinate(:,:,1)=(ex(1)*(dx-dH*d0(1))+ex(2)*(dy-dH*d0(2))+ex(3)*(dz-dH*d0(3)))./dH*ratio*2.15;
%         handles.projectCoordinate(:,:,2)=(ey(1)*(dx-dH*d0(1))+ey(2)*(dy-dH*d0(2))+ey(3)*(dz-dH*d0(3)))./dH*ratio*1.5;
          handles.projectCoordinate(:,:,1)=(ex(1)*(dx-dH*d0(1))+ex(2)*(dy-dH*d0(2))+ex(3)*(dz-dH*d0(3)))./dH*Wratio;
          handles.projectCoordinate(:,:,2)=(ey(1)*(dx-dH*d0(1))+ey(2)*(dy-dH*d0(2))+ey(3)*(dz-dH*d0(3)))./dH*Hratio;

% effectIm=permute(handles.effectIm,[3,1,2]);
% for i=1:Height
%     for j=1:Width
% % abs(handles.projectCoordinate(i,j,1))<(handles.fieldWidth/2)&&abs(handles.projectCoordinate(i,j,2))<(handles.fieldHeight/2)&&
% %         if(~isequal(effectIm(:,i,j),255*handles.backGroundColor'))
%             if(handles.effectIm(i,j,:)==0)
%             handles.patternIm(round(handles.projectCoordinate(i,j,2)+handles.fieldHeight/2),round(handles.projectCoordinate(i,j,1)+handles.fieldWidth/2),:)=handles.effectIm(i,j,:);
%             
% 
% %             X=[floor(handles.projectCoordinate(i,j,2)+handles.fieldHeight/2),floor(handles.projectCoordinate(i,j,1)+handles.fieldWidth/2)];
% %             handles.patternIm(X(1),X(2),:)=handles.patternIm(X(1),X(2),:)+handles.effectIm(i,j,:).*(1-handles.effectImFilter(i,j,1))*(1-handles.effectImFilter(i,j,2));
% 
%             
%             end
%     end
% end
ProjectX=reshape(handles.projectCoordinate(:,:,2),1,Height*Width);
ProjectX=-round(ProjectX)+handles.fieldHeight/2;
ProjectY=reshape(handles.projectCoordinate(:,:,1),1,Height*Width);
ProjectY=-round(ProjectY)+handles.fieldWidth/2;
Coor=ProjectX+(ProjectY-1)*PHeight;
REffectIm=reshape(handles.effectIm(:,:,1),1,Height*Width);
GEffectIm=reshape(handles.effectIm(:,:,2),1,Height*Width);
BEffectIm=reshape(handles.effectIm(:,:,3),1,Height*Width);
RefIndex=1:Height*Width;
RCoor=find(REffectIm==255*handles.backGroundColor(1));
GCoor=find(GEffectIm==255*handles.backGroundColor(2));
BCoor=find(BEffectIm==255*handles.backGroundColor(3));
EffectIndex=intersect(intersect(RCoor,GCoor),BCoor);
RefIndex(EffectIndex)=[];%exclude the pixal that is background
patternIm=reshape(handles.patternIm,1,PHeight*PWidth*3);
effectIm=reshape(handles.effectIm,1,Height*Width*3);
for i=1:3
patternIm(Coor(RefIndex)+(i-1)*PHeight*PWidth)=effectIm(RefIndex+(i-1)*Height*Width);
end
% toc(tstart);
handles.patternIm=uint8(reshape(patternIm,PHeight,PWidth,3));




