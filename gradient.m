function [dfield_dx,dfield_dy]=gradient(field,long,lat)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  function [dfield_dx,dfield_dy]=gradient(field,long,lat)
%  
%  Calculate the gradient of the scalar field given as input.
%  Longitude and latitude are in degrees.
%
%                  d(field_x)        d(field_y)
%  grad_field =  { ____________ ;   ____________ }
%                      dx                dy
%  
%  The output fields have the same dimensions as the input ones.
%  NB: the long field varies along the rows and the lat one along the columns.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Mx=size(field,1);
My=size(field,2);

% Convert to radians
long=long*pi/180;
lat=lat*pi/180;

R=6.371e6;   % Earth radius [m]

for i=1:Mx
  for j=1:My
    if i==1
      part_x(i,j)=field(i+1,j)-field(i,j);
      delta_x(i,j)=(long(i+1,j)-long(i,j))*R*cos(lat(i,j));
    elseif i==Mx
      part_x(i,j)=field(i,j)-field(i-1,j);
      delta_x(i,j)=(long(i,j)-long(i-1,j))*R*cos(lat(i,j));
    else
      part_x(i,j)=field(i+1,j)-field(i-1,j);
      delta_x(i,j)=(long(i+1,j)-long(i-1,j))*R*cos(lat(i,j));
    end
  end
end

dfield_dx=part_x./delta_x;

for i=1:Mx
  for j=1:My
    if j==1
      part_y(i,j)=field(i,j+1)-field(i,j);
      delta_y(i,j)=(lat(i,j+1)-lat(i,j))*R;
    elseif j==My
      part_y(i,j)=field(i,j)-field(i,j-1);
      delta_y(i,j)=(lat(i,j)-lat(i,j-1))*R;
    else
      part_y(i,j)=field(i,j+1)-field(i,j-1);
      delta_y(i,j)=(lat(i,j+1)-lat(i,j-1))*R;
    end
  end
end

dfield_dy=part_y./delta_y;


