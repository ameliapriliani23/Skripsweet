function varargout = steganografi(varargin)
% STEGANOGRAFI MATLAB code for steganografi.fig
%      STEGANOGRAFI, by itself, creates a new STEGANOGRAFI or raises the existing
%      singleton*.
%
%      H = STEGANOGRAFI returns the handle to a new STEGANOGRAFI or the handle to
%      the existing singleton*.
%
%      STEGANOGRAFI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGANOGRAFI.M with the given input arguments.
%
%      STEGANOGRAFI('Property','Value',...) creates a new STEGANOGRAFI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before steganografi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to steganografi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help steganografi

% Last Modified by GUIDE v2.5 16-Jun-2018 20:45:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @steganografi_OpeningFcn, ...
                   'gui_OutputFcn',  @steganografi_OutputFcn, ...
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


% --- Executes just before steganografi is made visible.
function steganografi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to steganografi (see VARARGIN)

% Choose default command line output for steganografi
handles.output = hObject;

image = imread('lena.bmp');
axes(handles.axes2);
imshow(image);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes steganografi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = steganografi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse_image.
function browse_image_Callback(hObject, eventdata, handles)
% hObject    handle to browse_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function kolom_lokasi_Callback(hObject, eventdata, handles)
% hObject    handle to kolom_lokasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kolom_lokasi as text
%        str2double(get(hObject,'String')) returns contents of kolom_lokasi as a double


% --- Executes during object creation, after setting all properties.
function kolom_lokasi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kolom_lokasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pesan_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pesan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pesan as text
%        str2double(get(hObject,'String')) returns contents of edit_pesan as a double


% --- Executes during object creation, after setting all properties.
function edit_pesan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pesan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_encoding.
function pushbutton_encoding_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_encoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_decoding.
function pushbutton_decoding_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
