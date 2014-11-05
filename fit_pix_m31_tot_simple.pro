pro fit_pix_m31_tot_simple,out,out_fit
 indep=mrdfits('~/Desktop/project/proms/total_gas/total_gas.fits',0,h_indep)
 dep=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/sfr_fir_reg_hi.fits',0,h_dep)
gas_mass_sun=mrdfits('~/Desktop/project/proms/total_gas/total_gas_sun.fits',0)
size_of_arcsec= 3.4975200d
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
  indep= indep/area  ;unit of independate map per pc^2
  gas_mass_sun= gas_mass_sun/area  ;gas surface density in mass per mass of sun per pc^2
  ;------------------------------------------------------
  ;fit the sfr laws
  ;------------------------------------------------------
  logdep=alog10(dep[where (dep GT 0 AND gas_mass_sun GT 0)])
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)])
  ;pos=where(logindep GT min(indep))
  ;pos2=where(logindep LT -2.5)
  Weights=fltarr(n_elements(logdep)-1)+1
  ;Weights[pos2]*=0.00001d
  measure_errors = sqrt(1/Weights)
  result = REGRESS(logindep, logdep, SIGMA=sigma, CONST=const, $
    MEASURE_ERRORS=measure_errors)
  PRINT, 'Constant: ', const
  PRINT, 'Power index N: ', result[*]
  PRINT, 'Standard errors: ', sigma
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
  ;result = REGRESS(logindep, logdep, SIGMA=sigma, CONST=const, $
  ; MEASURE_ERRORS=measure_errors)
  ;PRINT, 'Constant: ', const
  ; PRINT, 'Power index N: ', result[*]
  ; PRINT, 'Standard errors: ', sigma
  ;------------------------------------------------------
  ;fit the sfr laws surface
  ;------------------------------------------------------
  x = findgen(sxpar(h_indep, 'naxis1')) ; convert FITS to IDL convention
  y = findgen(sxpar(h_indep, 'naxis2'))
  N = dblarr(n_elements(x),n_elements(y))
  FOR i= 0, n_elements(x)-1 DO BEGIN
    FOR j=0, n_elements(y)-1 DO BEGIN
      ;sigma_sfr=N*sigma_gass+const
      ;const=-9.15 result from polyfit for all data
      IF dep[i,j] GT 0 THEN BEGIN
        IF alog10(gas_mass_sun[i,j]) GT 0  THEN BEGIN
          N[i,j] = (alog10(dep[i,j])-const)/alog10(gas_mass_sun[i,j])
        ENDIF ELSE BEGIN
          N[i,j]=!VALUES.F_NAN
        ENDELSE
      ENDIF ELSE BEGIN
        N[i,j]=!VALUES.F_NAN
      ENDELSE
    ENDFOR
  ENDFOR
  PRINT, 'avg N is:', avg(N,/nan)
;  stop
  ;------------------------------------------------------
  ;ploting
  ;------------------------------------------------------
  
;  Writefits, out,N
;  set_plot_ps,out_fit +'.ps'
;  colours
;  cgplot,logindep,logdep,psym=2,symsize = 0.15, title = 'K_S law fitting pix by pix method with Halpha and total gas' ,xtitle='$\Sigma$!Igas!N (M$\sun$pc!E-2!N)',$
;    ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)'
;    ;cgoplot, ([max(logindep),min(logindep)],[max(logindep[pos]),min(logindep[pos])])*result[0]+const,linestyle=0, thick=1,colo=2
;    endps
     number=Round(result[0]*10)/10. 
  p=plot(logindep,logdep,'6',$
    ;TITLE='K_S law fitting pix by pix method with Halpha',$
    XTITLE='$log(\Sigma_{total gas})$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$log(\Sigma_{SFR})$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black')
  p2=plot([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*result[0]+const,$
    'r2',/overplot)
  t1=text(0,-13.5,$
    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{total gas})$',$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
  t2=text(0,-14,$
    'N = '+strtrim(string(number,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')

    
END
