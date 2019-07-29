function sbox(file)

box = importdata(file)
[n m] = size(box);
z=n*m;
q=z-1;
digit_input = length(dec2bin(q));
new_box=zeros(1,n*m);
count=1;
for i=1:n
    for j=1:m
        new_box(:,count)=box(i,j); % prinsip modifikasi arah pembacaan
        count=count+1;             % liat nilai dalam S-box (int/hex/char)
    end
end
new_box;
digit_input;
bent_asli_func(new_box,digit_input,z)


