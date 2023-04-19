function dfield_dr=across_wind_derivative(field,long,lat,u_ref,v_ref)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  function dfield_dl=across_wind_derivative(field,long,lat,u_ref,v_ref)
%  
%  Calculate the derivative of the scalar field given as input across
%  the direction of the reference wind field u_ref, v_ref.
%  Longitude and latitude are in degrees.
%
%  dfield_ds = hat{s} cdot grad_field
%
%                  d(field_x)        d(field_y)
%  grad_field =  { ____________ ;   ____________ }
%                      dx                dy
%  
%  The output fields have the same dimensions as the input ones.
%  NB: the long field varies along the rows and the lat one along the columns.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dfield_dx, dfield_dy] = gradient(field,long,lat);

ws = sqrt(u_ref.^2 + v_ref.^2);
dfield_dr = - dfield_dx.*v_ref./ws + dfield_dy.*u_ref./ws;
  
