function [l2Dsf] = lanczos2Dspectralfilter_v2(...
					   Cfx,Nx,Cfy,Ny)
                   
% Cfx est la fréquence de coupure en X
% Cfx = dx / longueur d'onde en longitude
% par exemple on a des champs AVISO au 1/3° et on veut seulement les
% longueurs d'onde supérieur à 20° en longitude
% Cfx = (1/3°)/20° = 1/60;
%
% Cfy est la fréquence de coupure en Y
% Cfy = dy / longueur d'onde en latitude
% par exemple on a des champs AVISO au 1/3° et on veut seulement les
% longueurs d'onde supérieur à 10° en latitude
% Cfx = (1/3°)/10° = 1/30;
               
dTx = 1.;
dTy = 1.;

%%
invNx = 1./Nx;
invNy = 1./Ny;
                   
CosineFilterxy = zeros(2*Nx+1,2*Ny+1);  

for jj = -Ny: Ny
    
    ky = jj + Ny + 1;
    
    for ii = -Nx: Nx
        
        kx = ii + Nx + 1;
        
        if ( (ii == 0) && (jj ==0))
            
            CosineFilterxy(kx,ky) = pi * Cfx * Cfy;
            
        else
            
            zz= sqrt(Cfx.^2 * ii.^2 * dTx.^2 + Cfy.^2 * jj.^2 * dTy.^2);
    
            CosineFilterxy(kx,ky) = ...
                Cfx * Cfy * besselj(1, (2. * pi * zz))/zz; 
            
        end
        
    end
    
end

SigmaFactorxy = zeros(2*Nx+1,2*Ny+1);

for jj = -Ny: Ny
    
    ky = jj + Ny + 1;
    
    for ii = -Nx: Nx
        
        kx = ii + Nx + 1;
        
        if ( (ii == 0) && (jj ==0))
            
            SigmaFactorxy(kx,ky) = 1.;
            
        elseif ((ii==0) && (jj~=0))
            
           SigmaFactorxy(kx,ky) = (sin(pi * jj * invNy)  / ...
                                      (pi * jj * invNy)) ;
            

        elseif ((ii~=0) && (jj==0))
            
            SigmaFactorxy(kx,ky) = (sin(pi * ii * invNx)  / ...
                                       (pi * ii * invNx));

        else

          SigmaFactorxy(kx,ky) = (sin(pi * ii * invNx)  / ...
                                     (pi * ii * invNx)) * ...
                                 (sin(pi * jj * invNy)  / ...
                                     (pi * jj * invNy)) ;
            
        end
        
    end
    
end


l2Dsf = CosineFilterxy.*SigmaFactorxy;
