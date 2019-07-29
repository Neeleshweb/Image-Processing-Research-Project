function [ d ] = f_soil(i,j,k,soil,v_c,city_set,epsilon_s )

    d=1/(epsilon_s+g_soil(i,j,k,soil,v_c,city_set));

end

