function varargout = ProjectionGUI(varargin)
% PROJECTIONGUI MATLAB code for ProjectionGUI.fig
%      PROJECTIONGUI, by itself, creates a new PROJECTIONGUI or raises the existing
%      singleton*.
%
%      H = PROJECTIONGUI returns the handle to a new PROJECTIONGUI or the handle to
%      the existing singleton*.
%   
%      PROJECTIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTIONGUI.M with the given input arguments.
%
%      PROJECTIONGUI('Property','Value',...) creates a new PROJECTIONGUI or raises the
%      existing singleton*.  Starting from the left, ¡¤property value pairs are
%      applied to the GUI before ProjectionGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectionGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%Copyright (c) 2016, Haotian Teng rights reserved.
%     
% ZerbrafishProject is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, osr
%     (at your option) any later version.
% 
% ZerbrafishProject is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
%     along with ZerbrafishProject.  If not, see <http://www.gnu.org/licenses/>.
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProjectionGUI

% Last Modified by GUIDE v2.5 17-Apr-2016 21:55:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectionGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectionGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ProjectionGUI is made visible.
function ProjectionGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjectionGUI (see VARARGIN)
clc;
% Choose default command line output for ProjectionGUI
handles.output = hObject;
addpath('mtimesx');
handles.GaussFilter='True';
set(handles.WidthStrip,'String','180');%stripWidth is in degree unit.
set(handles.HeightStrip,'String','10');
set(handles.PhysicalHeight,'String','60');
set(handles.PhysicalWidth,'String','80');
set(handles.StripHeightResolution,'String','0.01');
set(handles.StripWidthResolution,'String','0.1');
handles.physicalHeight=60;
handles.physicalWidth=80;
handles.stripHeight=10;
handles.stripWidth=180;
handles.stripHeightResolution=0.01;
handles.stripWidthResolution=0.1;
handles.distance=224;
set(handles.Distance,'String',num2str(handles.distance));
handles.z0=5;%-17; %the dishes is 22 mm under the horizontal line, and calcualte from the
set(handles.Z0,'String',num2str(handles.z0));
handles.gamma=0;%-5.6;
set(handles.Gamma,'String',num2str(handles.gamma));
handles.win1=0;
handles.backGroundColor=[0,0,1];
handles.spotSize=2;
handles.spotHeight=5;
handles.spotSeperateDegrees=20;
handles.spotNumber=5;
handles.dishRadius=18;
handles.g_RandomOrder=1;
handles.g_IncreasingOrder=2;%this is used as global variable
handles.g_DecreasingOrder=3;
handles.spotOrder=handles.g_RandomOrder;
handles.spotOnTime=1;
handles.spotInterval=4;
handles.g_Spot=1;
handles.g_Bar=2;
handles.entity=handles.g_Spot;
handles.g_Solid=1;
handles.g_Checkerboard=2;
handles.surface=handles.g_Solid;
handles.g_Horizontal=1;
handles.g_Vertical=2;
handles.movement=handles.g_Horizontal;
handles.movieInterval=1;
handles.baselineDuration=5;
handles.endbaselineDuration=5;
handles.frames=30;
handles.movieStore=struct('HashID',{},'Setting',{},'RawMovie',{},'Movie',{});%used to save movie generated or loaded
handles.moviePool={};%only record the ID of the movie, always synchronize with the 
handles.movieList={};%only record the ID of the movie
handles.movieNum=0;
handles.spot=[];

%%%%%%%IO device connection attempt%%%%%%
% For triggering control,Require Nitional Instrument DAQ toolbox.
handles.IO = struct('Device',[],'Session',[]);
try
    
    handles.IO.Device = daq.getDevices;
    if ~isempty(handles.IO.Device)
    handles.IO.Session = daq.createSession('ni');
    else
        handles.IO.Session = [];
    end
    [handles.Channel1,handles.Index1] = handles.IO.Session.addDigitalChannel('Dev1','port0/line1','OutputOnly');
    [handles.Channel2,handles.Index2] = handles.IO.Session.addDigitalChannel('Dev1','port0/line2','OutputOnly');
catch error
    display(error.message);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.GenerateMovie,'enable','off')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectionGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectionGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





function Distance_Callback(hObject, eventdata, handles)
% hObject    handle to Distance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Distance as text
%        str2double(get(hObject,'String')) returns contents of Distance as a double
handles.distance=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Distance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Distance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function HeightField_Callback(hObject, eventdata, handles)
% hObject    handle to HeightField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HeightField as text
%        str2double(get(hObject,'String')) returns contents of HeightField as a double
handles.fieldHeight=str2double(get(hObject,'String'));
% Project_Callback(handles.Project,eventdata,handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function HeightField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HeightField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WidthField_Callback(hObject, eventdata, handles)
% hObject    handle to WidthField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WidthField as text
%        str2double(get(hObject,'String')) returns contents of WidthField as a double
handles.fieldWidth=str2double(get(hObject,'String'));
% Project_Callback(handles.Project,eventdata,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function WidthField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WidthField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function HeightStrip_Callback(hObject, eventdata, handles)
% hObject    handle to HeightStrip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HeightStrip as text
%        str2double(get(hObject,'String')) returns contents of HeightStrip as a double


% --- Executes during object creation, after setting all properties.
function HeightStrip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HeightStrip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WidthStrip_Callback(hObject, eventdata, handles)
% hObject    handle to WidthStrip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WidthStrip as text
%        str2double(get(hObject,'String')) returns contents of WidthStrip as a double


% --- Executes during object creation, after setting all properties.
function WidthStrip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WidthStrip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FishOffset_Callback(hObject, eventdata, handles)
% hObject    handle to FishOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FishOffset as text
%        str2double(get(hObject,'String')) returns contents of FishOffset as a double


% --- Executes during object creation, after setting all properties.
function FishOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FishOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BlueBackGroundColor.
function BlueBackGroundColor_Callback(hObject, eventdata, handles)
% hObject    handle to BlueBackGroundColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BlueBackGroundColor
handles.backGroundColor=[0,0,1];
set(handles.BlueBackGroundColor,'Value',1);
set(handles.WhiteBackGroundColor,'Value',0);
set(handles.CustomizedBackGroundColorCheck,'Value',0);
set(handles.RCustomizedColor,'enable','off');
set(handles.GCustomizedColor,'enable','off');
set(handles.BCustomizedColor,'enable','off');
% Project_Callback(handles.Project,eventdata,handles);
guidata(hObject,handles);



% --- Executes on button press in WhiteBackGroundColor.
function WhiteBackGroundColor_Callback(hObject, eventdata, handles)
% hObject    handle to WhiteBackGroundColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of WhiteBackGroundColor
set(handles.WhiteBackGroundColor,'Value',1);
set(handles.BlueBackGroundColor,'Value',0);
set(handles.CustomizedBackGroundColorCheck,'Value',0);
set(handles.RCustomizedColor,'enable','off');
set(handles.GCustomizedColor,'enable','off');
set(handles.BCustomizedColor,'enable','off');
handles.backGroundColor=[1,1,1];
handles.flipInterval=0;
% Project_Callback(handles.Project,eventdata,handles);
guidata(hObject,handles);


% --- Executes on button press in CustomizedBackGroundColorCheck.
function CustomizedBackGroundColorCheck_Callback(hObject, eventdata, handles)
% hObject    handle to CustomizedBackGroundColorCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') ret`Qurns toggle state of CustomizedBackGroundColorCheck
display('Customized background color. The value is between 0 to 1.')
set(handles.WhiteBackGroundColor,'Value',0);
set(handles.BlueBackGroundColor,'Value',0);
set(handles.CustomizedBackGroundColorCheck,'Value',1);
set(handles.RCustomizedColor,'enable','on');
set(handles.GCustomizedColor,'enable','on');
set(handles.BCustomizedColor,'enable','on');
R=str2double(get(handles.RCustomizedColor,'String'));
G=str2double(get(handles.GCustomizedColor,'String'));
B=str2double(get(handles.BCustomizedColor,'String'));
if(isnan(R)||isnan(G)||isnan(B))
    set(handles.RCustomizedColor,'String','0');
    R=0;
    set(handles.GCustomizedColor,'String','0');
    G=0;
    set(handles.BCustomizedColor,'String','0');
    B=0;
end
handles.backGroundColor=[R,G,B];
% Project_Callback(handles.Project,eventdata,handles);
% Refresh;
guidata(hObject,handles);






function GCustomizedColor_Callback(hObject, eventdata, handles)
% hObject    handle to GCustomizedColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
G=str2double(get(hObject,'String'));
if G>1
    G=G/255;
    set(hObject,'String',num2str(G));
    display('Warning, the max value of green channel is 1, automatically scale from 0-255 to 0-1.');
end
handles.backGroundColor(2) = G;
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of GCustomizedColor as text
%        str2double(get(hObject,'String')) returns contents of GCustomizedColor as a double


% --- Executes during object creation, after setting all properties.
function GCustomizedColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GCustomizedColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'enable','off');



function BCustomizedColor_Callback(hObject, eventdata, handles)
% hObject    handle to BCustomizedColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
B=str2double(get(hObject,'String'));
if B>1
    B=B/255;
    set(hObject,'String',num2str(B));
    display('Warning, the max value of blue channel is 1, automatically scale from 0-255 to 0-1.');
end
handles.backGroundColor(3) = B;
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of BCustomizedColor as text
%        str2double(get(hObject,'String')) returns contents of BCustomizedColor as a double


% --- Executes during object creation, after setting all properties.
function BCustomizedColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BCustomizedColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'enable','off');



function DishRadius_Callback(hObject, eventdata, handles)
% hObject    handle to DishRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DishRadius as text
%        str2double(get(hObject,'String')) returns contents of DishRadius as a double
handles.dishRadius=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function DishRadius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DishRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Project.
function Project_Callback(hObject, eventdata, handles)
% hObject    handle to Project (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.codepath=pwd;
if handles.win1<=0
Screen('CloseAll')
Screen('Preference','SkipSyncTests',1)
win1=Screen('OpenWindow',2);
handles.flipInterval=Screen('GetFlipInterval',win1);
handles.freshRate=round(1/handles.flipInterval);
set(handles.FreshRate,'String',['Screen monitor freshRate is ',num2str(handles.freshRate),'.',' Movie fresh rate is ',num2str(handles.frames),'.']);
[H,W]=Screen('windowsize',win1);
handles.win1=win1;
else
    win1=handles.win1;
end

BackGroundTailor;
%%%Generate the correct distored background.
%%%Output in handles.backgroundIm and distortion would have problem if the
%%%background color equal to pattern color(default black);

% Screen('ColorRange', win1 , 1);
% ROIPos=[0,0,512,512];
% DisplayPos=[20,20,20+fieldWidth,20+fieldHeight];
% Transform;
Refresh;
set(handles.GenerateMovie,'enable','on');
guidata(hObject,handles);




% --- Executes on button press in Over.
function Over_Callback(hObject, eventdata, handles)
% hObject    handle to Over (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Screen('CloseAll');
if isfield(handles,'win1')
    handles.win1=0;
end
guidata(hObject, handles);


% --- Executes on button press in Up.
function Up_Callback(hObject, eventdata, handles)
% hObject    handle to Up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.z0=handles.z0-1;
set(handles.Z0,'String',handles.z0);
BackGroundTailor;
Refresh;
guidata(hObject,handles);


% --- Executes on button press in Left.
function Left_Callback(hObject, eventdata, handles)
% hObject    handle to Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Right.
function Right_Callback(hObject, eventdata, handles)
% hObject    handle to Right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Down.
function Down_Callback(hObject, eventdata, handles)
% hObject    handle to Down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.z0=handles.z0+1;
set(handles.Z0,'String',handles.z0);
BackGroundTailor;
Refresh;
guidata(hObject,handles);


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in InclineUp.
function InclineUp_Callback(hObject, eventdata, handles)
% hObject    handle to InclineUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gamma=handles.gamma+1;
set(handles.Gamma,'String',handles.gamma);
BackGroundTailor;
Refresh;
guidata(hObject,handles);

% --- Executes on button press in InclineDown.
function InclineDown_Callback(hObject, eventdata, handles)
% hObject    handle to InclineDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gamma=handles.gamma-1;
set(handles.Gamma,'String',handles.gamma);
BackGroundTailor;
Refresh;
guidata(hObject,handles);


function RCustomizedColor_Callback(hObject, eventdata, handles)
% hObject    handle to RCustomizedColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
R=str2double(get(hObject,'String'));
if R>1
    R=R/255;
    set(hObject,'String',num2str(R));
    display('Warning, the max value of red channel is 1, automatically scale from 0-255 to 0-1.');
end
handles.backGroundColor(1) = R;
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of RCustomizedColor as text
%        str2double(get(hObject,'String')) returns contents of RCustomizedColor as a double


% --- Executes during object creation, after setting all properties.
function RCustomizedColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RCustomizedColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'enable','off');


% --- Executes on button press in GridTest.
function GridTest_Callback(hObject, eventdata, handles)
% hObject    handle to GridTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'mainHandle',handles);
hGrid=Grid();%read the Grid parameter
handles.Grid=hGrid;

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
handles.effectIm(:,:,1)=handles.backGroundColor(1)*255;
handles.effectIm(:,:,2)=handles.backGroundColor(2)*255;
handles.effectIm(:,:,3)=handles.backGroundColor(3)*255;
GridThickness = hGrid(3);

for i=2:hGrid(1)-1

handles.effectIm(:,round((i-1)*(Width-1)/(hGrid(1)-1)-GridThickness/2):1:round(GridThickness/2+(i-1)*(Width-1)/(hGrid(1)-1)),:)=0;

end
handles.effectIm(:,1:round(GridThickness/2),:)=0;
handles.effectIm(:,Width:-1:Width-round(GridThickness/2),:)=0;


for i=2:hGrid(2)-1

handles.effectIm(1+round((i-1)*(Height-1)/(hGrid(2)-1)-GridThickness/2):1:round(GridThickness/2+(i-1)*(Height-1)/(hGrid(2)-1)),:,:)=0;

end
handles.effectIm(1:round(GridThickness/2),:,:)=0;
handles.effectIm(Height:-1:Height-round(GridThickness/2),:,:)=0;
% handles.effectIm(:,:,-1::)=0;

% handles.effectIm(1:100,1:100,:)=0;hGrid

%
%Project transformed
Transform;%Transformed the effectIm to the real project Im.
% handles.patternIm=handles.effectIm;
%
Refresh;

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function BlueBackGroundColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BlueBackGroundColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Value',1);



function Z0_Callback(hObject, eventdata, handles)
% hObject    handle to Z0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.z0=str2num(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of Z0 as text
%        str2double(get(hObject,'String')) returns contents of Z0 as a double
% BackGroundTailor;
% Refresh;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Z0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Gamma_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gamma=str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of Gamma as text
%        str2double(get(hObject,'String')) returns contents of Gamma as a double
% PreTransform;
% Transform;
% Refresh;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GenerateMovie.
function GenerateMovie_Callback(hObject, eventdata, handles)
% hObject    handle to GenerateMovie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[RawFilename,RawFilepath,RawFilterIndex]=uigetfile([pwd,'\RawMovie\*.mat'],'Input raw movie','plainMovie.mat');
[Filename,Filepath,FilterIndex]=uiputfile([pwd,'\Movie\*.mat'],'Save as','Movie1.mat');
addpath(genpath([pwd,'\PlainPainter\']));
if(Filename==0)
    return;
end
if(RawFilename==0)
    display('Movie generated by PlainPainter GUI.');
    RawMovie = PlainPainter(handles);

else
    display('Read the Raw Movie...')
    RawMovie = load([RawFilepath,RawFilename]);
    
end
if(isfield(RawMovie,'Info')||isa(RawMovie,'PlainPainter'))
    if(~isempty(RawMovie.Info))
    PlainMovieInfo = RawMovie.Info;%Get the Parameters which is used for generating the plain movie, for further use.
    end
else
    PlainMovieInfo =[];
end
unit = struct('Distance','mm','InclineAngle','degree','DishHeight','mm','FieldHeight','pixal','FieldWidth','pixal','FieldPhysicalHeight','mm','FieldPhysicalWidth','mm','StripHeight','mm','StripWidth','degree','StripHeightResolution','mm','StripWidthResolution','degree','BackGroundColor','RGB0-1','DishRadius','mm');
ProjectParameters = struct('Distance',handles.distance,'InclineAngle',handles.gamma,'DishHeight',handles.z0,'FieldHeight',handles.fieldHeight,'FieldWidth',handles.fieldWidth,'FieldPhysicalHeight',handles.physicalHeight,'FieldPhysicalWidth',handles.physicalWidth,'StripHeight',handles.stripHeight,'StripWidth',handles.stripWidth,'StripHeightResolution',handles.stripHeightResolution,'StripWidthResolution',handles.stripWidthResolution,'BackGroundColor',handles.backGroundColor,'DishRadius',handles.dishRadius,'Unit',unit);
MovieInfo = struct('PlainMovieInfo',PlainMovieInfo,'ProjectionParameter',ProjectParameters);
handles.totalFrames = size(RawMovie.plainMovie,4);  
display('Movie Transformation begin, wait until succeed.')
tstart=tic();
Height=ceil(handles.stripHeight/handles.stripHeightResolution)+1;
Width=ceil(handles.stripWidth/handles.stripWidthResolution)+1;
%Test if the image is out of boundary
CurrentNum=handles.movieNum+1;
handles.movieStore(1).RawMovie{CurrentNum}=RawMovie.plainMovie;
handles.movieStore(1).Movie{CurrentNum}=zeros(handles.fieldHeight,handles.fieldWidth,3,handles.totalFrames,'uint8');
handles.movieStore(1).MovieInfo{CurrentNum} = MovieInfo;
handles.movieStore(1).PlainMovieInfo{CurrentNum} = PlainMovieInfo;
%Construct the spot or the bar

display([num2str(handles.totalFrames),' frames to be rendered.']);
for CurrentFrame=1:handles.totalFrames
    handles.effectIm=handles.movieStore(1).RawMovie{CurrentNum}(:,:,:,CurrentFrame);
    handles.patternIm=[];
    if(CurrentFrame>1)&& isequal(handles.movieStore.RawMovie{CurrentNum}(:,:,:,CurrentFrame-1),handles.effectIm)
%     if isequal(handles.movieStore.RawMovise{CurrentNum},handles.effectIm)
            handles.movieStore.Movie{CurrentNum}(:,:,:,CurrentFrame)=handles.movieStore.Movie{CurrentNum}(:,:,:,CurrentFrame-1);
    else
            Transform;
            handles.movieStore.Movie{CurrentNum}(:,:,:,CurrentFrame)=handles.patternIm;
    end
    if(~mod(CurrentFrame,10))
    display([num2str(CurrentFrame),'/',num2str(handles.totalFrames)]);
    end
end
display('Movie generated successfully! Check the overlap.');
TempMovie=handles.movieStore.Movie{CurrentNum};
PlainMovie = RawMovie.plainMovie;
delete([Filepath,Filename]);
% MovieParameters = PlainMovieParameters;

ops = struct('algorithm', 'greedy'); 
save([Filepath,Filename],'-v7.3','ops','TempMovie','MovieInfo');
save([Filepath,'PlainMovie-',Filename],'-v7.3','ops','PlainMovie','PlainMovieInfo')
HashID=GetMD5(TempMovie,'bin');
MovieOverlap=0;
if (handles.movieNum>0)
    for i=1:handles.movieNum
        if(handles.movieStore.HashID{i}==HashID)
            MovieOverlap=i;
        end
    end
end
if MovieOverlap==0
handles.movieStore.Setting{CurrentNum}=[handles.spotSize handles.spotHeight handles.spotSeperateDegrees handles.spotNumber handles.spotOrder handles.spotOnTime handles.spotInterval handles.entity handles.surface handles.movement handles.frames ];
handles.movieStore.HashID{CurrentNum}=HashID;
handles.moviePool{CurrentNum}=[Filepath,Filename];
set(handles.MoviePool,'String',handles.moviePool');
handles.movieNum=handles.movieNum+1;
else
    display(['This movie is already in the movie pool, it is the movie ',num2str(MovieOverlap)],'!');
    handles.movieStore.RawMovie(CurrentNum)=[];
    handles.movieStore.Movie(CurrentNum)=[];
    handles.movieStore(1).MovieInfo{CurrentNum} = [];
    handles.movieStore(1).PlainMovieInfo{CurrentNum} = [];
    delete([Filepath,Filename]);
end
toc(tstart);
guidata(hObject,handles);


% --- Executes on selection change in MoviePool.
function MoviePool_Callback(hObject, eventdata, handles)
% hObject    handle to MoviePool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MoviePool contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MoviePool


% --- Executes during object creation, after setting all properties.
function MoviePool_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoviePool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PlayList.
function PlayList_Callback(hObject, eventdata, handles)
% hObject    handle to PlayList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PlayList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PlayList


% --- Executes during object creation, after setting all properties.
function PlayList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlayList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Insert.
function Insert_Callback(hObject, eventdata, handles)
% hObject    handle to Insert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MovieIndex=get(handles.MoviePool,'Value');
ListIndex=get(handles.PlayList,'Value');
ListSize=size(handles.movieList,2);
TempList=cell(1,ListSize+1);
TempFileList=cell(ListSize+1,1);
if isempty(ListIndex)
    ListIndex=1;
end
% if ListSize>=ListIndex%insert in the middle
TempList(1:ListIndex-1)=handles.movieList(1:ListIndex-1);
TempList{ListIndex}=handles.movieStore.HashID{MovieIndex};
TempList(ListIndex+1:end)=handles.movieList(ListIndex:end);
handles.movieList=TempList;
% else%insert in the end
%     handles.movieList{ListIndex}=handles.movieStore.HashID{MovieIndex};
% end
for i=1:ListSize+1
    TempFileList(i)=handles.moviePool(strcmp(handles.movieStore.HashID,TempList{i}));
end
set(handles.PlayList,'String',TempFileList');
guidata(hObject,handles);

% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Filename,Filepath]=uigetfile('*.mat','Pick a Movie.','');
if(Filename==0)
    return;
end
display('Movie Loaded begin ... ...');
Movie=load([Filepath,Filename]);
display('Movie Loaded successfully, check overlap.')
TempMovie=Movie.TempMovie;
if isfield(Movie,'MovieInfo')
MovieInfo = Movie.MovieInfo;
else
MovieInfo = [];    
end
HashID=GetMD5(TempMovie,'bin');
CurrentNum=handles.movieNum+1;
MovieOverlap=0;
if (handles.movieNum>0)
    for i=1:handles.movieNum
        if(handles.movieStore.HashID{i}==HashID)
            MovieOverlap=i;
        end
    end
end
if MovieOverlap==0
display('Movie overlap checked completed, movie would be added into movie pool.');
handles.movieStore(1).Setting{CurrentNum}='Unknown';
handles.movieStore(1).HashID{CurrentNum}=HashID;
handles.movieStore(1).Movie{CurrentNum}=TempMovie;
handles.movieStore(1).RawMovie{CurrentNum}=[];
handles.movieStore(1).MovieInfo{CurrentNum} = MovieInfo;
handles.moviePool{CurrentNum}=[Filepath,Filename];
set(handles.MoviePool,'String',handles.moviePool');
handles.movieNum=handles.movieNum+1;
else
    Movie=[];
    TempMovie=[];
    display(['This movie is already in the movie pool, it is the movie ',num2str(MovieOverlap)],'!');
end
guidata(hObject,handles)
% handles.moviepool add;
% handles.hashID add;
% check if hash ID is in the handles.movieStore.hashID;
% if yes
%     load movie;
% handles.movieStore renew
% else
% warning the file is already been loaded
% end

% --- Executes on button press in PoolDelete.
function PoolDelete_Callback(hObject, eventdata, handles)
% hObject    handle to PoolDelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MovieIndex=get(handles.MoviePool,'Value');
if(isempty(handles.moviePool))
    return;
end
ListIndex=find(strcmp(handles.movieList,handles.movieStore.HashID{MovieIndex}));
Check=0;
button='Yes';
if(~isempty(ListIndex))
    button = questdlg('This Movie have been inserted into Movie List,still delete?','Delete confirm','Yes','No','Yes');
end
if(isempty(handles.moviePool)||strcmp(button,'No'))
    return;
end
handles.PlayList.String(ListIndex)=[];
handles.movieList(ListIndex)=[];
handles.MoviePool.String(MovieIndex)=[];
handles.movieStore.HashID(MovieIndex)=[];
handles.movieStore.Setting(MovieIndex)=[];
handles.movieStore.RawMovie(MovieIndex)=[];
handles.movieStore.Movie(MovieIndex)=[];
handles.moviePool(MovieIndex)=[];
handles.movieNum=handles.movieNum-1;
if(handles.MoviePool.Value>length(handles.MoviePool.String))
% delete movielist
handles.MoviePool.Value=length(handles.MoviePool.String);
end

if(handles.PlayList.Value>length(handles.PlayList.String))
% delete movielist
handles.PlayList.Value=length(handles.PlayList.String);
end
if(handles.PlayList.Value==0)
handles.PlayList.Value=1;
end
if(handles.MoviePool.Value==0)
    handles.MoviePool.Value=1;
end

guidata(hObject,handles);


% --- Executes on button press in ListUp.
function ListUp_Callback(hObject, eventdata, handles)
% hObject    handle to ListUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ListDown.
function ListDown_Callback(hObject, eventdata, handles)
% hObject    handle to ListDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ListDelete.
function ListDelete_Callback(hObject, eventdata, handles)
% hObject    handle to ListDelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ListIndex=get(handles.PlayList,'Value');
ListSize=size(handles.movieList,2);
if(ListSize>=ListIndex)

    handles.movieList(ListIndex)=[];
    handles.PlayList.String(ListIndex)=[];

end
if(ListSize==1)
handles.PlayList.Value=1;
end

if(handles.PlayList.Value>length(handles.PlayList.String))
% delete movielist
handles.PlayList.Value=length(handles.PlayList.String);
end
if(handles.PlayList.Value==0)
handles.PlayList.Value=1;
end
guidata(hObject,handles);


% --- Executes on button press in ListLoad.
function ListLoad_Callback(hObject, eventdata, handles)
% hObject    handle to ListLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'string',['|',10,'V']);


% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Trigger(handles.IO.Session,1,0);
Trigger(handles.IO.Session,2,0);
tstart = GetSecs;
[m,n]=size(handles.movieList);
%%%%%%%%%%%%%Trigger1
if ~isempty(handles.IO.Session)
    Trigger(handles.IO.Session,1,1);
%     display('Trigger1 is on.');
%     pause(0.5); %Used for the Test.
    Trigger(handles.IO.Session,1,0);
%     display(['Trigger1 is off.',' Trigger last for',num2str(TriggerOffTime-TriggerOnTime),'Seconds']);
end
%%%%%%%%%%%%%%
refresh = Screen('GetFlipInterval', handles.win1);
backGroundTextureIndex=Screen('MakeTexture', handles.win1, handles.backGroundIm);
Screen('DrawTexture', handles.win1, backGroundTextureIndex);
TimeStamp=Screen('Flip', handles.win1);
TimeStamp=TimeStamp + handles.baselineDuration - 0.5 * refresh;

for i = 1:n
    MovieIndex=find(ismember(handles.movieStore.HashID,handles.movieList{i}));
    CheckMovieInfo;
    %%%%%%%%%%%%%Trigger2 Reset
    if ~isempty(handles.IO.Session)
         Trigger(handles.IO.Session,2,0);
    end
    %%%%%%%%%%%%%%
    Trigger2 = 0;    
    
    refresh = Screen('GetFlipInterval', handles.win1);
    % Synchronize to retrace at start of trial/animation loop:
     handles.totalFrames=size(handles.movieStore.Movie{MovieIndex},4);
     handles.patternIm=handles.movieStore.Movie{MovieIndex}(:,:,:,1);
    % vbl = Screen('Flip', handles.win1);
    % Loop: Cycle through 300 images:
    Period=1/refresh/handles.frames;
    if Period-floor(Period)>0.01
        display('Warning!The fresh frequency is not matching the frames or the multipe of frames.')
    end
    Period=round(Period);
    TimeStamp =TimeStamp - (Period-0.5)*refresh; %To make up the additional Timestamp time added in the first frame
    for i=1:handles.totalFrames
    % Draw i'th image to backbuffer:
     handles.patternIm=handles.movieStore.Movie{MovieIndex}(:,:,:,i);
    patternTextureIndex=Screen('MakeTexture', handles.win1, handles.patternIm);
    Screen('DrawTexture', handles.win1, patternTextureIndex);
    TimeStamp = TimeStamp + (Period-0.5)*refresh;
    TimeStamp=Screen('Flip', handles.win1,TimeStamp);
    %%%%%%%%%%%%%Trigger2
    if exist('CurrentSizeTrail','var') %CurrentSizeTrail generated from the CheckMovieInfo script.
        if ~isempty(handles.IO.Session)
        if i==1 && sum(CurrentSizeTrail(:,i))>0
        Trigger(handles.IO.Session,2,1);
        Trigger(handles.IO.Session,2,0);
        Trigger2 = 1;
        elseif sum(CurrentSizeTrail(:,i))>0 && sum(CurrentSizeTrail(:,i-1))==0 &&Trigger2 == 0
            Trigger(handles.IO.Session,2,1);
            display('Spot On Trigger Sent Start.')
            Trigger(handles.IO.Session,2,0);
            GetSecs - tstart
            display('Spot On Trigger Sent Over.')
            Trigger2 = 1;
            display('Trigger2 is on.');
            CurrentSizeTrail(:,i)
            CurrentSizeTrail(:,i-1)
%             GetSecs - tstart
        elseif sum(CurrentSizeTrail(:,i))==0 && sum(CurrentSizeTrail(:,i-1)) > 0&&Trigger2 == 1
%             Trigger(handles.IO.Session,2,1);  
            Trigger(handles.IO.Session,2,0);
            Trigger2 = 0;
        end
        end
    end
    
    
    %%%%%%%%%%%%%%
    clear patternTextureIndex;
    % Screen('DrawTexture', win, myImage(i));
    % Show images exactly 2 refresh cycles apart of each other:
    % vbl = Screen('Flip', win, vbl + (2 - 0.5) * refresh);
    % Keyboard checks, whatever... Next loop iteration.
    end
    %%%%%%%%%%%%%Trigger2 Reset
    if ~isempty(handles.IO.Session)
         Trigger(handles.IO.Session,2,0);
    end
    %%%%%%%%%%%%%%
    Trigger2 = 0;    
    
    if handles.movieInterval>0
    backGroundTextureIndex=Screen('MakeTexture', handles.win1, handles.backGroundIm);
    Screen('DrawTexture', handles.win1, backGroundTextureIndex);
    TimeStamp=Screen('Flip', handles.win1,TimeStamp + (Period-0.5)*refresh);
    TimeStamp = TimeStamp + handles.movieInterval - 0.5 * refresh;
    clear backGroundTextureIndex;
    end
end
TimeStamp = TimeStamp + handles.endbaselineDuration - 0.5 * refresh;
backGroundTextureIndex=Screen('MakeTexture', handles.win1, handles.backGroundIm);
Screen('DrawTexture', handles.win1, backGroundTextureIndex);
Screen('Flip', handles.win1,TimeStamp);
clear backGroundTextureIndex;
guidata(hObject,handles);


% --- Executes on button press in Export.
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Interval_Callback(hObject, eventdata, handles)
% hObject    handle to Interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Interval as text
%        str2double(get(hObject,'String')) returns contents of Interval as a double
handles.movieInterval=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Interval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BaselineDuration_Callback(hObject, eventdata, handles)
% hObject    handle to BaselineDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BaselineDuration as text
%        str2double(get(hObject,'String')) returns contents of BaselineDuration as a double
handles.baselineDuration=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function BaselineDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BaselineDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EndBaselineDuration_Callback(hObject, eventdata, handles)
% hObject    handle to EndBaselineDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndBaselineDuration as text
%        str2double(get(hObject,'String')) returns contents of EndBaselineDuration as a double
handles.endbaselineDuration=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function EndBaselineDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndBaselineDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function StripHeightResolution_Callback(hObject, eventdata, handles)
% hObject    handle to StripHeightResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StripHeightResolution as text
%        str2double(get(hObject,'String')) returns contents of StripHeightResolution as a double
handles.stripHeightResolution=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function StripHeightResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StripHeightResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StripWidthResolution_Callback(hObject, eventdata, handles)
% hObject    handle to StripWidthResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StripWidthResolution as text
%        str2double(get(hObject,'String')) returns contents of StripWidthResolution as a double
handles.stripWidthResolution=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function StripWidthResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StripWidthResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Preview.
function Preview_Callback(hObject, eventdata, handles)
% hObject    handle to Preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MovieIndex=get(handles.MoviePool,'Value');
refresh = Screen('GetFlipInterval', handles.win1);
 % Synchronize to retrace at start of trial/animation loop:
 handles.totalFrames=size(handles.movieStore.Movie{MovieIndex},4);
 handles.patternIm=handles.movieStore.Movie{MovieIndex}(:,:,:,1);
 try 
     handles.frames = handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo.FreshRate;
 catch error
     display(error.message);
 end
 Refresh;
% vbl = Screen('Flip', handles.win1);
% Loop: Cycle through 300 images:
Period=1/refresh/handles.frames;
if Period-floor(Period)>0.01
    display('Warning!The fresh frequency is not matching the frames or the multipe of frames.')
end
Period=round(Period);
CheckMovieInfo;
Trigger2 = 0;
for i=1:handles.totalFrames
% Draw i'th image to backbuffer:
 handles.patternIm=handles.movieStore.Movie{MovieIndex}(:,:,:,i);
patternTextureIndex=Screen('MakeTexture', handles.win1, handles.patternIm);
Screen('DrawTexture', handles.win1, patternTextureIndex);
TimeStamp=Screen('Flip', handles.win1,TimeStamp+(Period-0.5)*refresh);
%%%%%%%%%%%%%Trigger2
SpotOnTrigger;
%%%%%%%%%%%%%%
clear patternTextureIndex;
% Screen('DrawTexture', win, myImage(i));
% Show images exactly 2 refresh cycles apart of each other:
% vbl = Screen('Flip', win, vbl + (2 - 0.5) * refresh);
% Keyboard checks, whatever... Next loop iteration.
end;

%%%%%%%%%%%%%Trigger2 Reset
if ~isempty(handles.IO.Session)
    Trigger(handles.IO.Session,2,0);
end
%%%%%%%%%%%%%%
Trigger2 = 0;    

% End of animation loop, blank screen, record offset time:
% toffset = Screen('Flip', win, vbl + (2 - 0.5) * refresh);



function PhysicalHeight_Callback(hObject, eventdata, handles)
% hObject    handle to PhysicalHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.physicalHeight = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of PhysicalHeight as text
%        str2double(get(hObject,'String')) returns contents of PhysicalHeight as a double
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function PhysicalHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PhysicalHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function figure1_DeleteFcn(hObject,eventdata,handles)

function PhysicalWidth_Callback(hObject, eventdata, handles)
% hObject    handle to PhysicalWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.physicalWidth = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of PhysicalWidth as text
%        str2double(get(hObject,'String')) returns contents of PhysicalWidth as a double
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function PhysicalWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PhysicalWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
