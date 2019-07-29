function [ d ] = calucate_distance( a,b,c )


    d=sqrt((c(a).x-c(b).x)^2+(c(a).y-c(b).y)^2);
end

