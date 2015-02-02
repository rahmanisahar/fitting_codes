pro data_between_18kpc_25kpc_hi

  indep=mrdfits('~/Desktop/project/proms/hi/hi_reproj.fits',0,h_indep)
  dep=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/sfr_fuv_hao_reg_hi_sb.fits',0,h_dep)
  err_sfr=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/err_sfr_fuv_reg_hi_sb.fits',0)
  err_hi=mrdfits('~/Desktop/project/proms/hi/err_hi.fits',0)
  size_of_arcsec= 3.4975200d ; in the distance of M31 each arcsec is equal to ~3.5pc
  ra=10.724382145
  dec=41.332205842
  arcsec_of_25kpc=25d3/size_of_arcsec
  arcsec_of_18kpc=18d3/size_of_arcsec
  ADXY, h_indep, ra, dec, x_c, y_c       ;Get X and Y corresponding to RA and Dec
  GETROT, h_indep, rot, cdelt        ;CDELT gives plate scale degrees/pixel
  cdelt = abs( cdelt)*3600.    ;CDELT now in arc seconds/pixel
  DIST_ELLIPSE, ell,[360,251], x_c, y_c,4.1,38 ;Create a elliptical image mask ;This one is for Hi map position
  ; DIST_ELLIPSE, ell,[900,300], x_c, y_c,4.1,90 ;Create a elliptical image mask ;This one is for co map position
  ell = ell*cdelt(0)           ;Distances now given in arcseconds
  good = where( ell gt arcsec_of_18kpc and ell lt arcsec_of_25kpc )   ;gt 18kpc and lt 25kpc
  ;       print,total( im(good) )      ;Total pixel values within 8kpc
  
  pp= contour(dep)
  pp1=contour(ell,/overplot)
  
  indep=indep[good]
  err_hi=err_hi[good]
  dep=dep[good]
  err_sfr=err_sfr[good]
  ;stop
  mass_one=1.67d-27 ; mass of one HI atom in kg
  pix_size=43.749994d
  ;stop
  ;------------------------------------------------------
  ;calculate the gas_mass
  ;------------------------------------------------------
  ;convert diameters from pc to cm: 1 pc = 3.086*10^18 cm
  diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
  radii_cm= diam_cm/2d             ;raduis of the region in cm
  gas_vdens= indep/diam_cm     ;volume density of the region in N/cm^3
  err_hi_vdence=err_hi/diam_cm
  vol= (4d*!pi*(radii_cm)^(3d))/3d      ;volume of the regions assume our clouds are spherical
  gas_mass=mass_one*vol*gas_vdens  ;mass of the ISM region in Kg
  err_gas_mass=mass_one*vol*err_hi_vdence
  mass_sun = 1.9891d30      ;mass of sun is 1.9891 * 10^30kg
  gas_mass_sun = gas_mass/mass_sun ;mass of the ISM regions per mass of sun
  err_gas_mass_sun= err_gas_mass/mass_sun
  
  radii_pc=radii_cm/(3.086d18)
  area = 4*!pi*(radii_pc)^(2d)  ;in pc^2
  ;area=1d
  dep= dep/area      ;unit of dependet map per pc^2
  indep= indep/area  ;unit of independate map per pc^2
  gas_mass_sun= gas_mass_sun/area  ;gas surface density in mass per mass of sun per pc^2
  err_sfr/=area
  err_gas_mass_sun/=area
  ;stop
  ;------------------------------------------------------
  ;fit the sfr laws
  ;------------------------------------------------------
  logdep=alog10(dep[where (dep GT 0 AND gas_mass_sun GT 0)])
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)])
  ;logdep=double(logdep)
  ;logindep=double(logindep)
  err_sfr=err_sfr[where (dep GT 0 AND gas_mass_sun GT 0)]
  err_gas=err_gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0 )]
  dep2=dep[where (dep GT 0 AND gas_mass_sun GT 0)]
  gas_mass_sun2=gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)]
  err_sfr_f=abs(err_sfr/(alog(10)*dep2))
  err_gas_f=abs(err_gas/(alog(10)*gas_mass_sun2))
  len=n_elements(logindep)
  index=intarr(len)+31
  ;stop
  ;------------------------------------------------------
  ;csv
  ;------------------------------------------------------
  WRITE_CSV, 'M31data.csv',index,logindep,err_gas_f,logdep,err_sfr_f
END
