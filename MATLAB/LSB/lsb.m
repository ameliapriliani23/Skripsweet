function varargout = lsb(varargin)
% LSB MATLAB code for lsb.fig
%      LSB, by itself, creates a new LSB or raises the existing
%      singleton*.
%
%      H = LSB returns the handle to a new LSB or the handle to
%      the existing singleton*.
%
%      LSB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LSB.M with the given input arguments.
%
%      LSB('Property','Value',...) creates a new LSB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lsb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lsb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lsb

% Last Modified by GUIDE v2.5 20-Jan-2018 21:48:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lsb_OpeningFcn, ...
                   'gui_OutputFcn',  @lsb_OutputFcn, ...
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


% --- Executes just before lsb is made visible.
function lsb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lsb (see VARARGIN)

% Choose default command line output for lsb
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lsb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lsb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;

[namafile,formatfile] = uigetfile({'*.png; *.bmp'}, 'memilih gambar');
image = imread([formatfile,namafile]);
handles.image = image;
guidata(hObject,handles);
axes(handles.axes1);
imshow(image);

imagenya = fullfile(formatfile, namafile);
set(handles.edit1,'String',imagenya);

[baris, kolom, channel] = size(image);
set(handles.baris_1,'String',baris);
set(handles.kolom_1,'String',kolom);

%penentuan maksimal karakter pesan dengan maksimal 1 penyisipan / piksel
karakter_max = (baris -1)*(kolom);
karakter_max = round((karakter_max*3)/8); %perchannel warna

set(handles.edit8,'String', karakter_max);



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



function baris_1_Callback(hObject, eventdata, handles)
% hObject    handle to baris_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of baris_1 as text
%        str2double(get(hObject,'String')) returns contents of baris_1 as a double


% --- Executes during object creation, after setting all properties.
function baris_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to baris_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kolom_1_Callback(hObject, eventdata, handles)
% hObject    handle to kolom_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kolom_1 as text
%        str2double(get(hObject,'String')) returns contents of kolom_1 as a double


% --- Executes during object creation, after setting all properties.
function kolom_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kolom_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;

[baris, kolom, channel] = size(image);
image_r = image(:,:,1);
image_g = image(:,:,2);
image_b = image(:,:,3);
baris_max = baris;
kolom_max = kolom;

%mengambil kunci panjang pesan (dalam desimal)
piksel_r = dec2bin(image_r(baris_max,1),8);
piksel_g = dec2bin(image_g(baris_max,1),8);
piksel_b = dec2bin(image_b(baris_max,1),8);
piksel_r2 = dec2bin(image_r(baris_max,2),8);
piksel_g2 = dec2bin(image_g(baris_max,2),8);
piksel_b2 = dec2bin(image_b(baris_max,2),8);

pesan_r = piksel_r(7:8);
pesan_g = piksel_g(7:8);
pesan_b = piksel_b(7:8);
pesan_r2 = piksel_r2(7:8);
pesan_g2 = piksel_g2(7:8);
pesan_b2 = piksel_b2(7:8);

panjang_pesan = strcat(pesan_r, pesan_g, pesan_b, pesan_r2, pesan_g2, pesan_b2);
panjang_pesan = bin2dec(reshape(panjang_pesan,12,[]).')

%mengambil kunci panjang password
panjang_pass = dec2bin(image_b(baris_max,3),8);
panjang_pass = panjang_pass(6:8);
panjang_pass = bin2dec(panjang_pass)

%mengambil passwordnya
pass = '';
for i = 4:panjang_pass +3
    piksel_r = dec2bin(image_r(baris_max,i),8);
    piksel_g = dec2bin(image_g(baris_max,i),8);
    piksel_b = dec2bin(image_b(baris_max,i),8);
            
    passdi_r = piksel_r(6:8);            
    passdi_g = piksel_g(6:8);
    passdi_b = piksel_b(7:8);
    
    pass = strcat(pass, passdi_r, passdi_g, passdi_b);
end
pass = char(bin2dec(reshape(pass,8,[]).')).'

password = get(handles.edit7,'String');
sama = strcmp(pass, password);

%ekstraksi pesan
if sama == 1
    pesan = '';
    for i = 1:baris_max-1
        for j = 1:kolom_max
            %untuk piksel merah
            panjang_biner = length(pesan);
            if panjang_biner < panjang_pesan*8
                gambar_biner_r = dec2bin(image_r(i,j),8);
                pesan_r = gambar_biner_r(1,8);
                pesan = strcat(pesan,pesan_r);    
            else
                pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
                set(handles.edit6,'String',pesan_asli);
                return;
            end
            
            panjang_biner = length(pesan);
            if panjang_biner < panjang_pesan*8
                gambar_biner_g = dec2bin(image_g(i,j),8);
                pesan_g = gambar_biner_g(1,8);
                pesan = strcat(pesan,pesan_g);    
            else
                pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
                set(handles.edit6,'String',pesan_asli);
                return;
            end
            
            panjang_biner = length(pesan);
            if panjang_biner < panjang_pesan*8
                gambar_biner_b = dec2bin(image_b(i,j),8);
                pesan_b = gambar_biner_b(1,8);
                pesan = strcat(pesan,pesan_b);    
            else
                pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
                set(handles.edit6,'String',pesan_asli);
                return;
            end
        end
    end
else
    msgbox('Maaf, Password yang anda inputkan salah total','www.ketutrare.com','warn');
    return;
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;

[baris, kolom, channel] = size(image);
image_r = image(:,:,1);
image_g = image(:,:,2);
image_b = image(:,:,3);
karakter_max = str2double(get(handles.edit8,'String')); %karakter maksimal

pesan = get(handles.edit4,'String')
if isempty(pesan) %cek kondisi textfield pesan
    msgbox('Silahkan ketikkan pesan terlebih dahulu','peringatan','warn');
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

%membuat kunci dari panjang pesan (dalam desimal)
%program by ketutrare.com

pesan_kunci = dec2bin(panjang_pesan,12);
image_pesan_r = dec2bin(image_r(baris_max,1),8);
image_pesan_g = dec2bin(image_g(baris_max,1),8);
image_pesan_b = dec2bin(image_b(baris_max,1),8);
image_pesan_r2 = dec2bin(image_r(baris_max,2),8);
image_pesan_g2 = dec2bin(image_g(baris_max,2),8);
image_pesan_b2 = dec2bin(image_b(baris_max,2),8);

image_pesan_r(7:8) = pesan_kunci(1:2);
image_pesan_g(7:8) = pesan_kunci(3:4);
image_pesan_b(7:8) = pesan_kunci(5:6);
image_pesan_r2(7:8) = pesan_kunci(7:8);
image_pesan_g2(7:8) = pesan_kunci(9:10);
image_pesan_b2(7:8) = pesan_kunci(11:12);

image_r(baris_max,1) = bin2dec(image_pesan_r);
image_g(baris_max,1) = bin2dec(image_pesan_g);
image_b(baris_max,1) = bin2dec(image_pesan_b);
image_r(baris_max,2) = bin2dec(image_pesan_r2);
image_g(baris_max,2) = bin2dec(image_pesan_g2);
image_b(baris_max,2) = bin2dec(image_pesan_b2);

password = get(handles.edit5,'String');
if isempty(password)
    msgbox('Silahkan ketikkan password terlebih dahulu','peringatan','warn');
    return;
end

panjang_password = length(password);
if panjang_password > 6
    msgbox('Panjang pesan melebihi batas','peringatan','warn');
    return;
end

%membuat kunci panjang password
kunci_pjgpass = dec2bin(panjang_password,3); % ubah cuma jadi 3 bit
piksel_kuncipass = dec2bin(image_b(baris_max,3)); 
piksel_kuncipass(6:8) = kunci_pjgpass;
image_b(baris_max,3) = bin2dec(piksel_kuncipass);

%menyisipkan password sebagai kunci (pencocokan di ekstraksi)
password_biner = reshape(dec2bin(double(password),8).',1,[]);
for i = 4:panjang_password +3
    piksel_pass_r = dec2bin(image_r(baris_max,i));
    piksel_pass_g = dec2bin(image_g(baris_max,i));
    piksel_pass_b = dec2bin(image_b(baris_max,i));

    piksel_pass_r(6:8) = password_biner(1:3);          
    piksel_pass_g(6:8) = password_biner(4:6);
    piksel_pass_b(7:8) = password_biner(7:8);

    password_biner(1:8) = [];

    image_r(baris_max,i) = bin2dec(piksel_pass_r);
    image_g(baris_max,i) = bin2dec(piksel_pass_g);
    image_b(baris_max,i) = bin2dec(piksel_pass_b);            
end

%LSB
panjang_pesan = panjang_pesan*8;
for i = 1:baris_max-1
    for j = 1:kolom_max
        %piksel biru       
        if panjang_pesan ~= 0
            gambar_biner_r = dec2bin(image_r(i,j),8);
            gambar_biner_r(1,8) = pesan_biner(1,1); %ketutrare.com
            image_r(i,j) = bin2dec(gambar_biner_r); %ketutrare.com
              
            pesan_biner(1:1) = []; %ketutrare.com
            panjang_pesan = length(pesan_biner); %ketutrare.com
        end
        
        if panjang_pesan ~= 0
            gambar_biner_g = dec2bin(image_g(i,j),8);
            gambar_biner_g(1,8) = pesan_biner(1,1); %ketutrare.com
            image_g(i,j) = bin2dec(gambar_biner_g); %ketutrare.com
              
            pesan_biner(1:1) = []; 
            panjang_pesan = length(pesan_biner); 
        end
        
        if panjang_pesan ~= 0
            gambar_biner_b = dec2bin(image_b(i,j),8);
            gambar_biner_b(1,8) = pesan_biner(1,1); 
            image_b(i,j) = bin2dec(gambar_biner_b); 
              
            pesan_biner(1:1) = []; 
            panjang_pesan = length(pesan_biner); 
        end
    end
end

gambar_stego(:,:,1) = uint8(image_r);
gambar_stego(:,:,2) = uint8(image_g);
gambar_stego(:,:,3) = uint8(image_b);

[namafile, direktori] = uiputfile('*.bmp','menyimpan stego image');
if direktori == 0
    return;
end
nama = fullfile(direktori, namafile);
imwrite(gambar_stego, nama, 'bmp');
msgbox('Stego Image telah berhasil dibuat','pemberitahuan');



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
