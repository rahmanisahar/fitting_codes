pro fit_pix_es_m31_simple
  indep=mrdfits('~/Desktop/project/proms/h2/m31_co_reproj_rot.fits',0,h_indep)
  indep*=2d20
  dep=mrdfits('~/Desktop/project/proms/h2/reg_to_co/sfr_fuv_reg_co_sb.fits',0,h_dep)
  star=mrdfits('~/Desktop/project/proms/h2/reg_to_co/mass_reg_co_sb.fits',0,h_indep2)
  mass_one=2.34d*1.67d-27
  size_of_arcsec= 3.4975200d
  pix_size=7.9999993d
  ;------------------------------------------------------
  ;calculate the gas_mass
  ;------------------------------------------------------
  ;convert diameters from pc to cm: 1 pc = 3.086*10^18 cm
  diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
  radii_cm= diam_cm/2d             ;raduis of the region in cm
  gas_vdens= indep/diam_cm     ;volume density of the region in N/cm^3
  vol= 4d*!pi*(radii_cm)^(3d)/3d      ;volume of the regions assume our clouds are spherical
  gas_mass=mass_one*vol*gas_vdens  ;mass of the ISM region in Kg
  mass_sun = 1.9891d30      ;mass of sun is 1.9891 * 10^30kg
  gas_mass_sun = gas_mass/mass_sun ;mass of the ISM regions per mass of sun
  
   radii_pc=radii_cm/(3.086d18)
   area = 4*!pi*(radii_pc)^(2d)  ;in pc^2
  ;area=1d
  dep= dep/area      ;unit of dependet map per pc^2
  indep= indep/area  ;unit of independate map per pc^2
  gas_mass_sun= gas_mass_sun/area  ;gas surface density in mass per mass of sun per pc^2
  star=star/area
  ;------------------------------------------------------
  ;fit the sfr laws
  ;------------------------------------------------------
  logdep=alog10(dep[where (dep GT 0 AND gas_mass_sun GT 0)])
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)])
  logstar=alog10(star[where (dep GT 0 AND gas_mass_sun GT 0)])
  
  
  pos=where(logindep GT -1)

  indep_both=[transpose(logstar[pos]), transpose(logindep[pos])]
  ;pos2=where(logindep LT -1.5)
 Weights=fltarr(n_elements(logdep[pos])-1)+1
;Weights[pos2]*=0.00001d
measure_errors = sqrt(1/Weights)
  result = REGRESS(indep_both, logdep[pos], SIGMA=sigma, CONST=const, $
    MEASURE_ERRORS=measure_errors)
  PRINT, 'Constant: ', const
  PRINT, 'Power index N: ', min(result[*],/nan)
  PRINT, 'Standard errors: ', sigma
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
;  result = poly_fit(indep_both, logdep[pos], SIGMA=sigma, $
;   MEASURE_ERRORS=measure_errors)
;  PRINT, 'Constant: ', const
;   PRINT, 'Power index N: ', result[*]
;   PRINT, 'Standard errors: ', sigma
;  
stop
  ;------------------------------------------------------
  ;ploting
  ;------------------------------------------------------
  p=plot3d(logindep[pos],logdep[pos],logstar[pos],'6',$
    TITLE='fitting pix by pix method',$
    XTITLE='$\Sigma_{H_2}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
    AXIS_STYLE=2,$
   XMINOR=0, YMINOR=0, ZMINOR=0, $
   DEPTH_CUE=[0, 2], /PERSPECTIVE, $
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold')
    ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
    stop
  
  p=plot(indep_both[pos],logdep[pos],'6',/SYM_FILLED,$
    TITLE='K_S law fitting pix by pix method',$
    XTITLE='$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    FONT_SIZE = 20,$
    SYMBOL = 'circle', $
    SYM_FILL_COLOR = 'gold')
  p2=plot([max(logindep[pos]),min(logindep[pos])],$
    [max(logindep[pos]),min(logindep[pos])]*result[0]+const,$
    'r2',/overplot)
  t1=text(logindep[10]-2,logdep[10]+4,$
    '$log(\Sigma_{SFR}) = cont+N*log(\Sigma_{gas})$',$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    
END
