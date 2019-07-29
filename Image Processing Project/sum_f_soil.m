function [ out ] = sum_f_soil( i,k,soil,v_c,city_set,epsilon_s )
    tmp_set1=setxor(cell2mat(v_c(k,1)),city_set);
    tmp_value=0;
    for z=1 : length(tmp_set1)
        tmp_value=tmp_value+f_soil(i,tmp_set1(1,z),k,soil,v_c,city_set,epsilon_s);
    end
    out = tmp_value;
end

