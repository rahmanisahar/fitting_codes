;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fitting Using pix by pix method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pro fit_pix_surf,indep,h_indep,dep,mass_one=mass_one, out_fit,indep2
npar = N_params()
IF npar EQ 6 THEN print,'unit of the stellar mass must be per mass of sun'
;title_n: is title of the plots
;------------------------------------------------------
;Find how many parsecs correspond to one arcsec in distance of the galaxy
;------------------------------------------------------
find_arcsec_in_pc,size_of_arcsec
;------------------------------------------------------
;calculate the pix_size of the images
;------------------------------------------------------
find_the_pixel_size, h_indep,pix_size ;pixel size in arcsec
;------------------------------------------------------
;calculate the gas_mass
;------------------------------------------------------
;convert diameters from pc to cm: 1 pc = 3.086*10^18 cm
diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
radii_cm= diam_cm/2d             ;raduis of the region in cm
gas_vdens= indep/diam_cm     ;volume density of the region in N/cm^3
vol= 4d*!pi*(radii_cm)^3/3d      ;volume of the regions assume our clouds are spherical
gas_mass=mass_one*vol*gas_vdens  ;mass of the ISM region in Kg
mass_sun = 1.9891d30      ;mass of sun is 1.9891 * 10^30kg
gas_mass_sun = gas_mass/mass_sun ;mass of the ISM regions per mass of sun
;------------------------------------------------------
;Find the position of apr
;------------------------------------------------------
x = findgen(sxpar(h_indep, 'naxis1')) ; convert FITS to IDL convention
y = findgen(sxpar(h_indep, 'naxis2'))
;------------------------------------------------------
;Calculate the surface
;------------------------------------------------------

N = dblarr(n_elements(x),n_elements(y))

FOR i= 0, n_elements(x)-1 DO BEGIN
   FOR j=0, n_elements(y)-1 DO BEGIN
      ;sigma_sfr=N*sigma_gass+const
      ;const=-9.15 result from polyfit for all data
      IF dep[i,j] GT 0 THEN BEGIN
         IF gas_mass_sun[i,j] GT 0.46856403  THEN BEGIN
            N[i,j] = (alog10(dep[i,j])-(-9.15))/alog10(gas_mass_sun[i,j])
         ENDIF ELSE BEGIN
            N[i,j]=!VALUES.F_NAN
         ENDELSE
      ENDIF ELSE BEGIN
         N[i,j]=!VALUES.F_NAN
      ENDELSE
   ENDFOR
ENDFOR

stop
;------------------------------------------------------
;ploting
;------------------------------------------------------
set_plot_ps,out_fit +'.ps'
colours
CONTOUR, N , X, Y,LEVELS =[0.6,1,1.5], /XSTYLE, /YSTYLE, title='Power Index Surface',xtitle='x',ytitle='y', C_ANNOTATION = ["Low", "Medium", "High"],/follow
CONTOUR, N , X, Y,LEVELS =[0.6,1,1.2], /XSTYLE, /YSTYLE, title='Power Index Surface',xtitle='x',ytitle='y',max_value=1.5, C_ANNOTATION = ["Low", "Medium", "High"],/fill
CONTOUR, N , X, Y,LEVELS =[0.6,1,1.2], /XSTYLE, /YSTYLE, title='Power Index Surface',xtitle='x',ytitle='y',max_value=1.5, C_ANNOTATION = ["Low", "Medium", "High"]
CONTOUR, N , X, Y,nLEVELS =10, /XSTYLE, /YSTYLE, title='Power Index Surface',xtitle='x',ytitle='y',max_value=1.5,min_value=-20,C_COLORS = BYTSCL(INDGEN(10)), /fill

endps
END
