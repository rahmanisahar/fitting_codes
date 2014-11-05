;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fitting Using pix by pix method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pro fit_pix_m31,out_fit,indep2
  indep=mrdfits('/Users/saharrahmani/Desktop/proms/m31_co_reproj_rot.fits',0,h_indep)
  indep*=2d20
  dep=mrdfits('/Users/saharrahmani/Desktop/proms/idl_res/halpha_reg.fits',0,h_dep)
  mass_one=2.34d*1.67d-27
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
  ;calculate the surface density
  ;------------------------------------------------------
  radii_pc=radii_cm/(3.086d18)
  area = 4*!pi*(radii_pc)^(2d)  ;in pc^2
  ;area=1
  sigma_dep= dep/area      ;unit of dependet map per pc^2
  sigma_indep= indep/area  ;unit of independate map per pc^2
  sigma_gas= gas_mass_sun/area  ;gas surface density in mass per mass of sun per pc^2
  IF npar EQ 6 THEN sigma_indep2= indep2/area
  ;------------------------------------------------------
  ;fit the sfr laws
  ;------------------------------------------------------
  ; K_S law is sigma_sfr=A*sigma_gass^N
  ; ES law is sigma_sfr=A*sigma_gass^N*sigma_stars^B
  ; one can take the logarithm from both side and have a
  ; log(sigma_sfr)=N*log(sigma_gass) + const
  ; log(sigma_sfr)=B*log(sigma_stars) + const
  ;we use IDL regress routin to fit the line
  
  logdep=alog10(dep[where (dep GT 0 AND gas_mass_sun GT 0)])
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)])
  
  logdep_area=alog10(sigma_dep[where (sigma_dep GT 0 and sigma_gas GT 0)])
  logindep_area=alog10(sigma_gas[where (sigma_dep GT 0 and sigma_gas GT 0)])
  
  IF npar EQ 6 THEN BEGIN
    logindep2= alog10(sigma_indep2)
    Weights1=fltarr(n_elements(logdep)-1)+1
    measure_errors1 = sqrt(1/Weights1)
    result1 = REGRESS(logindep, logdep, SIGMA=sigma1, CONST=const1, $
      MEASURE_ERRORS=measure_errors1)
    PRINT, 'Constant: ', const1
    PRINT, 'Power index N for gass: ', result1[*]
    PRINT, 'Standard errors: ', sigma1
    
    Weights2=fltarr(n_elements(logdep)-1)+1
    measure_errors2 = sqrt(1/Weights2)
    result2 = REGRESS(logindep2, logdep, SIGMA=sigma2, CONST=const2, $
      MEASURE_ERRORS=measure_errors2)
    PRINT, 'Constant: ', const2
    PRINT, 'Power index B for stellar mass: ', result2[*]
    PRINT, 'Standard errors: ', sigma2
    
    logindep2=alog10(sigma_indep2)
    x=[logindep,logdep]
    Weights=fltarr(n_elements(logdep)-1)+1
    measure_errors = sqrt(1/Weights)
    result = REGRESS(logindep, logdep, SIGMA=sigma, CONST=const, $
      MEASURE_ERRORS=measure_errors)
    PRINT, 'Constant: ', const
    PRINT, 'Powerindex N and B : ', result[*]
    PRINT, 'Standard errors: ', sigma
  ENDIF ELSE BEGIN
    Weights=fltarr(n_elements(logdep)-1)+1
    measure_errors = sqrt(1/Weights)
    result_high = REGRESS(logindep[where(logindep GT 2.5)], logdep[where(logindep GT 2.5)], SIGMA=sigma, CONST=const_high, $
      MEASURE_ERRORS=measure_errors)
    PRINT, 'Constant: ', const_high
    PRINT, 'Power index N: ', result_high[*]
    PRINT, 'Standard errors: ', sigma
    
    result_low = REGRESS(logindep[where(logindep LT -1.5)], logdep[where(logindep LT -1.5)], SIGMA=sigma, CONST=const_low, $
      MEASURE_ERRORS=measure_errors)
    PRINT, 'Constant: ', const_low
    PRINT, 'Power index N: ', result_low[*]
    PRINT, 'Standard errors: ', sigma

    result_med= REGRESS(logindep[where(logindep GT -0.5 AND logindep LT 1.5)], logdep[where(logindep GT -0.5 AND logindep LT 1.5)], SIGMA=sigma, CONST=const_med, $
      MEASURE_ERRORS=measure_errors)
    PRINT, 'Constant: ', const_med
    PRINT, 'Power index N: ', result_med[*]
    PRINT, 'Standard errors: ', sigma
  
   
   
   
    result_poly_high = POLY_FIT(logindep[where(logindep GT 2.5)], logdep[where(logindep GT 2.5)], 1, MEASURE_ERRORS=measure_errors, $
      SIGMA=sigma_poly)
    PRINT, 'Constant FROM POLYFIT:', result_poly_high[0]
    PRINT, 'POWER index From POLYFIT:', result_poly_high[1]
    PRINT, ' Standard errors from POLYFIT:' , sigma_poly
  ENDELSE
  stop
  ;------------------------------------------------------
  ;ploting
  ;------------------------------------------------------
  IF npar EQ 6 THEN BEGIN
    set_plot_ps,out_fit +'.ps'
    colours
    cgplot,logindep,logdep,psym=2,symsize = 0.15, title = 'ES law fitting pix by pix method for gas' ,xtitle='$\Sigma$!Igas!N (M$\sun$pc!E-2!N)',ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)'
      oplot,[min(logindep),max(logindep)]*result1[0]+const1, linestyle=0, thick=1,colo=2
    cgplot,logindep2,logdep,psym=2,symsize = 0.15, title = 'ES law fitting pix by pix method for stars' ,xtitle='$\Sigma$!Istar!N (M$\sun$pc!E-2!N)',ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)'
      oplot, [min(logindep),max(logindep)]*result2[0]+const2, linestyle=0, thick=1,colo=2
    endps
    
    p=plot(logindep,logdep,'6',$
      TITLE='ES law fitting pix by pix method for gas',$
      XTITLE='$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
      YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
      FONT_SIZE = 20,$
      SYMBOL = 'circle', $
      SYM_FILLED = 1, $
      SYM_FILL_COLOR = 'gold')
    p2=plot([min(logindep),max(logindep)]*result1[0]+const1,'r2',/overplot)
    t1=text(logindep[10],logdep[10]+4,$
      '$\log(\Sigma_SFR) = cont+N*\log(\Sigma_gas)$',$
      /DATA, FONT_SIZE=14, FONT_NAME='Helvetica')
      
    p3=plot(logindep2,logdep,'6',$
      TITLE='ES law fitting pix by pix method for stars',$
      XTITLE='$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
      YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
      FONT_SIZE = 20,$
      SYMBOL = 'circle', $
      SYM_FILLED = 1, $
      SYM_FILL_COLOR = 'gold')
    p4=plot([min(logindep),max(logindep)]*result2[1]+const2,'g2',/overplot)
    t2=text(logindep2[10],logdep[10]+4,$
      '$\log(\Sigma_SFR) = cont+B*\log(\Sigma_star)$',$
      /DATA, FONT_SIZE=14, FONT_NAME='Helvetica')
  ENDIF ELSE BEGIN
    set_plot_ps,out_fit +'.ps'
    colours
    cgplot,logindep,logdep,psym=2,symsize = 0.15, title = 'K_S law fitting pix by pix method' ,xtitle='Log($\Sigma$!Igas!N (M$\sun$pc!E-2!N))',ytitle='log($\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N))'
      oplot, [min(logindep[where(logindep GT 2.5)]),max(logindep[where(logindep GT 2.5)])]*result_high[0]+const_high, linestyle=0, thick=1,colo=2
      cgplot,gas_mass_sun[where(gas_mass_sun lt 1e4)],dep[where(gas_mass_sun lt 1e4)],psym=2,title = 'K_S law fitting pix by pix method' ,xtitle='$\Sigma$!Igas!N (M$\sun$pc!E-2!N)',ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)'
    endps
    p=plot(logindep,logdep,'6',$
      TITLE='K_S law fitting pix by pix method',$
      XTITLE='$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
      YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
      FONT_SIZE = 20,$
      SYMBOL = 'circle', $
      SYM_FILLED = 1, $
      SYM_FILL_COLOR = 'gold')
    p2=plot([min(logindep[where(logindep GT 2.5)]),max(logindep[where(logindep GT 2.5)])]*result_high[0]+const_high,'r2',/overplot)
    t1=text(logindep[10]-2,logdep[10]+4,$
      '$log(\Sigma_{SFR}) = cont+N*log(\Sigma_{gas})$',$
      /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
      
  ENDELSE
  ;stop
END
