function [output2D] = lanczos2D(input2D, l2Dsf, maskval, perio1, perio2)

Nx  = size(input2D,1);
Ny  = size(input2D,2);

knx = size(l2Dsf,1);
kny = size(l2Dsf,2);

knx = (knx - 1) / 2;
kny = (kny - 1) / 2;

SizeIe1 = Nx + 2 * knx;
SizeIe2 = Ny + 2 * kny;

input2dextend = zeros(Nx + 2*knx, Ny + 2*kny);

% We assume that input2D is masked with maskval
input2dextend(knx+1:knx+Nx,kny+1:kny+Ny) = input2D(:,:);

if (perio1 == 1)
    input2dextend(1:knx     ,kny+1:kny+Ny) = input2D(Nx-knx+1:Nx,:);
    input2dextend(knx+Nx+1:SizeIe1,kny+1:kny+Ny) = input2D(1:knx,:);
else
    input2dextend(1:knx           ,:) = maskval;
    input2dextend(knx+Nx+1:SizeIe1,:) = maskval;
end

if (perio2 == 1)
    input2dextend(knx+1:knx+Nx,1:kny     ) = input2D(:,Ny-kny+1:Ny);
    input2dextend(knx+1:knx+Nx,kny+Ny+1:SizeIe2) = input2D(:,1:kny);
else
   input2dextend(:,1:kny           ) = maskval;
   input2dextend(:,kny+Ny+1:SizeIe2) = maskval;
end

output2D= zeros(Nx,Ny);

for jj = 1:Ny
    
    jje = jj + kny;  
    
    for ii = 1:Nx
        
        fsum = 0.;
        
        iie = ii + knx;
        
        if (input2D(ii,jj) ~= maskval)
        
          for jfi = -kny:kny
            
              jff = jfi + kny + 1;
            
              for ifi = -knx:knx
                
                  iff = ifi + knx + 1;
                
                  if (input2dextend(iie+ifi,jje+jfi) ~= maskval)
                      fsum = fsum + l2Dsf(iff,jff);
                      output2D (ii,jj) = output2D(ii,jj) + ...
                          input2dextend(iie+ifi,jje+jfi) * l2Dsf(iff,jff);
                  end
                
              end 
            
          end
        
        if (fsum > 0.) 
            output2D (ii,jj) = output2D (ii,jj) / fsum;
        else
            output2D (ii,jj) = maskval;
        end
        
        else
            
           output2D (ii,jj) = maskval;
           
        end
             
    end
end
