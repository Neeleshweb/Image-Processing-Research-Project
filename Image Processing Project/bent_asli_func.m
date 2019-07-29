function bent(sbox,input,z,file2)
% program uji bent function
% apakah suatu s-box memenuhi bent function
% =========================================
if mod(z,2)==0
    batas=(2^input)-1;
    akhir=batas+1;
else
     batas=(2^input)-1;
     akhir=batas;
 end
batas1=2^(input-1);
akhir1=batas1+1;
reg=0;
Walsh_Box=zeros(1,akhir1);
for i=1:akhir
    count=0;
    for j=1:akhir
       otbox= sbox(:,j);
       kali=dec2bin(bitand((i-1),(j-1)),input);
       reg1=0;
       for k=1:input
           reg1=bitxor(reg1,str2num(kali(k)));
       end
       hasil=otbox+reg1;
       count=count+(-1)^hasil;
   end
   Walsh_Box(1,i)=count;
end
Walsh_Box
[o p]=size(Walsh_Box);
NilaiBent1=2^(floor(input/2))
NilaiBent2=-(NilaiBent1)
%fid1 = fopen(file2,'w');
%fprintf(fid1,'%c','Nilai Walsh :',char(13),char(10));
%fprintf(fid1,'%c',char(13),char(10));
%s=1;s2=8;
%for z=1:8
 %   newes=num2str(Walsh_Box(:,s:s2),2)
  %  fprintf(fid1,'%s',newes,char(13),char(10));
  %  s=s+8;s2=s2+8;
  %end
%fprintf(fid1,'%c',char(13),char(10));
%fprintf(fid1,'%c',char(13),char(10));
%fprintf(fid1,'%c','Nilai Bent :',char(13),char(10));
%fprintf(fid1,'%c',char(13),char(10));
%fprintf(fid1,'%c',strcat(num2str(NilaiBent1),' dan ',num2str(NilaiBent2)));
    
%fclose(fid1)
tamp=ones(1,length(Walsh_Box)).*NilaiBent1;
tamp1=ones(1,length(Walsh_Box)).*NilaiBent2;
plot([o:p],Walsh_Box,'b*',[o:p],tamp,'r-',[o:p],tamp1,'r-')
legend('Wals S-Box','Nilai Bent1','Nilai Bent2')
xlabel('Index Walsh')
ylabel('Nilai Walsh')