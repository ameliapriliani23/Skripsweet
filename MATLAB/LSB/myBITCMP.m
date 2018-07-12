%* Gunakan fungsi ini untuk melakukan perhitungan komparasi bit menggunakan teknik sendiri
function output = myBITCMP(x,N)
if nargin < 2
    output = bitcmp(x);
else
    maksN = 2^N-1;    % This is the max number you can represent in 4 bits
    fmt  = 'uint8';   % You can change uint8 to uint16 or 32
    output1 = eval(['bitcmp(',fmt,'(x)',',''',fmt,''')']);
    output2 = eval(['bitcmp(',fmt,'(maksN)',',''',fmt,''')']);
    output = output1 - output2;
end
