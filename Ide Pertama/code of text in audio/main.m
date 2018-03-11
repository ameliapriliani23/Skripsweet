function varargout = main(varargin)
% MAIN M-file for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

a=ones(300,512);
axes(handles.axes1);
imshow(a);
axes(handles.axes2);
imshow(a);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in playaudio.
function playaudio_Callback(hObject, eventdata, handles)
% hObject    handle to playaudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


a=handles.a;
wavplay(a,44100);


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


exit;


% --- Executes on button press in inputaudio.
function inputaudio_Callback(hObject, eventdata, handles)
% hObject    handle to inputaudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.wav', 'Pick an audio');
if isequal(filename,0) || isequal(pathname,0)
    warndlg('Audio is not selected');
else
    a=wavread(filename);
    axes(handles.axes1);
    plot(a);
%     disp(a);
    handles.filename=filename;
    handles.a=a;
    guidata(hObject, handles);
    helpdlg('Input audio is Selected');
end



% --- Executes on button press in secretdata.
function secretdata_Callback(hObject, eventdata, handles)
% hObject    handle to secretdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.txt', 'Pick any txt file');
if isequal(filename,0) || isequal(pathname,0)
	warndlg('txt file is not selected');
else
    fid = fopen(filename,'r');
	F = fread(fid);
	s = char(F');
	fclose(fid);
end
handles.s=s;
handles.F=F;
guidata(hObject, handles);
helpdlg('Text File is Selected');


% --- Executes on button press in embedding.
function embedding_Callback(hObject, eventdata, handles)
% hObject    handle to embedding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


a=handles.a;
s=handles.s;
F=handles.F;

Q_SIZE = 3;
c=round(a*(10^Q_SIZE));
i=1;
ii=51;
while i <=length(s)
	if c(ii,1)<0
        sbit1 = -1;
    else
        sbit1 =  1;
	end
    iii = ii+2;
	if c(iii,1)<0
        sbit2 = -1;
    else
        sbit2 =  1;
	end
	c(ii,1) = abs(c(ii,1));
	c(iii,1) = abs(c(iii,1));
	[c(ii,1),c(iii,1)]=Enc_Char(c(ii,1),c(iii,1),F(i));
	c(ii,1) = sbit1*c(ii,1);
    c(iii,1) = sbit2*c(iii,1);
    i=i+1;
    ii = iii+2;
end
            n  = length(F);  % Input Text Length
			d=c/(10^Q_SIZE);
            axes(handles.axes2);
            plot(d);
			wavwrite(d,44100,16,'Embedded.WAV');
			helpdlg('Embedded process completed');
 
pass=passkey;
s2 = char(pass);
ss = length(s2);
if  ss==4
    helpdlg('Secret Key Sucessesfully added');
else
    errordlg('Enter the Valid Secret Key');
end
num = dec2bin(s2,8);
disp(num);
handles.pass = num;
handles.d=d;
handles.n = n;
guidata(hObject, handles);


% --- Executes on button press in extraction.
function extraction_Callback(hObject, eventdata, handles)
% hObject    handle to extraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=handles.n;
pass=handles.pass;
pass1=passkey;
s2 = char(pass1);
ss = length(s2);
if  ss==4
    helpdlg('Secret Key Sucessesfully added');
else
    errordlg('Enter the Valid Secret Key');
end
pass1 = dec2bin(s2,8);
temp=0;
for i=1:4
    for j=1:8
        if pass(i,j)==pass1(i,j)
            temp=temp+1;
        else
            temp = 0;
        end
    end
end

if temp == 32
	%s='A';
	%s1=serial('COM5','BaudRate',9600);
	%fopen(s1);
	%fprintf(s1,s);
	%fclose(s1);
else
    errordlg('Password missmached');
	%s='B';
	%s1=serial('COM5','BaudRate',9600);
	%fopen(s1);
	%fprintf(s1,s);
	%fclose(s1);
	exit;
end
                    
a=wavread('Embedded.wav');
Q_SIZE = 3;
c=round(a*(10^Q_SIZE));

i = 1;
TXT_LENGTH = n;
ii=51;
while i <= TXT_LENGTH
c(ii,1) = abs(c(ii,1));
iii = ii+2;
c(iii,1) = abs(c(iii,1));
s(i)=Dec_Char(c(ii,1),c(iii,1));
i = i+1;
ii = iii+2;
end

fid = fopen('output.txt','wb');
fwrite(fid,char(s'),'char');
fclose(fid);
helpdlg('Extraction process completed');



% --- Executes on button press in viewoutput.
function viewoutput_Callback(hObject, eventdata, handles)
% hObject    handle to viewoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


open 'output.txt';


% --- Executes on button press in playaudio1.
function playaudio1_Callback(hObject, eventdata, handles)
% hObject    handle to playaudio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

d = handles.d;
wavplay(d,44100);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in validation.
function validation_Callback(hObject, eventdata, handles)
% hObject    handle to validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inpaud = handles.a;
embaud = handles.d;

[Y,Z]=psnr(inpaud,embaud);
set(handles.edit1,'string',Y);
set(handles.edit2,'string',Z);


