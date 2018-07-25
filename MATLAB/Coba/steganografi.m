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

% Last Modified by GUIDE v2.5 17-Jul-2018 20:20:25

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
global image;

[nama_file,format_file] = uigetfile({'*.bmp'}, 'Pilih Gambar');
image = imread([format_file,nama_file]);
handles.image = image;
guidata(hObject,handles);
axes(handles.axes2);
imshow(image);

lokasi_image = fullfile(format_file, nama_file);
set(handles.kolom_lokasi,'String',lokasi_image);


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
global image;
global hiddentext_simpan;

[row, column, channel] = size(image);
image_red   = image(:,:,1);
image_green = image(:,:,2);
image_blue  = image(:,:,3);

%penentuan maksimal karakter pesan 
char_max = (row -1)*(column);
char_max = round((char_max*3)/8); %perchannel warna

hiddentext = get(handles.edit_pesan,'String')
if isempty(hiddentext) %cek kondisi kolom pesan
    msgbox('Pesan belum dimasukkan','Peringatan','warn');
    return;    
end

%perhitungan panjang pesan di textfield
row_max = row;
column_max = column;
hiddentext_length = length(hiddentext) %masih dalam hitungan desimal
if hiddentext_length < char_max 
    hiddentext_biner = strcat(reshape(dec2bin(double(hiddentext),8).',1,[]), '00000000')
    hiddentext_simpan = hiddentext_biner;
    hiddentext_asli = char(bin2dec(reshape(hiddentext_biner,8,[]).')).'
    
else
    msgbox('Maaf,pesan terlalu panjang','peringatan','warn');
    return;
end

%enkripsi
hiddentext_length = hiddentext_length*8;
for i = 1:row_max-1
    for j = 1:column_max    
        if hiddentext_length ~= 0
            image_biner_red = dec2bin(image_red(i,j),8); %11100100 contoh biner
            image_biner_red(1,8) = hiddentext_biner(1,1); %bit terakhir diganti
            image_red(i,j) = bin2dec(image_biner_red); 
              
            hiddentext_biner(1:1) = [];  %menghapus 1 bit pertama pesan
            hiddentext_length = length(hiddentext_biner); %menghitung panjang bit pesan            
        end
        
        if hiddentext_length ~= 0
            image_biner_green = dec2bin(image_green(i,j),8);
            image_biner_green(1,8) = hiddentext_biner(1,1);
            image_green(i,j) = bin2dec(image_biner_green);
              
            hiddentext_biner(1:1) = []; 
            hiddentext_length = length(hiddentext_biner); 
        end
        
        if hiddentext_length ~= 0
            image_biner_blue = dec2bin(image_blue(i,j),8);
            image_biner_blue(1,8) = hiddentext_biner(1,1); 
            image_blue(i,j) = bin2dec(image_biner_blue); 
              
            hiddentext_biner(1:1) = []; 
            hiddentext_length = length(hiddentext_biner); 
        end
    end
end

stego_image(:,:,1) = uint8(image_red);
stego_image(:,:,2) = uint8(image_green);
stego_image(:,:,3) = uint8(image_blue);

[nama_file, direktori] = uiputfile('*.bmp','Simpan Stego Image');
if direktori == 0
    return;
end
nama = fullfile(direktori, nama_file);
imwrite(stego_image, nama, 'bmp');
msgbox('Stego Image telah berhasil dibuat','pemberitahuan');


% --- Executes on button press in pushbutton_decoding.
function pushbutton_decoding_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global hiddentext_simpan;

[row, column, channel] = size(image);
image_red   = image(:,:,1);
image_green = image(:,:,2);
image_blue  = image(:,:,3);
row_max = row;
column_max = column;

hiddentext_length = length(hiddentext_simpan);

%ekstraksi
hiddentext = '';
var_null = 1;
for i = 1:row_max-1
    for j = 1:column_max
        biner_length = length(hiddentext);
        if biner_length < hiddentext_length && var_null<=8
            image_biner_red = dec2bin(image_red(i,j),8); %11100101 binernya 
            hiddentext_red = image_biner_red(1,8); %diambil '1' dari bit yang terakhir
            hiddentext = strcat(hiddentext, hiddentext_red); %digabungin sama si hiddentext yg awalnya kosong
            if hiddentext_red == 0
                var_null = var_null + 1;
            else
                var_null = 1;
            end   
        else
            hiddentext_asli = char(bin2dec(reshape(hiddentext,8,[]).')).';
            set(handles.edit_pesan,'String',hiddentext_asli);
            return;
        end

        biner_length = length(hiddentext);
        if biner_length < hiddentext_length && var_null<=8
            image_biner_green = dec2bin(image_green(i,j),8);
            hiddentext_green = image_biner_green(1,8);
            hiddentext = strcat(hiddentext, hiddentext_green);
            if hiddentext_green == 0
                var_null = var_null+1;
            else
                var_null = 1;
            end   
        else
            hiddentext_asli = char(bin2dec(reshape(hiddentext,8,[]).')).';
            set(handles.edit_pesan,'String',hiddentext_asli);
            return;
        end

        biner_length = length(hiddentext);
        if biner_length < hiddentext_length && var_null<=8
            image_biner_blue = dec2bin(image_blue(i,j),8);
            hiddentext_blue = image_biner_blue(1,8);
            hiddentext = strcat(hiddentext, hiddentext_blue);
            if hiddentext_blue == 0
                var_null = var_null+1;
                %fprintf('%c',var_null)
            else
                var_null = 1;
            end   
        else
            hiddentext_asli = char(bin2dec(reshape(hiddentext,8,[]).')).';
            set(handles.edit_pesan,'String',hiddentext_asli);
            return;
        end
       
    end
end

% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.axes2);
delete(handles.kolom_lokasi);
delete(handles.edit_pesan);


% --- Executes on button press in pushbutton_exit.
function pushbutton_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;