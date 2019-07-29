% Program for Advance Encryption Standard enhancing security  using
% WaterDrop

function mainRUN
tic
% [i11,i12]=uigetfile('*.*');%XXXXXX Input Image XXXXXXXXXXX
% i12=strcat(i12,i11);
% i12=imread('');
im2=imread('Penguins.jpg');
N_IWD=5;
N_C=100;
a_v=1000;
b_v=0.1;
c_v=1;
a_s=1000;
b_s=0.01;
c_s=1;
InitSoil=1000;
InitVel=400;
epsilon_s=0.01;
epsilon_v=0.0001;
tt=epsilon_v;
rho=0.9;
T_B=10000;
radius=20;
im=imresize(im2,[InitVel InitVel]);
im1=im(:,:,1);
zkey=input('Select the key for Image Encryption for Advance_ES ') ;
z1key=zkey;
figure(1);
subplot(1,2,1);imshow(im);
title('Input Image');

subplot(1,2,2);
imhist(uint8(im1));
title('Histogram of input image');
im2=double(im1);
[M,N]=size(im2);
e=hundungen(M,N,0.1);

im3=mod(tt*im2+(1-tt)*e,128);
a1(:,:,1)=round(im3(:,:,1));a1(:,:,2)=im(:,:,2);a1(:,:,3)=im(:,:,3);
figure(2);

for i=1:InitVel
    for j=1:InitVel
        a1(i,j,1)=bitxor (a1(i,j,3),a1(i,j,1));
        a1(i,j,2)=bitxor (a1(i,j,1),a1(i,j,2));
        a1(i,j,3)=bitxor (a1(i,j,2),a1(i,j,3));
       
    end
end
for i=1:InitVel
    for j=1:InitVel
        a1(i,j,1)=bitxor (a1(i,j,3),a1(i,j,2));
        a1(i,j,2)=bitxor (a1(i,j,1),a1(i,j,3));
        a1(i,j,3)=bitxor (a1(i,j,2),a1(i,j,1));
       
    end
end



for i=1 : N_C
    city_set(1,i)=i;
end

for i=1 : N_C
    for j=1 : N_C
        soil(i,j)=InitSoil;
    end
end


for i=1 : N_C
    tmp_rand=2*pi*rand;
    c(i).x=radius*cos(tmp_rand);
    c(i).y=radius*sin(tmp_rand);
    z1(i)=c(i).x;
    z2(i)=c(i).y;
%     display(c(1,i).x^2+c(1,i).y^2);
end


%%
vel_IWD=cell(N_IWD,1);
for k=1 : N_IWD
    vel_IWD{k,1}(1,1)=InitVel;
end
v_c=cell(N_IWD,1);
for i=1 : N_IWD
    v_c{i,1}=floor(random('unif',1,N_C));
%     v_c{i,1}=mod(i,N_C);
end
probability_IWD=cell(N_IWD,1);
delta_soil=zeros(N_IWD,1);

for nc=1 : N_C
    for k=1 : N_IWD
        tmp_sum=sum_f_soil(v_c{k,1}(1,length(v_c{k,1})),k,soil,v_c,city_set,epsilon_s);
        for m=1 : N_C
            if (~ismember(m,cell2mat(v_c(k,1))))
                probability_IWD{k,1}(v_c{k,1}(1,length(v_c{k,1})),m)=f_soil(v_c{k,1}(1,length(v_c{k,1})),m,k,soil,v_c,city_set,epsilon_s )/tmp_sum;
            end
        end

    end

    for k=1 : N_IWD
        display(k);
        [u v]=max(probability_IWD{k,1}(v_c{k,1}(1,length(v_c{k,1})),:));
        vel_IWD{k,1}(1,length(vel_IWD{k,1})+1)=vel_IWD{k,1}(1,length(vel_IWD{k,1}))+a_v/(b_v+c_v*soil(v_c{k,1}(1,length(v_c{k,1})),v));
        delta_soil(v_c{k,1}(1,length(v_c{k,1})),v)=a_s/(b_s+c_s*time(v_c{k,1}(1,length(v_c{k,1})),v,vel_IWD{k,1}(1,length(vel_IWD{k,1})),epsilon_v,c));
        soil(v_c{k,1}(1,length(v_c{k,1})),v)=(1-rho)*soil(i,j)-rho*delta_soil(v_c{k,1}(1,length(v_c{k,1})),v);
        soil_IWD(k,1)=soil(k,1)+delta_soil(v_c{k,1}(1,length(v_c{k,1})),v);
        v_c{k,1}(1,length(v_c{k,1})+1)=v;
    end
    if (length(v_c{1,1})==N_C)
        break;
    end
end
%%
for k=1 : N_IWD
    Tour_IWD(k,1)=vector_distance(cell2mat(v_c(k,1)),z1,z2);
end

[u2 v2]=min(Tour_IWD);
soil(length(v_c{v2,1})-1,length(v_c{v2,1}))=(1-rho)*soil(length(v_c{v2,1})-1,length(v_c{v2,1}))+rho*2*soil_IWD(v2,1)/(N_C*(N_C-1));

if (T_B > u2)
    T_B=u2;
end
%global EncImg; 
%global key;
%global a1;
  
%[n m k] = size(im3);
%key = keygen(n*m);

EncImg = imageProcess(im1,e);
subplot(2,2,1);
imshow(EncImg);
%subplot(2,2,1);imshow(uint8(EncImg),[]);
title('Encrypted Image Result');
subplot(2,2,2);
plot(z1,z2,'r<');
hold on;
plot(z1(cell2mat(v_c(v2,1))),z2(cell2mat(v_c(v2,1))));
title('Encrypted form in Moving Pixel in IWD');
subplot(2,2,3);
imhist(uint8(im3));
title('Histogram of Selectively Encrypted image');
toc


figure(3);

t = 0:b_s:N_C;
x = radius*t;
y = -9.8*t.^2/2;
comet(x,y,0.1)
title('Trust Factor');


% -----------------------------------------------------------------

if (z1key==input('Enter the key for Decryption '))
  tic
e=keygen(M,N,b_v);
im5=(im3-(1-tt)*e)/tt;
a1(:,:,1)=round(im5(:,:,1));a1(:,:,2)=im(:,:,2);a1(:,:,3)=im(:,:,3);
figure(4)
subplot(2,2,1);imshow(uint8(a1),[]);
title('Final Image');
subplot(2,2,2);
imhist(uint8(im5));
title('Histogram of final Image');
% subplot(231)
% imhist(uint8(im1));
% title('Histogram of input image');
% subplot(232)
% imhist(uint8(im3));
% title('Histogram of Selectively Encrypted image');
%subplot(233)
%imhist(uint8(im5));
%title('Histogram of final Image');
%celldisp(v_c(v2,1));
% subplot(234)
% title('Trust Factor');
% t = 0:b_s:N_C;
% x = radius*t;
% y = -9.8*t.^2/2;
% comet(x,y,0.1)
toc
else
input('**************  Sorry,Wrong Key *******************! ');
end
