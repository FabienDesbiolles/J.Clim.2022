%script example pour les derivatives appliquer comme dans le papier:
% DMM: drdot/dr and dsst/dr:
% load lon lat du domaine,sst, u10 v10 large scale (lf ici)
% dsst/dr:
%---------------------------------------------
for kk = 1:length(sst(1,1,:))
        kk
        temps  = squeeze(sst(:,:,kk));
        tempu  = squeeze(u_lf(:,:,kk));
        tempv  = squeeze(v_lf(:,:,kk));
dsst_dr(:,:,kk) = along_wind_derivative(temps,lon,lat,tempu,tempv);
end
%---------------------------------------------
% drdot/dr:
% load u10,v10,sst,v_lf,u_lf
cpt = 1;
for kk =1:length(sst(1,1,:))
        utmp = squeeze(u(:,:,kk));
        vtmp = squeeze(v(:,:,kk));
        stmp = squeeze(sst(:,:,kk));
% u_prime/v_prime:
u_prime = utmp - squeeze(u_lf(:,:,cpt)); v_prime = vtmp - squeeze(v_lf(:,:,cpt));
r_dot_prime = (u_prime.*squeeze(u_lf(:,:,cpt)) + v_prime.*squeeze(v_lf(:,:,cpt)))./ ...
   sqrt(squeeze(u_lf(:,:,cpt)).^2 + squeeze(v_lf(:,:,cpt)).^2);
dr_dot_prime_dr(:,:,cpt) = along_wind_derivative(r_dot_prime,lon,lat,squeeze(u_lf(:,:,cpt)),squeeze(v_lf(:,:,cpt)));
cpt = cpt + 1;
end
%---------------------------------------------
% PA: dsdot/ds and d2sst/ds2:
cpt = 1;
for kk =1:365
          cpt
        utmp = squeeze(u(:,:,kk));
        vtmp = squeeze(v(:,:,kk));
        stmp = squeeze(sst(:,:,kk));
u_prime = utmp - squeeze(u_lf(:,:,cpt)); v_prime = vtmp - squeeze(v_lf(:,:,cpt));
s_dot_prime = (-u_prime.*squeeze(v_lf(:,:,cpt)) + v_prime.*squeeze(u_lf(:,:,cpt)))./ ...
   sqrt(squeeze(u_lf(:,:,cpt)).^2 + squeeze(v_lf(:,:,cpt)).^2);
% dsdot/ds:
 ds_dot_prime_ds(:,:,cpt) = across_wind_derivative(s_dot_prime,lon,lat,squeeze(u_lf(:,:,cpt)),squeeze(v_lf(:,:,cpt)));
% d2sst/ds2
dsst_ds = across_wind_derivative(stmp,lon,lat,squeeze(u_lf(:,:,cpt)),squeeze(v_lf(:,:,cpt)));
d2sst_ds2(:,:,cpt) = across_wind_derivative(dsst_ds,lon,lat,squeeze(u_lf(:,:,cpt)),squeeze(v_lf(:,:,cpt)));
% cpt incrementation:
cpt = cpt + 1;
end











