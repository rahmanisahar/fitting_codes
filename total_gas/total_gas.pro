pro total_gas
co=mrdfits('co_reg_hi_sb.fits',0,hd)
n2=mrdfits('../hi_reproj.fits',0,hd1)
n1=co*2d20
x = findgen(sxpar(hd, 'naxis1')) ; convert FITS to IDL convention
y = findgen(sxpar(hd, 'naxis2'))
indep= dblarr(n_elements(x),n_elements(y))
FOR i= 0, n_elements(x)-1 DO BEGIN
    FOR j=0, n_elements(y)-1 DO BEGIN
      ;sigma_sfr=N*sigma_gass+const
      ;const=-9.15 result from polyfit for all data
      IF n1[i,j] EQ n1[i,j] and n2[i,j] eq n2[i,j] THEN BEGIN
         indep[i,j]=2*n1[i,j]+n2[i,j]
      endif else begin
         if n1[i,j] ne n1[i,j] then begin
            indep[i,j]=n2[i,j]
         endif
         if n2[i,j] ne n2[i,j] then begin
            indep[i,j]=2*n1[i,j]
         endif
      endelse
   endfor
 endfor
stop
mass_one=1.36d*1.67d-27
size_of_arcsec= 3.4975200d
pix_size=43.749994d
diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
radii_cm= diam_cm/2d             ;raduis of the region in cm
gas_vdens= indep/diam_cm     ;volume density of the region in N/cm^3
vol= 4d*!pi*(radii_cm)^(3d)/3d      ;volume of the regions assume our clouds are spherical
gas_mass=mass_one*vol*gas_vdens  ;mass of the ISM region in Kg
mass_sun = 1.9891d30      ;mass of sun is 1.9891 * 10^30kg
gas_mass_sun = gas_mass/mass_sun ;mass of the ISM regions per mass of sun
writefits,'total_gas.fits',gas_mass,hd 
writefits,'total_gas_per_mass_sun.fits',gas_mass_sun,hd

END
