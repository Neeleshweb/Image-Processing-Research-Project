function [ output ] = vector_distance( vel,z1,z2)

    output=0;
    for i=1 : length(vel)-1
          output=output+sqrt((z1(vel(1,i))-z1(vel(1,i+1)))^2+(z2(vel(1,i))-z2(vel(1,i+1)))^2);
    end

end

