function varargout = appRVC(varargin)
% APPRVC MATLAB code for appRVC.fig
%      APPRVC, by itself, creates a new APPRVC or raises the existing
%      singleton*.
%
%      H = APPRVC returns the handle to a new APPRVC or the handle to
%      the existing singleton*.
%
%      APPRVC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPRVC.M with the given input arguments.
%
%      APPRVC('Property','Value',...) creates a new APPRVC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before appRVC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to appRVC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help appRVC

% Last Modified by GUIDE v2.5 15-Oct-2019 21:32:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @appRVC_OpeningFcn, ...
                   'gui_OutputFcn',  @appRVC_OutputFcn, ...
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


% --- Executes just before appRVC is made visible.
function appRVC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to appRVC (see VARARGIN)

% Choose default command line output for appRVC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes appRVC wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global R q;
R = LBRiiwa();
q = [0 0 0 0 0 0 0];
updateDataQ(handles);
updateJacobian(handles);
updatePlot();


% --- Outputs from this function are returned to the command line.
function varargout = appRVC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function robotFig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to robotFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate robotFig


% --- Executes during object creation, after setting all properties.
function tableDH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tableDH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%load('denavit_hartenberg', 'DH');
%set(handles.tableDH, 'data', DH);

%==========================================================================
%% CINEMÁTICA DIRECTA
% --- Executes on button press in buttonCD.
function buttonCD_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global R q T;
T = R.fkine(q);
updateDataT(handles);
updateJacobian(handles);
%==========================================================================


function q1_Callback(hObject, eventdata, handles)
% hObject    handle to q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q1 as text
%        str2double(get(hObject,'String')) returns contents of q1 as a double
global q;
aux = str2double(get(hObject, 'String'));
set(handles.sliderQ1, 'Value', aux);
q(1) = deg2rad(aux);
updatePlot();


% --- Executes during object creation, after setting all properties.
function q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q2_Callback(hObject, eventdata, handles)
% hObject    handle to q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q2 as text
%        str2double(get(hObject,'String')) returns contents of q2 as a double
global q;
aux = str2double(get(hObject, 'String'));
set(handles.sliderQ2, 'Value', aux);
q(2) = deg2rad(aux);
updatePlot();

% --- Executes during object creation, after setting all properties.
function q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function q3_Callback(hObject, eventdata, handles)
% hObject    handle to q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q3 as text
%        str2double(get(hObject,'String')) returns contents of q3 as a double
global q;
aux = str2double(get(hObject, 'String'));
set(handles.sliderQ3, 'Value', aux);
q(3) = deg2rad(aux);
updatePlot();

% --- Executes during object creation, after setting all properties.
function q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function q4_Callback(hObject, eventdata, handles)
% hObject    handle to q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q4 as text
%        str2double(get(hObject,'String')) returns contents of q4 as a double
global q;
aux = str2double(get(hObject, 'String'));
set(handles.sliderQ4, 'Value', aux);
q(4) = deg2rad(aux);
updatePlot();

% --- Executes during object creation, after setting all properties.
function q4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q5_Callback(hObject, eventdata, handles)
% hObject    handle to q5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q5 as text
%        str2double(get(hObject,'String')) returns contents of q5 as a double
global q;
aux = str2double(get(hObject, 'String'));
set(handles.sliderQ5, 'Value', aux);
q(5) = deg2rad(aux);
updatePlot();

% --- Executes during object creation, after setting all properties.
function q5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function q6_Callback(hObject, eventdata, handles)
% hObject    handle to q6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q6 as text
%        str2double(get(hObject,'String')) returns contents of q6 as a double
global q;
aux = str2double(get(hObject, 'String'));
set(handles.sliderQ6, 'Value', aux);
q(6) = deg2rad(aux);
updatePlot();


% --- Executes during object creation, after setting all properties.
function q6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function q7_Callback(hObject, eventdata, handles)
% hObject    handle to q7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q7 as text
%        str2double(get(hObject,'String')) returns contents of q7 as a double
global q;
aux = str2double(get(hObject, 'String'));
set(handles.sliderQ7, 'Value', aux);
q(7) = deg2rad(aux);
updatePlot();

% --- Executes during object creation, after setting all properties.
function q7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliderQ1_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global q;
aux = get(hObject, 'Value');
set(handles.q1, 'String', num2str(aux));
q(1) = deg2rad(aux);
updateJacobian(handles);
updatePlot();


% --- Executes during object creation, after setting all properties.
function sliderQ1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global R;
set(hObject, 'Min', rad2deg(R.qlim(1, 1)));
set(hObject, 'Max', rad2deg(R.qlim(1, 2)));


% --- Executes on slider movement.
function sliderQ2_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global q;
aux = get(hObject, 'Value');
set(handles.q2, 'String', num2str(aux));
q(2) = deg2rad(aux);
updateJacobian(handles);
updatePlot();

% --- Executes during object creation, after setting all properties.
function sliderQ2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global R;
set(hObject, 'Min', rad2deg(R.qlim(2, 1)));
set(hObject, 'Max', rad2deg(R.qlim(2, 2)));


% --- Executes on slider movement.
function sliderQ3_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global q;
aux = get(hObject, 'Value');
set(handles.q3, 'String', num2str(aux));
q(3) = deg2rad(aux);
updateJacobian(handles);
updatePlot();

% --- Executes during object creation, after setting all properties.
function sliderQ3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global R;
set(hObject, 'Min', rad2deg(R.qlim(3, 1)));
set(hObject, 'Max', rad2deg(R.qlim(3, 2)));


% --- Executes on slider movement.
function sliderQ4_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global q;
aux = get(hObject, 'Value');
set(handles.q4, 'String', num2str(aux));
q(4) = deg2rad(aux);
updateJacobian(handles);
updatePlot();

% --- Executes during object creation, after setting all properties.
function sliderQ4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global R;
set(hObject, 'Min', rad2deg(R.qlim(4, 1)));
set(hObject, 'Max', rad2deg(R.qlim(4, 2)));


% --- Executes on slider movement.
function sliderQ5_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global q;
aux = get(hObject, 'Value');
set(handles.q5, 'String', num2str(aux));
q(5) = deg2rad(aux);
updateJacobian(handles);
updatePlot();

% --- Executes during object creation, after setting all properties.
function sliderQ5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global R;
set(hObject, 'Min', rad2deg(R.qlim(5, 1)));
set(hObject, 'Max', rad2deg(R.qlim(5, 2)));


% --- Executes on slider movement.
function sliderQ6_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global q;
aux = get(hObject, 'Value');
set(handles.q6, 'String', num2str(aux));
q(6) = deg2rad(aux);
updateJacobian(handles);
updatePlot();

% --- Executes during object creation, after setting all properties.
function sliderQ6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global R;
set(hObject, 'Min', rad2deg(R.qlim(6, 1)));
set(hObject, 'Max', rad2deg(R.qlim(6, 2)));


% --- Executes on slider movement.
function sliderQ7_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQ7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global q;
aux = get(hObject, 'Value');
set(handles.q7, 'String', num2str(aux));
q(7) = deg2rad(aux);
updateJacobian(handles);
updatePlot();

% --- Executes during object creation, after setting all properties.
function sliderQ7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQ7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global R;
set(hObject, 'Min', rad2deg(R.qlim(7, 1)));
set(hObject, 'Max', rad2deg(R.qlim(7, 2)));

%==========================================================================
%% WORKSPACE BUTTON
% --- Executes on button press in buttonWorkspace.
function buttonWorkspace_Callback(hObject, eventdata, handles)
% hObject    handle to buttonWorkspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global R q;
load('workspace', 'wo');
R.plot(wo, 'trail', 'r-');
q = wo(length(wo(:, 1)), :);
updateDataQ(handles);
%==========================================================================

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
%% Coordenada X en espacio cartesiano
function editX_Callback(hObject, eventdata, handles)
% hObject    handle to editX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editX as text
%        str2double(get(hObject,'String')) returns contents of editX as a double
global T;
T.t(1) = str2double(get(hObject, 'String'));
updateDataT(handles);

% --- Executes during object creation, after setting all properties.
function editX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%==========================================================================
%% Coordenada Y en espacio cartesiano
function editY_Callback(hObject, eventdata, handles)
% hObject    handle to editY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editY as text
%        str2double(get(hObject,'String')) returns contents of editY as a double
global T;
T.t(2) = str2double(get(hObject, 'String'));
updateDataT(handles);

% --- Executes during object creation, after setting all properties.
function editY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%==========================================================================
%% Coordenada Z en espacio cartesiano
function editZ_Callback(hObject, eventdata, handles)
% hObject    handle to editZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZ as text
%        str2double(get(hObject,'String')) returns contents of editZ as a double
global T;
T.t(3) = str2double(get(hObject, 'String'));
updateDataT(handles);

% --- Executes during object creation, after setting all properties.
function editZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%==========================================================================
%% Rotación en eje X en espacio cartesiano (Roll)
function editRoll_Callback(hObject, eventdata, handles)
% hObject    handle to editRoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRoll as text
%        str2double(get(hObject,'String')) returns contents of editRoll as a double

% --- Executes during object creation, after setting all properties.
function editRoll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPitch_Callback(hObject, eventdata, handles)
% hObject    handle to editPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPitch as text
%        str2double(get(hObject,'String')) returns contents of editPitch as a double


% --- Executes during object creation, after setting all properties.
function editPitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editYaw_Callback(hObject, eventdata, handles)
% hObject    handle to editYaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editYaw as text
%        str2double(get(hObject,'String')) returns contents of editYaw as a double


% --- Executes during object creation, after setting all properties.
function editYaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editYaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function updateDataQ(handles)

global q;

set(handles.q1, 'String', q(1));
set(handles.q2, 'String', q(2));
set(handles.q3, 'String', q(3));
set(handles.q4, 'String', q(4));
set(handles.q5, 'String', q(5));
set(handles.q6, 'String', q(6));
set(handles.q7, 'String', q(7));

set(handles.sliderQ1, 'Value', q(1));
set(handles.sliderQ2, 'Value', q(2));
set(handles.sliderQ3, 'Value', q(3));
set(handles.sliderQ4, 'Value', q(4));
set(handles.sliderQ5, 'Value', q(5));
set(handles.sliderQ6, 'Value', q(6));
set(handles.sliderQ7, 'Value', q(7));


function updateDataT(handles)

global T;

set(handles.tableT, 'data', T.T);
set(handles.editX, 'String', num2str(T.t(1)));
set(handles.editY, 'String', num2str(T.t(2)));
set(handles.editZ, 'String', num2str(T.t(3)));

aux = T.tr2rpy;
set(handles.editRoll, 'String', num2str(rad2deg(aux(1))));
set(handles.editPitch, 'String', num2str(rad2deg(aux(2))));
set(handles.editYaw, 'String', num2str(rad2deg(aux(3))));

function updateJacobian(handles)
global R q J;
switch get(handles.popupmenuCI, 'Value')
    case 1
        J = iiwa_jacobian(R, q, 'normal');
    case 2
        J = iiwa_jacobian(R, q, 'simplify');
        set(handles.editDetJ, 'String', num2str(det(J)));
        set(handles.editManip, 'String', num2str(R.maniplty(q, 'yoshikawa')));
end
set(handles.editRankJ, 'String', num2str(rank(J)));
set(handles.textJsinguValue, 'String', m_jsingu(J));

function updatePlot()
global R q J flag_ci flag_ellipseV flag_ellipseW E;
R.plot(q);
C = R.fkine(q).t';
if (flag_ci == 2) && (flag_ellipseV == 1)
    if isvalid(E)
        plot_ellipse(ellipsoid(J, 'tras'), C, 'alter', E);
    else
        E = plot_ellipse(ellipsoid(J, 'tras'), C, 'alpha', 0);
    end
elseif (flag_ci == 2) && (flag_ellipseW == 1)
    if isvalid(E)
        plot_ellipse(ellipsoid(J, 'rot'), C, 'alter', E, 'r');
    else
        E = plot_ellipse(ellipsoid(J, 'rot'), C, 'alpha', 0);
    end
else
    delete(E);
end


function E = ellipsoid(J, tag)
    switch tag
        case 'tras'
            E = J(1:3, :);
        case 'rot'
            E = J(4:6, :);
    end
    E = E*E';

%==========================================================================
%% CÁLCULO DE LA CINEMÁTICA INVERSA
% --- Executes on button press in buttonCI.
function buttonCI_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global R q T flag_ci;
if (flag_ci == 1)
    q = R.ikine(T);
    R.plot(q);
elseif (flag_ci == 2)
    aux = T.tr2rpy;
    q_lst = iiwa_inverse(R, T.t(1), T.t(2), T.t(3), aux(1), aux(2), aux(3));
    disp(q_lst);
    R.plot(q_lst);
%     for i=1:length(q_lst(:, 1))
%         q = q_lst(i, :);
%         R.plot(q);
%         pause();
%     end
end
updateDataQ(handles);
%==========================================================================
%% MÉTODO DE CINEMÁTICA INVERSA
% --- Executes on selection change in popupmenuCI.
function popupmenuCI_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuCI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuCI contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuCI
global flag_ci;
flag_ci = get(hObject, 'Value');

% --- Executes during object creation, after setting all properties.
function popupmenuCI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuCI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'Value', 2);

%==========================================================================
%% HABILITACIÓN DE ELIPSOIDES DE MANIOBRABILIDAD

% --- Executes during object creation, after setting all properties.
function checkEllipseV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkEllipseV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Value', 0);

% --- Executes during object creation, after setting all properties.
function checkEllipseW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkEllipseW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Value', 0);

% --- Executes on button press in checkEllipseV.
function checkEllipseV_Callback(hObject, eventdata, handles)
% hObject    handle to checkEllipseV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkEllipseV
global flag_ellipseV flag_ellipseW;
flag_ellipseV = get(hObject, 'Value');
if flag_ellipseV
    flag_ellipseW = 0;
    set(handles.checkEllipseW, 'Value', 0);
    updatePlot();
end

%%% ELIPSOIDE ASOCIADO A VELOCIDAD ROTACIONAL
% --- Executes on button press in checkEllipseW.
function checkEllipseW_Callback(hObject, eventdata, handles)
% hObject    handle to checkEllipseW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkEllipseW
global flag_ellipseV flag_ellipseW;
flag_ellipseW = get(hObject, 'Value');
if flag_ellipseW
    flag_ellipseV = 0;
    set(handles.checkEllipseV, 'Value', 0);
    updatePlot();
end
%==========================================================================



function editDetJ_Callback(hObject, eventdata, handles)
% hObject    handle to editDetJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDetJ as text
%        str2double(get(hObject,'String')) returns contents of editDetJ as a double


% --- Executes during object creation, after setting all properties.
function editDetJ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDetJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editManip_Callback(hObject, eventdata, handles)
% hObject    handle to editManip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editManip as text
%        str2double(get(hObject,'String')) returns contents of editManip as a double


% --- Executes during object creation, after setting all properties.
function editManip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editManip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
%% RESET BUTTON
% --- Executes on button press in buttonReset.
function buttonReset_Callback(hObject, eventdata, handles)
% hObject    handle to buttonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global q;
q = [0 0 0 0 0 0 0];
updateDataQ(handles);
updatePlot();
%==========================================================================

function editRankJ_Callback(hObject, eventdata, handles)
% hObject    handle to editRankJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRankJ as text
%        str2double(get(hObject,'String')) returns contents of editRankJ as a double


% --- Executes during object creation, after setting all properties.
function editRankJ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRankJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editJsingu_Callback(hObject, eventdata, handles)
% hObject    handle to editJsingu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editJsingu as text
%        str2double(get(hObject,'String')) returns contents of editJsingu as a double


% --- Executes during object creation, after setting all properties.
function editJsingu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editJsingu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in textJsinguValue.
function textJsinguValue_Callback(hObject, eventdata, handles)
% hObject    handle to textJsinguValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns textJsinguValue contents as cell array
%        contents{get(hObject,'Value')} returns selected item from textJsinguValue


% --- Executes during object creation, after setting all properties.
function textJsinguValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textJsinguValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
