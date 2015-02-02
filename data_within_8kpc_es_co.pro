pro data_within_8kpc_es_co
  indep=mrdfits('~/Desktop/project/proms/h2/m31_co_reproj_rot.fits',0,h_indep)
  dep=mrdfits('~/Desktop/project/proms/h2/reg_to_co/sfr_halpha_reg_co_sb.fits',0,h_dep)
  star=mrdfits('~/Desktop/project/proms/h2/reg_to_co/stars_mass_reg_co_sb.fits',0,h_indep2)
  err_sfr=mrdfits('~/Desktop/project/proms/h2/reg_to_co/err_sfr_halpha_reg_co_sb.fits',0)
  err_stars=mrdfits('~/Desktop/project/proms/h2/reg_to_co/err_stars_reg_co_sb.fits',0)
  err_co=mrdfits('~/Desktop/project/proms/h2/reg_to_co/err_co.fits',0)
  
  size_of_arcsec= 3.4975200d ; in the distance of M31 each arcsec is equal to ~3.5pc
  ra=10.724382145
  dec=41.332205842
  arcsec_of_8kpc=8d3/size_of_arcsec
  ADXY, h_indep, ra, dec, x_c, y_c       ;Get X and Y corresponding to RA and Dec
  GETROT, h_indep, rot, cdelt        ;CDELT gives plate scale degrees/pixel
  cdelt = abs( cdelt)*3600.    ;CDELT now in arc seconds/pixel
  ;DIST_ELLIPSE, ell,[360,251], x_c, y_c,4.1,38 ;Create a elliptical image mask ;This one is for Hi map position
   DIST_ELLIPSE, ell,[900,300], x_c, y_c,4.1,90 ;Create a elliptical image mask ;This one is for co map position
  ell = ell*cdelt(0)           ;Distances now given in arcseconds
  good = where( ell lt arcsec_of_8kpc )   ;Within 8kpc
  ;       print,total( im(good) )      ;Total pixel values within 8kpc
  
  pp= contour(dep)
  pp1=contour(ell,/overplot)
  
  indep=indep[good]
  err_co=err_co[good]
  star=star[good]
  err_stars=err_stars[good]
  dep=dep[good]
  err_sfr=err_sfr[good]
  stop
  
  
  err_co*=2d20
  indep*=2d20
  mass_one=2.34d*1.67d-27
  pix_size=7.9999993d
  ;------------------------------------------------------
  ;calculate the gas_mass
  ;------------------------------------------------------
  ;convert diameters from pc to cm: 1 pc = 3.086*10^18 cm
  diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
  radii_cm= diam_cm/2d             ;raduis of the region in cm
  gas_vdens= indep/diam_cm     ;volume density of the region in N/cm^3
  err_co_v=err_co/diam_cm
  vol= 4d*!pi*(radii_cm)^(3d)/3d      ;volume of the regions assume our clouds are spherical
  gas_mass=mass_one*vol*gas_vdens  ;mass of the ISM region in Kg
  err_co=mass_one*vol*err_co_v
  mass_sun = 1.9891d30      ;mass of sun is 1.9891 * 10^30kg
  gas_mass_sun = gas_mass/mass_sun ;mass of the ISM regions per mass of sun
  err_co_sun=err_co/mass_sun
  radii_pc=radii_cm/(3.086d18)
  area = 4*!pi*(radii_pc)^(2d)  ;in pc^2
  
  dep= dep/area      ;unit of dependet map per pc^2
  indep= indep/area  ;unit of independate map per pc^2
  gas_mass_sun= gas_mass_sun/area  ;gas surface density in mass per mass of sun per pc^2
  err_sfr/=area
  err_co_sun/=area
  err_gas_mass_sun=err_co_sun
  star=star/area
  err_stars/=area
  ;stop
  ;------------------------------------------------------
  ;make error files
  ;------------------------------------------------------
  logdep=alog10(dep[where ( dep GT 0 AND gas_mass_sun GT 0 )])
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0 )])
  logstar=alog10(star[where (dep GT 0 AND gas_mass_sun GT 0)])
  
  
  err_stars=err_stars[where (dep GT 0 AND gas_mass_sun GT 0)]
  err_sfr=err_sfr[where (dep GT 0 AND gas_mass_sun GT 0)]
  err_gas=err_gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0 )]
  pos = where(logindep GT -1 and err_sfr eq err_sfr and err_stars eq err_stars)
  dep2 = dep[where (dep GT 0 AND gas_mass_sun GT 0)]
  gas_mass_sun2 = gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)]
  stars2=star[where (dep GT 0 AND gas_mass_sun GT 0)]
  err_stars_f=abs(err_stars/(alog(10)*stars2))
  err_sfr_f = abs(err_sfr/(alog(10)*dep2))
  err_gas_f = abs(err_gas/(alog(10)*gas_mass_sun2))
  len=n_elements(logindep[pos])
  index=intarr(len)+31
  
  stop
  ;------------------------------------------------------
  ;csv
  ;------------------------------------------------------
  WRITE_CSV, 'M31data.csv',index,logindep[pos],err_gas_f[pos],logstar[pos],err_stars_f[pos],logdep[pos],err_sfr_f[pos]
END

