pro total_gas_err
  co=mrdfits('../hi/reg_to_hi/co_reg_hi_sb.fits',0,hd)
  err_co=mrdfits('../hi/reg_to_hi/err_co_reg_hi_sb.fits',0,h1)
  n2=mrdfits('../hi/hi_reproj.fits',0,hd1)
  err_hi=mrdfits('../hi/err_hi.fits',0,h2)
  n1=co*2d20
  err_co*=2d20
  x = findgen(sxpar(hd, 'naxis1')) ; convert FITS to IDL convention
  y = findgen(sxpar(hd, 'naxis2'))
  indep= dblarr(n_elements(x),n_elements(y))
  err2_tot=dblarr(n_elements(x),n_elements(y))
  stop
  FOR i= 0, n_elements(x)-1 DO BEGIN
    FOR j=0, n_elements(y)-1 DO BEGIN
      ;sigma_sfr=N*sigma_gass+const
      ;const=-9.15 result from polyfit for all data
      IF n1[i,j] EQ n1[i,j] and n2[i,j] eq n2[i,j] THEN BEGIN
        indep[i,j]=2*n1[i,j]+n2[i,j]
        err2_tot[i,j]=4*err_co[i,j]^2+err_hi[i,j]^2
      endif else begin
        if n1[i,j] ne n1[i,j] then begin
          indep[i,j]=n2[i,j]
          err2_tot[i,j]=err_hi[i,j]^2
        endif
        if n2[i,j] ne n2[i,j] then begin
          indep[i,j]=2*n1[i,j]
          err2_tot[i,j]=4*err_co[i,j]^2
        endif
      endelse
    endfor
  endfor
  stop
  err_tot=sqrt(err2_tot)
  mass_one=1.36d*1.67d-27
  size_of_arcsec= 3.4975200d
  pix_size=43.749994d
  diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
  radii_cm= diam_cm/2d             ;raduis of the region in cm
  gas_vdens= indep/diam_cm     ;volume density of the region in N/cm^3
  err_tot_v=err_tot/diam_cm 
  vol= 4d*!pi*(radii_cm)^(3d)/3d      ;volume of the regions assume our clouds are spherical
  gas_mass=mass_one*vol*gas_vdens  ;mass of the ISM region in Kg
  err_tot_gas=mass_one*vol*err_tot_v
  mass_sun = 1.9891d30      ;mass of sun is 1.9891 * 10^30kg
  gas_mass_sun = gas_mass/mass_sun ;mass of the ISM regions per mass of sun
  err_tot_mass_sun=err_tot_gas/mass_sun
  writefits,'err_tot_gas_sun.fits',err_tot_mass_sun,hd
  writefits,'err_tot_gas.fits',err_tot_gas,hd
  stop
 ; writefits,'total_gas.fits',gas_mass,hd
 ; writefits,'total_gas_per_mass_sun.fits',gas_mass_sun,hd
  
END
