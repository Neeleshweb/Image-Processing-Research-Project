function [ c ] = g_soil( i,j,k,soil,v_c,city_set)
%
    tmp_set1=setxor(cell2mat(v_c(k,1)),city_set);
    for m=1 : length(tmp_set1)
        tmp_set2(1,m)=soil(m, tmp_set1(1,m));
    end
    
       
    if (min(tmp_set2)>=0)
        c=soil(i,j);
    else
        c=soil(i,j)-min(tmp_set2);
    end

end

