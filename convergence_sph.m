function conv_field=convergence_sph(field_x,field_y,long,lat)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  function conv_field=convergence_sph(field_x,field_y,long,lat)
%  
%  Calculate the convergence in spherical coordinates of the field
%  given as input.
%  Longitude and latitude are in degrees.
%
%                      1      d(field_x)           1     d(field_y*cos(lat))
%  conv_field = - __________ ____________  -  __________ ___________________
%                 R*cos(lat)    d(long)       R*cos(lat)        d(lat)
%
%  The output field has the same dimensions as the input ones.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Mx=size(field_x,1);
My=size(field_y,2);

% Convert to radians
long=long*pi/180;
lat=lat*pi/180;

R=6.371e6;   % Earth radius [m]

for i=1:Mx
  for j=1:My
    if i==1
      part_x(i,j)=field_x(i+1,j)-field_x(i,j);
      delta_x(i,j)=(long(i+1,j)-long(i,j))*R*cos(lat(i,j));
    elseif i==Mx
      part_x(i,j)=field_x(i,j)-field_x(i-1,j);
      delta_x(i,j)=(long(i,j)-long(i-1,j))*R*cos(lat(i,j));
    else
      part_x(i,j)=field_x(i+1,j)-field_x(i-1,j);
      delta_x(i,j)=(long(i+1,j)-long(i-1,j))*R*cos(lat(i,j));
    end
  end
end

for i=1:Mx
  for j=1:My
    if j==1
      part_y(i,j)=field_y(i,j+1)*cos(lat(i,j+1))-field_y(i,j)*cos(lat(i,j));
      delta_y(i,j)=(lat(i,j+1)-lat(i,j))*R*cos(lat(i,j));
    elseif j==My
      part_y(i,j)=field_y(i,j)*cos(lat(i,j))-field_y(i,j-1)*cos(lat(i,j-1));
      delta_y(i,j)=(lat(i,j)-lat(i,j-1))*R*cos(lat(i,j));
    else
      part_y(i,j)=field_y(i,j+1)*cos(lat(i,j+1))-field_y(i,j-1)*cos(lat(i,j-1));
      delta_y(i,j)=(lat(i,j+1)-lat(i,j-1))*R*cos(lat(i,j));
    end
  end
end

% Sum and change sign
conv_field=-part_x./delta_x-part_y./delta_y;



