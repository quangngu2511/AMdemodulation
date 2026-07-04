r = audiorecorder(48000,16,1);
record(r);
pause(0.1)
L=r.TotalSamples;
Fc=12000;
t=0:2*pi/(48000/Fc):1000000*pi;
xs=sin(t)';
[BL AL]=butter(5,1/8);
[BP AP]=butter(5,[(Fc-4000)/24000 (Fc+4000)/24000]);
Start_P=1;
while L<1000000
    y =getaudiodata(r,'double');
    Ly=length(y);
    if Ly-Start_P>100000 
       yr=y(Start_P:Ly);
       yr=filter(BL,AL,yr);
       yr=yr.*xs(1:length(yr));
       yr=filter(BP,AP,yr);
       sound(yr,48000);
       Start_P=Ly;
    end
    L=r.TotalSamples;
end
stop(r)
