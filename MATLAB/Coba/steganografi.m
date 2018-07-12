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

[baris, kolom, channel] = size(image);
image_red   = image(:,:,1);
image_green = image(:,:,2);
image_blue  = image(:,:,3);
%penentuan maksimal karakter pesan dengan maksimal 1 penyisipan / piksel
karakter_max = (baris -1)*(kolom);
karakter_max = round((karakter_max*3)/8); %perchannel warna

pesan = get(handles.edit_pesan,'String')
if isempty(pesan) %cek kondisi kolom pesan
    msgbox('Pesan belum dimasukkan','Peringatan','warn');
    return;
end

%perhitungan panjang pesan di textfield
baris_max = baris;
kolom_max = kolom;
panjang_pesan = length(pesan) %masih dalam hitungan desimal
if panjang_pesan < karakter_max 
    pesan_biner = reshape(dec2bin(double(pesan),8).',1,[])
    pesan_asli = char(bin2dec(reshape(pesan_biner,8,[]).')).'
else
    msgbox('Maaf,pesan terlalu panjang','peringatan','warn');
    return;
end

panjang_pesan = panjang_pesan*8;
for i = 1:baris_max-1
    for j = 1:kolom_max    
        if panjang_pesan ~= 0
            gambar_biner_red = dec2bin(image_red(i,j),8); %11100100 contoh biner
            gambar_biner_red(1,8) = pesan_biner(1,1); %bit terakhir diganti
            image_red(i,j) = bin2dec(gambar_biner_red); 
              
            pesan_biner(1:1) = [];  %menghapus1 bit pertama pesan
            panjang_pesan = length(pesan_biner);             
        end
        
        if panjang_pesan ~= 0
            gambar_biner_green = dec2bin(image_green(i,j),8);
            gambar_biner_green(1,8) = pesan_biner(1,1);
            image_green(i,j) = bin2dec(gambar_biner_green);
              
            pesan_biner(1:1) = []; 
            panjang_pesan = length(pesan_biner); 
        end
        
        if panjang_pesan ~= 0
            gambar_biner_blue = dec2bin(image_blue(i,j),8);
            gambar_biner_blue(1,8) = pesan_biner(1,1); 
            image_blue(i,j) = bin2dec(gambar_biner_blue); 
              
            pesan_biner(1:1) = []; 
            panjang_pesan = length(pesan_biner); 
        end
    end
end

gambar_stego(:,:,1) = uint8(image_red);
gambar_stego(:,:,2) = uint8(image_green);
gambar_stego(:,:,3) = uint8(image_blue);

[nama_file, direktori] = uiputfile('*.bmp','Simpan Stego Image');
if direktori == 0
    return;
end
nama = fullfile(direktori, nama_file);
imwrite(gambar_stego, nama, 'bmp');
msgbox('Stego Image telah berhasil dibuat','pemberitahuan');


% --- Executes on button press in pushbutton_decoding.
function pushbutton_decoding_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;

[baris, kolom, channel] = size(image);
image_red   = image(:,:,1);
image_green = image(:,:,2);
image_blue  = image(:,:,3);
baris_max = baris;
kolom_max = kolom;

piksel_red = dec2bin(image_red(baris_max,1),8);
piksel_green = dec2bin(image_green(baris_max,1),8);
piksel_blue = dec2bin(image_blue(baris_max,1),8);

pesan_red = piksel_red(7:8);
pesan_green = piksel_green(7:8);
pesan_blue = piksel_blue(7:8);

panjang_pesan = strcat(pesan_red, pesan_green, pesan_blue);
panjang_pesan = bin2dec(reshape(panjang_pesan,12,[]).')

%ekstraksi
pesan = '';
for i = 1:baris_max-1
    for j = 1:kolom_max
        panjang_biner = length(pesan);
        if panjang_biner < panjang_pesan*8
            gambar_biner_red = dec2bin(image_red(i,j),8);
            pesan_red = gambar_biner_red(1,8);
            pesan = strcat(pesan, pesan_red);
        else
            pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
            set(handles.edit_pesan,'String',pesan_asli);
            return;
        end
        
        panjang_biner = length(pesan);
        if panjang_biner < panjang_pesan*8
            gambar_biner_green = dec2bin(image_green(i,j),8);
            pesan_green = gambar_biner_green(1,8);
            pesan = strcat(pesan, pesan_green);
        else
            pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
            set(handles.edit_pesan,'String',pesan_asli);
            return;
        end
        
        panjang_biner = length(pesan);
        if panjang_biner < panjang_pesan*8
            gambar_biner_blue = dec2bin(image_blue(i,j),8);
            pesan_blue = gambar_biner_blue(1,8);
            pesan = strcat(pesan, pesan_blue);
        else
            pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
            set(handles.edit_pesan,'String',pesan_asli);
            return;
        end
    end
end