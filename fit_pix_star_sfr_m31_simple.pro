pro fit_pix_star_sfr_m31_simple

  dep=mrdfits('~/Desktop/final_before_conv/sfr_halpha_corr_NII_reg_to_co_sb.fits',0,h_dep)
  
  indep=mrdfits('/Users/saharrahmani/Desktop/proms/idl_res/mass_reg_sb.fits',0,h_indep)
  ; mass_one=2.34d*1.67d-27
  size_of_arcsec= 3.4975200d
  pix_size=7.9999993d
  diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
  radii_cm= diam_cm/2d
  
  radii_pc=radii_cm/(3.086d18)
   area = 4*!pi*(radii_pc)^(2d)  ;in pc^2
  ;area=1d
  dep= dep/area      ;unit of dependet map per pc^2
  indep= indep/area  ;unit of independate map per pc^2
  
  ;------------------------------------------------------
  ;fit the sfr laws
  ;------------------------------------------------------
  logdep=alog10(dep[where (dep GT 0 AND indep GT 0)])
  logindep=alog10(indep[where (dep GT 0 AND indep GT 0)])
  
  
  pos=where(logindep GT min(logindep))
  ;indep_both=[logindep[pos], logstar[pos]]
  pos2=where(logindep LT -1.5)
  Weights=fltarr(n_elements(logdep)-1)+1
  Weights[pos2]*=0.00001d
  measure_errors = sqrt(1/Weights)
  result = REGRESS(logindep[pos], logdep[pos], SIGMA=sigma, CONST=const, $
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
      IF dep[i,j] GT 0.0 THEN BEGIN
         IF indep[i,j] GT 0.0  THEN BEGIN
            N[i,j] = (alog10(dep[i,j])-const)/alog10(indep[i,j])
         ENDIF ELSE BEGIN
            N[i,j]=!VALUES.F_NAN
         ENDELSE
      ENDIF ELSE BEGIN
         N[i,j]=!VALUES.F_NAN
      ENDELSE
   ENDFOR
ENDFOR

  print, 'avg N: ' ,avg(N,/nan)
;  stop
  ;------------------------------------------------------
  ;ploting
  ;------------------------------------------------------
;   set_plot_ps,out_fit +'.ps'
;   colours
;   cgplot,logindep[pos],logdep[pos],psym=2,symsize = 0.15, title = 'E_S law fitting pix by pix method with halpha' ,xtitle='$\Sigma$!Istar!N (M$\sun$pc!E-2!N)',$
;          ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)'
;   ;cgoplot, ([max(logindep[pos]),min(logindep[pos])],[max(logindep[pos]),min(logindep[pos])])*result[0]+const,linestyle=0, thick=1,colo=2
;   endps

 ; writefits,out,N
  number=Round(result[0]*10)/10. 
  p=plot(logindep[pos],logdep[pos],'6',$
   ; TITLE='E_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{*}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    FONT_SIZE = 20,$
    SYMBOL = 'star', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold')
  p2=plot([max(logindep[pos]),min(logindep[pos])],$
    [max(logindep[pos]),min(logindep[pos])]*result[0]+const,$
    'r2',/overplot)
  t1=text(1.8,-13,$
    '$log(\Sigma_{SFR,H\alpha}) = const + \beta \times log(\Sigma_{*})$',$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    t2=text(1.8,-13.5,$
    '$\beta$ = '+strtrim(string(number,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    
END
