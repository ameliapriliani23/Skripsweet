% clc;
% clear all;
% close all;

form=figure;
form.Position=[50 50 800 768];

%* Tentukan gambar utama dan gambar teks yang akan digunakan dalam perhitungan
%Perlu diingat bahwa gambar utama dan gambar teks harus memiliki ukuran yang sama
namaFileGambarUtama = 'lena.jpg';
namaFileGambarTeks = 'lorem ipsum.bmp';
imgGambarUtama = imread(namaFileGambarUtama);
imgGambarTeks = imread(namaFileGambarTeks);

%1. Tentukan nilai bit LSB yang digunakan
%Nilai yang direkomendasikan adalah berada diantara 1 sampai dengan 4
%Jika nilai lebih dari 4, maka gambar utama akan mulai tertutup oleh gambar teks
%Diasumsikan dalam kasus ini, nilai yang digunakan adalah 3
bitLSB = 3;

%2. Lakukan implementasi LSB dengan memasukkan gambar teks ke dalam gambar utama
outputLSB = uint8(bitor( ...
                    bitand( imgGambarUtama, myBITCMP(2^bitLSB-1,8) ), ...
                    bitshift(imgGambarTeks,bitLSB-8) ) ...
                 );
             
%3. Lakukan ekstraksi gambar teks berdasarkan hasil output sebelumnya
outputEkstraksi = uint8(bitand(255,bitshift(outputLSB,8-bitLSB)));

%4. Hitung PSNR dan MSE antara gambar hasil ekstraksi dengan gambar awal
%Proses ini bukan bagian dari LSB, sehingga hanya bersifat optional saja
imgGambarAwal = double(imgGambarTeks);
imgGambarAkhir = double(outputEkstraksi);
[panjang, lebar, dim] = size(imgGambarAwal);
imgGambarEkstraksi=imresize(imgGambarAkhir,[panjang lebar]);
error = imgGambarAwal - imgGambarEkstraksi;
MSE = sum(sum(error .* error)) / (panjang * lebar);
if(MSE > 0)
    PSNR = 10*log10(panjang*lebar./MSE);
else
    PSNR = 99;
end

%Tampilkan gambar utama pada layar
subplot(2,2,1)
imshow(imgGambarUtama);
title('Gambar Utama')

%Tampilkan gambar pesan pada layar
subplot(2,2,2)
imshow(imgGambarTeks);
title('Gambar Pesan')

%Tampilkan hasil implementasi LSB pada layar
subplot(2,2,3)
imshow((abs(outputLSB)),[]);
hTitle = title('Hasil LSB');

%Tampilkan hasil ekstraksi gambar teks pada layar
subplot(2,2,4)
imshow(real(outputEkstraksi),[]); 
hTitle2 = title({'Hasil Ekstraksi'});

%Tampilkan hasil perhitungan PSNR dan MSE pada layar
subplot(2,2,3)
posisiTitle = round(get(hTitle,'Position'));
hTitleBawah = text(posisiTitle(1) - (lebar/2), posisiTitle(2) + panjang+30, ...
    ['PSNR = ' num2str(abs(PSNR))],'HorizontalAlignment', 'left');

subplot(2,2,4)
posisiTitle2 = round(get(hTitle2,'Position'));
hTitleBawah2 = text(posisiTitle2(1) - (lebar/2), posisiTitle2(2) + panjang+30, ...
    ['MSE = ' num2str(abs(MSE))],'HorizontalAlignment', 'left');

