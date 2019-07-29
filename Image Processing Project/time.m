function [ out ] = time( i,j,velocity,epsilon_v,c )
    out=calucate_distance(i,j,c)/max(epsilon_v,velocity);

end

