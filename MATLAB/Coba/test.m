tapi gimana tau ada berapa karakter pesan di foto itu
pixel_red    = dec2bin(image_red(row_max,1),8);
pixel_green  = dec2bin(image_green(row_max,1),8);
pixel_blue   = dec2bin(image_blue(row_max,1),8);
pixel_red2   = dec2bin(image_red(row_max,2),8);
pixel_green2 = dec2bin(image_green(row_max,2),8);
pixel_blue2  = dec2bin(image_blue(row_max,2),8);

hiddentext_red    = pixel_red(7:8);
hiddentext_green  = pixel_green(7:8);
hiddentext_blue   = pixel_blue(7:8);
hiddentext_red2   = pixel_red2(7:8);
hiddentext_green2 = pixel_green2(7:8);
hiddentext_blue2 = pixel_blue2(7:8);

hiddentext_length = strcat(hiddentext_red, hiddentext_green, hiddentext_blue, hiddentext_red2, hiddentext_green2, hiddentext_blue2);
hiddentext_length = bin2dec(reshape(hiddentext_length,12,[]).')