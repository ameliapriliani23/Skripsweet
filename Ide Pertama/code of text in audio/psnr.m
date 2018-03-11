function [MSE,PSNR]=psnr(Y,Z)
input=Y;
Embedded=Z;
[r c p]=size(Embedded);
input=double(input);
Embedded=double(Embedded);
MSE = sum(sum((input-Embedded).^2))/(r*c);
disp(MSE);
PSNR = 10*log10(1*1/MSE);  % if the input is double-precision floating-point data type, then R is 1.
disp(PSNR);
return