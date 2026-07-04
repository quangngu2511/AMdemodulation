flm=96000;
r = audiorecorder(flm,16,1);
record(r);
pause(0.1)
L=r.TotalSamples;
Fc=12000;
t=0:2*pi/(flm/Fc):1000000*pi;
xs=sin(t)';
[BL AL]=butter(5,3000/(flm/2));
[BP AP]=butter(5,[(Fc-3000)  (Fc+3000)]/(flm/2) );
Start_P=1;
while L<1000000
    y =getaudiodata(r,'double');
    Ly=length(y);
    if Ly-Start_P>100000 
       yr=y(Start_P:Ly);
       yr=filter(BP,AP,yr);
       yr=yr.*xs(1:length(yr));
       yr=filter(BL,AL,yr);
       sound(yr,flm);
       Start_P=Ly;
    end
    L=r.TotalSamples;
end
stop(r)
