function [ output ] = delta_soil( i,j,vel,a_s,b_s,c_s,N_IWD )


    output=a_s/(b_s+c_s*time(i,j,vel,N_IWD));
end

