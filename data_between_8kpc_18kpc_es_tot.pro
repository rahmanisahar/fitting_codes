pro data_between_8kpc_18kpc_es_tot
  dep=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/sfr_fuv_hao_reg_hi_sb.fits',0,h_dep)
  gas_mass_sun=mrdfits('~/Desktop/project/proms/total_gas/total_gas_sun.fits',0,hd_gas)
  star=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/star_reg_hi_sb.fits',0,h_indep2)
  err_sfr=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/err_sfr_fuv_reg_hi_sb.fits',0)
  err_tot_gas_sun=mrdfits('~/Desktop/project/proms/total_gas/err_tot_gas_sun.fits',0)
  err_stars=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/err_stars_reg_hi_sb.fits',0)
  
  size_of_arcsec= 3.4975200d ; in the distance of M31 each arcsec is equal to ~3.5pc
  ra=10.724382145
  dec=41.332205842
  arcsec_of_8kpc=8d3/size_of_arcsec
  arcsec_of_18kpc=18d3/size_of_arcsec
  ADXY, hd_gas, ra, dec, x_c, y_c       ;Get X and Y corresponding to RA and Dec
  GETROT, hd_gas, rot, cdelt        ;CDELT gives plate scale degrees/pixel
  cdelt = abs( cdelt)*3600.    ;CDELT now in arc seconds/pixel
  DIST_ELLIPSE, ell,[360,251], x_c, y_c,4.1,38 ;Create a elliptical image mask ;This one is for Hi map position
  ; DIST_ELLIPSE, ell,[900,300], x_c, y_c,4.1,90 ;Create a elliptical image mask ;This one is for co map position
  ell = ell*cdelt(0)           ;Distances now given in arcseconds
  good = where( ell gt arcsec_of_8kpc and ell lt arcsec_of_18kpc )   ;gt 8kpc and lt 18kpc
  ;       print,total( im(good) )      ;Total pixel values within 8kpc
  ;pp= contour(dep)
  ;pp1=contour(ell,/overplot)
  gas_mass_sun=gas_mass_sun[good]
  err_tot_gas_sun=err_tot_gas_sun[good]
  star=star[good]
  err_stars=err_stars[good]
  dep=dep[good]
  err_sfr=err_sfr[good]
  ;stop
  ;------------------------------------------------------
  ;now we seprate all the data within 8kpc
  ;-----------------------------------------------------
  pix_size=43.749994d
  ;------------------------------------------------------
  ;calculate the gas_mass
  ;-----------------------------------------------------
  ;convert diameters from pc to cm: 1 pc = 3.086*10^18 cm
  diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
  radii_cm= diam_cm/2d             ;raduis of the region in cm
  radii_pc=radii_cm/(3.086d18)
  area = 4*!pi*(radii_pc)^(2d)  ;in pc^2
  ;area=1d
  dep= dep/area      ;unit of dependet map per pc^2
  ; indep= indep/area  ;unit of independate map per pc^2
  gas_mass_sun= gas_mass_sun/area  ;gas surface density in mass per mass of sun per pc^2
  
  err_sfr/=area
  err_gas_mass_sun=err_tot_gas_sun/area
  star=star/area
  err_stars/=area
  ;  stop
  ;------------------------------------------------------
  ;fit the sfr laws
  ;------------------------------------------------------
  logdep=alog10(dep[where (dep GT 0 AND gas_mass_sun GT 0)])
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)])
  logstar=alog10(star[where (dep GT 0 AND gas_mass_sun GT 0)])
  
  err_stars=err_stars[where (dep GT 0 AND gas_mass_sun GT 0)]
  ;stop
  err_sfr=err_sfr[where (dep GT 0 AND gas_mass_sun GT 0)]
  err_gas=err_gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0 )]
  dep2=dep[where (dep GT 0 AND gas_mass_sun GT 0)]
  gas_mass_sun2=gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)]
  stars2=star[where (dep GT 0 AND gas_mass_sun GT 0)]
  err_stars_f=abs(err_stars/(alog(10)*stars2))
  pos=where(err_gas eq err_gas and err_stars eq err_stars)
  err_sfr_f=abs(err_sfr/(alog(10)*dep2))
  err_gas_f=abs(err_gas/(alog(10)*gas_mass_sun2))
  len=n_elements(pos)
  index=intarr(len)+31
  
  ;stop
  ;------------------------------------------------------
  ;csv
  ;------------------------------------------------------
  WRITE_CSV, 'M31data.csv',index,logindep[pos],err_gas_f[pos],logstar[pos],err_stars_f[pos],logdep[pos],err_sfr_f[pos]
  
  
  
  
  
END