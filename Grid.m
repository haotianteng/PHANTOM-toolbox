function varargout = Grid(varargin)
% GRID MATLAB code for Grid.fig
%      GRID, by itself, creates a new GRID or raises the existing
%      singleton*.
%
%      H = GRID returns the handle to a new GRID or the handle to
%      the existing singleton*.
%
%      GRID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRID.M with the given input arguments.
%
%      GRID('Property','Value',...) creates a new GRID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Grid_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Grid_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Grid

% Last Modified by GUIDE v2.5 04-Jul-2016 15:12:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Grid_OpeningFcn, ...
                   'gui_OutputFcn',  @Grid_OutputFcn, ...
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


% --- Executes just before Grid is made visible.
function Grid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Grid (see VARARGIN)

% Choose default command line output for Grid
handles.output = [];
guidata(hObject, handles);
set(handles.figure1,'WindowStyle','modal')
uiwait(handles.figure1);

% Update handles structure

% UIWAIT makes Grid wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Grid_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;
if(size(handles.output,2)>=3)
delete(handles.figure1);
end


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output(1)=str2num(get(handles.GridColumn,'String'));
handles.output(2)=str2num(get(handles.GridRow,'String'));
handles.output(3)=str2num(get(handles.GridThickness,'String'));
if(size(handles.output,2)>=2)
uiresume(handles.figure1);
else
    display('Error!Input the correct column number and the row number of the grid.')
end
guidata(hObject,handles);



function GridColumn_Callback(hObject, eventdata, handles)
% hObject    handle to GridColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output(1)=str2num(get(hObject,'String'));
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of GridColumn as text
%        str2double(get(hObject,'String')) returns contents of GridColumn as a double


% --- Executes during object creation, after setting all properties.
function GridColumn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GridColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GridRow_Callback(hObject, eventdata, handles)
% hObject    handle to GridRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output(2)=str2num(get(hObject,'String'));
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of GridRow as text
%        str2double(get(hObject,'String')) returns contents of GridRow as a double


% --- Executes during object creation, after setting all properties.
function GridRow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GridRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GridThickness_Callback(hObject, eventdata, handles)
% hObject    handle to GridThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output(3)=str2num(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of GridThickness as text
%        str2double(get(hObject,'String')) returns contents of GridThickness as a double


% --- Executes during object creation, after setting all properties.
function GridThickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GridThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
