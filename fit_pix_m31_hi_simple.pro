pro fit_pix_m31_hi_simple,out
  indep=mrdfits('~/Desktop/project/proms/hi/hi_reproj.fits',0,h_indep)
  dep=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/sfr_fir_reg_hi_sb.fits',0,h_dep)
  mass_one=1.67d-27 ; mass of one HI atom in kg
  size_of_arcsec= 3.4975200d
  pix_size=43.749994d
  ;indep=double(indep)
  ;indep[where(indep ne indep)]=0.00000001
;  dep2=alog10(dep[where (dep GT 0 AND indep GT 0)])
;  indep2=alog10(indep[where (dep GT 0 AND indep GT 0)])
;  Weights=fltarr(n_elements(dep2)-1)+1
;  ;Weights[pos2]*=0.00001d
;  measure_errors = sqrt(1/Weights)
;  result = REGRESS(indep2, dep2, SIGMA=sigma, CONST=const, $
;    MEASURE_ERRORS=measure_errors)
;  PRINT, 'Constant: ', const
;  PRINT, 'Power index N: ', result[*]
;  PRINT, 'Standard errors: ', sigma
;  PRINT, '                                 '
;  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
;  p=plot(indep,dep,'6',$
;    FONT_SIZE = 20,$
;    SYMBOL = 'dot', $
;    SYM_FILLED = 1, $
;    SYM_FILL_COLOR = 'black')
;   p=plot(indep2,dep2,'6',$
;    FONT_SIZE = 20,$
;    SYMBOL = 'dot', $
;    SYM_FILLED = 1, $
;    SYM_FILL_COLOR = 'black')
;    p2=plot([max(indep2),min(indep2)],$
;      [max(indep2),min(indep2)]*result[0]+const,$
;      'r2',/overplot)
  ;------------------------------------------------------
  ;calculate the gas_mass
  ;------------------------------------------------------
  ;convert diameters from pc to cm: 1 pc = 3.086*10^18 cm
  diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
  radii_cm= diam_cm/2d             ;raduis of the region in cm
  gas_vdens= indep/diam_cm     ;volume density of the region in N/cm^3
  vol= (4d*!pi*(radii_cm)^(3d))/3d      ;volume of the regions assume our clouds are spherical
  gas_mass=mass_one*vol*gas_vdens  ;mass of the ISM region in Kg
  mass_sun = 1.9891d30      ;mass of sun is 1.9891 * 10^30kg
  gas_mass_sun = gas_mass/mass_sun ;mass of the ISM regions per mass of sun
  
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
  logdep=double(logdep)
  logindep=double(logindep)
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
  dep=double(dep)
  gas_mass_sun=double(gas_mass_sun)
  FOR i= 0, n_elements(x)-1 DO BEGIN
    FOR j=0, n_elements(y)-1 DO BEGIN
      ;sigma_sfr=N*sigma_gass+const
      ;const=-9.15 result from polyfit for all data
      IF dep[i,j] GE 0 THEN BEGIN
        IF alog10(gas_mass_sun[i,j]) GE 0  THEN BEGIN
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
 ; stop
  ;------------------------------------------------------
  ;ploting
  ;------------------------------------------------------
  
;  Writefits, out,N,h_indep
  ;set_plot_ps,out_fit +'.ps'
  colours
  ;cgplot,logindep,logdep,psym=2,symsize = 0.15, title = 'K_S law fitting pix by pix method with Halpha and HI' ,xtitle='$\Sigma$!Igas!N (M$\sun$pc!E-2!N)',$
   ; ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)'
    ;cgoplot, ([max(logindep),min(logindep)],[max(logindep[pos]),min(logindep[pos])])*result[0]+const,linestyle=0, thick=1,colo=2
    ;endps
  number=Round(result[0]*10)/10.  
  p=plot(logindep,logdep,'6',$
    ;TITLE='K_S law fitting pix by pix method with Halpha',$
    XTITLE='$\Sigma_{HI}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black')
  p2=plot([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*result[0]+const,$
    'r2',/overplot)
  t1=text(-0.8,-12.5,$
    '$log(\Sigma_{SFR,FUV + 24 \mu m}) = const + N \times log(\Sigma_{HI})$',$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
  t2=text(-0.8,-12.8,$
    'N = '+strtrim(string(number,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')

    
END
