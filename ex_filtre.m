% Example script pour filtre lanczos:
%--------------------------------------------
%
% set filter:
dxy = 1/4;
Cxy = 10 ; %cut-off length in deg
Cfxy = dxy/Cxy
%set size:
Nx = 10; Ny=10;
periox = 1; perioy = 0; % periodic in x
Lanc2D = lanczos2Dspectralfilter_v2(Cfxy,Nx,Cfxy,Ny);
% Ci-dessus avec les param que j'ai utilise pour ERA5..
% Dans ton cas, le cut-off sera plus petit et le filtre non periodic
%
% Apres, il faut le faire chaque pas de temps (hourly ou daily average)
directory= 'xxxx/xxxx';
ext= '*.nc';
chemin = fullfile(directory,ext);
list = dir(chemin);
tt = cell(length(list),1);
tmp_dir = './';
cpt = 1;
for kk =1:length(tt)
    fname= fullfile(directory,list(kk).name);
    tmp = length(ncread(fname,'u10',[1,1,1],[1,1,inf]));
    cpt2 = 1;
  for kkk=1:tmp
          cpt
        utmp = ncread(fname,'u10',[1,1,cpt2],[inf,inf,1]);
        vtmp = ncread(fname,'v10',[1,1,cpt2],[inf,inf,1]);
% U-comp:
u_lf_tmp = lanczos2D(utmp,Lanc2D,NaN,periox,perioy);
u_lf(:,:,cpt) = u_lf_tmp;
u(:,:,cpt) = utmp;
% U-comp:
v_lf_tmp = lanczos2D(vtmp,Lanc2D,NaN,periox,perioy);
v_lf(:,:,cpt) = v_lf_tmp;
v(:,:,cpt) = vtmp;
cpt = cpt + 1;
cpt2 = cpt2 +1;
  end
end











