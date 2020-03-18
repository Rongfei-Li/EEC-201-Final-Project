function varargout = Interface(varargin)
% INTERFACE MATLAB code for Interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface

% Last Modified by GUIDE v2.5 18-Mar-2020 04:36:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
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


% --- Executes just before Interface is made visible.
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface (see VARARGIN)

% Choose default command line output for Interface
handles.output = hObject;
run('feature_extraction_main.m');
initial_str = ('Database successfully loaded');
set(handles.Textshowup,'string',initial_str);
initial_str2 = ('please input your name');
set(handles.registertext,'string',initial_str2);
% Update handles structure
dlmwrite('Codebook_series.dat', Codebook_series);
guidata(hObject, handles);

% UIWAIT makes Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Recordbutton.
function Recordbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Recordbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
Fs=12500;
recObj = audiorecorder(Fs,16,1);
current_str = ('Start speaking.');
set(handles.Textshowup,'string',current_str);
recordblocking(recObj, 1.5);
current_str =('End of Recording.');
set(handles.Textshowup,'string',current_str);
currenty = getaudiodata(recObj);
N = 256;
M = 100;
Cepstrumt = mfcc(currenty, Fs,M,N);
dlmwrite('Cepstrumt.dat', Cepstrumt);
filename = 'Current_test.wav';
audiowrite(filename,currenty,Fs);
guidata(hObject, handles);


% --- Executes on button press in verifybutton.
function verifybutton_Callback(hObject, eventdata, handles)
% hObject    handle to verifybutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
Codebook_series = load('Codebook_series.dat');
Codebook_new = load('Codebook_new.dat');
Cepstrumt = load('Cepstrumt.dat');
logic = identify_user(Codebook_series,Codebook_new ,Cepstrumt,16);

str = get(handles.Userinput,'string');
if logic == 1
    StrOut = ['Hello ',str,'!'];
else
    StrOut = ' No user identified';
end
set(handles.Textshowup,'string',StrOut);
guidata(hObject, handles);


% --- Executes on button press in playbutton.
function playbutton_Callback(hObject, eventdata, handles)
% hObject    handle to playbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
[currenty,Fs] = audioread('Current_test.wav');
current_str =('playing Record Sound');
set(handles.Textshowup,'string',current_str);
sound(currenty,Fs);
guidata(hObject, handles);







% --- Executes on button press in verifybutton.
function Textshowup_Callback(hObject, eventdata, handles)
% hObject    handle to verifybutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in Register.
function Register_Callback(hObject, eventdata, handles)
% hObject    handle to Register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
Fs=12500;
recObj = audiorecorder(Fs,16,1);
current_str = ('Start speaking.');
set(handles.registertext,'string',current_str);
recordblocking(recObj, 1.5);
current_str =('End of Recording.');
set(handles.registertext,'string',current_str);
currenty = getaudiodata(recObj);
N = 256;
M = 100;
L = 16;
Cepstrum_new = mfcc(currenty, Fs,M,N);
Codebook_new = testvq(Cepstrum_new,L);
dlmwrite('Codebook_new.dat', Codebook_new);
filename = 'Current_train.wav';
audiowrite(filename,currenty,Fs);
guidata(hObject, handles);


% --- Executes on button press in playback.
function playback_Callback(hObject, eventdata, handles)
% hObject    handle to playback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
[currenty,Fs] = audioread('Current_train.wav');
current_str =('playing Record Sound');
set(handles.registertext,'string',current_str);
sound(currenty,Fs);
guidata(hObject, handles);


function Userinput_Callback(hObject, eventdata, handles)
% hObject    handle to Userinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Userinput as text
%        str2double(get(hObject,'String')) returns contents of Userinput as a double
handles.output = hObject;
str = get(handles.Userinput,'string');
current_str = [str,' registered'];
set(handles.registertext,'string',current_str);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Userinput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Userinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function registertext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to registertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
