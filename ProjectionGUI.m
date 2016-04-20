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
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProjectionGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectionGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
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
clc
% Choose default command line output for ProjectionGUI
handles.output = hObject;
addpath('mtimesx');
handles.GaussFilter='True';
set(handles.WidthStrip,'String','180');%stripWidth is in degree unit.
set(handles.HeightStrip,'String','10');
set(handles.PhysicalHeight,'String','60');
set(handles.PhysicalWidth,'String','80');
handles.physicalHeight=60;
handles.physicalWidth=80;
handles.stripHeight=10;
handles.stripWidth=180;
handles.stripHeightResolution=0.01;
handles.stripWidthResolution=0.1;
handles.distance=174;
handles.z0=5;
handles.gamma=0;
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
guidata(handles,hObject);

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
set(handles.WhiteBackGroundColor,'Value',0);
set(handles.BlueBackGroundColor,'Value',0);
set(handles.CustomizedBackGroundColorCheck,'Value',1);
set(handles.RCustomizedColor,'enable','on');
set(handles.GCustomizedColor,'enable','on');
set(handles.BCustomizedColor,'enable','on');
R=str2num(get(handles.RCustomizedColor,'String'));
G=str2num(get(handles.GCustomizedColor,'String'));
B=str2num(get(handles.BCustomizedColor,'String'));
if(isempty(R)||isempty(G)||isempty(B))
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
guidata(handles,hObject);

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
set(handles.FreshRate,'String',['FreshRate is ',num2str(handles.freshRate),' now']);
[H,W]=Screen('windowsize',win1)
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
Transform;
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
Transform;
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
Transform;
Refresh;
guidata(hObject,handles);


% --- Executes on button press in InclineDown.
function InclineDown_Callback(hObject, eventdata, handles)
% hObject    handle to InclineDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gamma=handles.gamma-1;
set(handles.Gamma,'String',handles.gamma);
Transform;
Refresh;
guidata(hObject,handles);



function RCustomizedColor_Callback(hObject, eventdata, handles)
% hObject    handle to RCustomizedColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


for i=1:hGrid(1)
handles.effectIm(:,1+round((i-1)*(Width-1)/(hGrid(1)-1)),:)=0;
end

for i=1:hGrid(2)
handles.effectIm(1+round((i-1)*(Height-1)/(hGrid(2)-1)),:,:)=0;
end

% handles.effectIm(:,:,:)=0;

% handles.effectIm(1:100,1:100,:)=0;hGrid

%
%Project transformed
Transform;%Transformed the effectIm to the real project Im.
% handles.patternIm=handles.effectIm;
%
Refresh;

guidata(hObject,handles);



function SpotSize_Callback(hObject, eventdata, handles)
% hObject    handle to SpotSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SpotSize as text
%        str2double(get(hObject,'String')) returns contents of SpotSize as a double
handles.spotSize=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function SpotSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpotSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SpotHeight_Callback(hObject, eventdata, handles)
% hObject    handle to SpotHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SpotHeight as text
%        str2double(get(hObject,'String')) returns contents of SpotHeight as a double
handles.spotHeight=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function SpotHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpotHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SpotSepDegrees_Callback(hObject, eventdata, handles)
% hObject    handle to SpotSepDegrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SpotSepDegrees as text
%        str2double(get(hObject,'String')) returns contents of SpotSepDegrees as a double
handles.spotSeperateDegrees=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function SpotSepDegrees_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpotSepDegrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SpotNumber_Callback(hObject, eventdata, handles)
% hObject    handle to SpotNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SpotNumber as text
%        str2double(get(hObject,'String')) returns contents of SpotNumber as a double
handles.spotNumber=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function SpotNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpotNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SpotOrder.
function SpotOrder_Callback(hObject, eventdata, handles)
% hObject    handle to SpotOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SpotOrder contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SpotOrder
handles.spotOrder=get(hObject,'value');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function SpotOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpotOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string',{'Random Order','Increasing Order','Decreasing Order'});


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
Transform;
Refresh;
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
handles.gamma=str2num(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of Gamma as text
%        str2double(get(hObject,'String')) returns contents of Gamma as a double
Transform;
Refresh;
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
[Filename,Filepath,FilterIndex]=uiputfile('*.mat','Save as','Movie1.mat');
if(Filename==0)
    return;
end
display('Movie Generated begin, wait until succeed.')
tstart=tic();
Height=ceil(handles.stripHeight/handles.stripHeightResolution)+1;
Width=ceil(handles.stripWidth/handles.stripWidthResolution)+1;
%Test if the image is out of boundary
if((handles.spotNumber-1)*handles.spotSeperateDegrees+handles.spotSize*2<180&&handles.spotSize*handles.dishRadius*2*pi/180<handles.stripHeight)
handles.totalFrames=((handles.spotNumber-1)*handles.spotInterval+handles.spotNumber*handles.spotOnTime)*handles.frames;
CurrentNum=handles.movieNum+1;
handles.movieStore(1).RawMovie{CurrentNum}=ones(Height,Width,3);
handles.movieStore(1).Movie{CurrentNum}=zeros(handles.fieldHeight,handles.fieldWidth,3,handles.totalFrames,'uint8');
%Construct the spot or the bar
handles.object=[];
switch handles.spotOrder
    case handles.g_RandomOrder
        Order=randperm(handles.spotNumber);
    case handles.g_IncreasingOrder
        Order=1:handles.spotNumber;
    case handles.g_DecreasingOrder
        Order=handles.spotNumber:-1:1;
end
SpotX=(handles.stripWidth-(handles.spotNumber-1)*handles.spotSeperateDegrees)/2:handles.spotSeperateDegrees:(handles.stripWidth+(handles.spotNumber-1)*handles.spotSeperateDegrees)/2;
SpotY=ones(1,handles.spotNumber)*handles.spotHeight;
OrderFrame=zeros(1,handles.totalFrames);
Duration=handles.spotOnTime+handles.spotInterval;
for i=1:handles.spotNumber

    if (i==handles.spotNumber)
        OrderFrame(Duration*handles.frames*(i-1)+1:1:handles.totalFrames)=Order(i);
    else
        OrderFrame(Duration*handles.frames*(i-1)+1:1:Duration*handles.frames*(i-1)+handles.spotOnTime*handles.frames)=Order(i);
        OrderFrame(Duration*handles.frames*(i-1)+handles.spotOnTime*handles.frames+1:1:Duration*handles.frames*i)=0;
    end
    
end
GenObject;%Generate the object e.g. solid/checkerboard spot/bar
for i=1:3
    handles.movieStore.RawMovie{CurrentNum}(:,:,i)=handles.backGroundColor(i)*255;
end

for CurrentFrame=1:handles.totalFrames
    handles.effectIm=[];
    handles.patternIm=[];
    GenMovie;
    if(CurrentFrame>1)&& isequal(handles.movieStore.RawMovie{CurrentNum}(:,:,:),handles.effectIm)
            handles.movieStore.Movie{CurrentNum}(:,:,:,CurrentFrame)=handles.movieStore.Movie{CurrentNum}(:,:,:,CurrentFrame-1);
    else
            Transform;
            handles.movieStore.Movie{CurrentNum}(:,:,:,CurrentFrame)=handles.patternIm;
    end
    handles.movieStore.RawMovie{CurrentNum}(:,:,:)=handles.effectIm;
end
display('Movie generated successfully! Check the overlap.');
TempMovie=handles.movieStore.Movie{CurrentNum};
delete([Filepath,Filename]);
save([Filepath,Filename],'TempMovie','-v7.3');
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
    delete([Filepath,Filename]);
end
else
    display('---------------------------------------');
    display('Error! The spot is out of the boundary.');
    display('---------------------------------------');
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
Movie=load([Filepath,Filename]);
display('Movie Loaded successfully, check overlap.')
TempMovie=Movie.TempMovie;
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



function SpotOnTime_Callback(hObject, eventdata, handles)
% hObject    handle to SpotOnTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SpotOnTime as text
%        str2double(get(hObject,'String')) returns contents of SpotOnTime as a double
handles.spotOnTime=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function SpotOnTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpotOnTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double
handles.spotInterval=str2double(get(hObject,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Entity.
function Entity_Callback(hObject, eventdata, handles)
% hObject    handle to Entity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Entity contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Entity
handles.entity=get(hObject,'value');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Entity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Entity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string',{'Spot','Bar'});


% --- Executes on selection change in Surface.
function Surface_Callback(hObject, eventdata, handles)
% hObject    handle to Surface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Surface contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Surface
handles.surface=get(hObject,'value');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Surface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Surface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string',{'Solid','Checkerboard'});


% --- Executes on selection change in Movement.
function Movement_Callback(hObject, eventdata, handles)
% hObject    handle to Movement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Movement contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Movement
handles.movement=get(hObject,'value');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Movement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Movement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
% See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string',{'Horizontal','Vertical'});



function Frames_Callback(hObject, eventdata, handles)
% hObject    handle to Frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Frames as text
%        str2double(get(hObject,'String')) returns contents of Frames as a double
handles.frames=str2double(get(hObject,'String'));
guidata(handles,hObject);

% --- Executes during object creation, after setting all properties.
function Frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frames (see GCBO)
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
handles.stripHeightResolution=str2double(get(HoBject,'String'));
guidata(handles,hObject);

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
handles.stripWidthResolution=get(hObejct,'String');
guidata(handles,hObject);

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
 Refresh;
% vbl = Screen('Flip', handles.win1);
% Loop: Cycle through 300 images:
Period=1/refresh/handles.frames;
if Period-floor(Period)>0.01
    display('Warning!The fresh frequency is not matching the frames or the multipe of frames.')
end
Period=round(Period);
    
for i=1:handles.totalFrames
% Draw i'th image to backbuffer:
 handles.patternIm=handles.movieStore.Movie{MovieIndex}(:,:,:,i);
patternTextureIndex=Screen('MakeTexture', handles.win1, handles.patternIm);
Screen('DrawTexture', handles.win1, patternTextureIndex);
TimeStamp=Screen('Flip', handles.win1,TimeStamp+(Period-0.5)*refresh);
% Screen('DrawTexture', win, myImage(i));
% Show images exactly 2 refresh cycles apart of each other:
% vbl = Screen('Flip', win, vbl + (2 - 0.5) * refresh);
% Keyboard checks, whatever... Next loop iteration.
end;
% End of animation loop, blank screen, record offset time:
% toffset = Screen('Flip', win, vbl + (2 - 0.5) * refresh);



function PhysicalHeight_Callback(hObject, eventdata, handles)
% hObject    handle to PhysicalHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PhysicalHeight as text
%        str2double(get(hObject,'String')) returns contents of PhysicalHeight as a double


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



function PhysicalWidth_Callback(hObject, eventdata, handles)
% hObject    handle to PhysicalWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PhysicalWidth as text
%        str2double(get(hObject,'String')) returns contents of PhysicalWidth as a double


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
