pro fit_pix_m31_simple
  indep=mrdfits('~/Desktop/project/proms/h2/m31_co_reproj_rot.fits',0,h_indep)
 ; indep=mrdfits('/Users/saharrahmani/Desktop/hi/reg_to_hi_idl/co_reg_hi_sb.fits',0,h_indep)
  ;indep=mrdfits('~/Desktop/proms/to_36/co_reg_36_sb.fits',0,h_indep)
  indep*=2d20
 ; dep=mrdfits('~/Desktop/project/proms/h2/reg_to_co/sfr_fuv_hao_reg_co_sb.fits',0,h_dep)
   dep=mrdfits('~/Desktop/project/proms/h2/reg_to_co/sfr_fir_reg_co_sb.fits',0,h_dep)
  ;dep=mrdfits('~/Desktop/final_before_conv/sfr_halpha_corr_NII_reg_to_co_sb.fits',0,h_dep)
 ; check = mrdfits('/Users/saharrahmani/Desktop/proms/idl_res/halpha_reg_sb.fits',0,h)
 ;err_sfr=mrdfits('~/Desktop/project/proms/h2/reg_to_co/err_sfr_reg_co_sb.fits',0)
 err_sfr=mrdfits('~/Desktop/project/proms/h2/reg_to_co/err_sfr_fir_reg_co_sb.fits',0)
 stop
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
 err_sfr/=area
  ;------------------------------------------------------
  ;fit the sfr laws
  ;------------------------------------------------------ 
  logdep=alog10(dep[where ( dep GT 0 AND gas_mass_sun GT 0 )])
  logdep2=alog10(dep)
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0 )])
  dep2 = dep[where (dep GT 0 AND gas_mass_sun GT 0)]
   err_sfr_f = abs(err_sfr/(alog(10)*dep2))
 ; aa=where(check ne check); and logindep GT -1,count)
 pos=where(logindep GT -1)

;  logdep=logdep[pos]
;  logindep=logindep[pos]
;  dev_sfr=stddev(logdep)
;  dev_gas=stddev(logindep)
;  len=n_elements(logindep)
;  err_sfr = dev_sfr*(RANDOMu(seed, len, POISSON=1.0, /DOUBLE)-1.0+1d-14)
;  err_gas = dev_gas*(RANDOMu(seed, len, POISSON=1.0, /DOUBLE)-1.0+1d-14)
;  err_sfr*=logdep
;  err_gas*=logindep
;  index=intarr(len)+31
Weights=err_sfr_f[pos]
measure_errors = sqrt(1/abs(Weights))
  result = REGRESS(logindep[pos], logdep[pos], SIGMA=sigma, CONST=const, $
    MEASURE_ERRORS=measure_errors)
  PRINT, 'Constant: ', const
  PRINT, 'Power index N: ', result[*]
  PRINT, 'Standard errors: ', sigma
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
  stop
  ;result = REGRESS(logindep, logdep, SIGMA=sigma, CONST=const, $
   ; MEASURE_ERRORS=measure_errors)
  ;PRINT, 'Constant: ', const
 ; PRINT, 'Power index N: ', result[*]
 ; PRINT, 'Standard errors: ', sigma
 
; stop
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
      IF alog10(gas_mass_sun[i,j]) GT -1.5  THEN BEGIN
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
;stop
;------------------------------------------------------
;ploting
;------------------------------------------------------
;Writefits, out,N
;set_plot_ps,out_fit +'.ps'
colours
;cgplot,logindep[pos],logdep[pos],psym=2,symsize = 0.15, title = 'K_S law fitting pix by pix method with halpha and H2' ,xtitle='$\Sigma$!Igas!N (M$\sun$pc!E-2!N)',$
 ;ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)'
  ;cgoplot, ([max(logindep[pos]),min(logindep[pos])],[max(logindep[pos]),min(logindep[pos])])*result[0]+const,linestyle=0, thick=1,colo=2
  ;endps
  number=Round(result[0]*10)/10.
p=plot(logindep[pos],logdep[pos],'6',$
  ;TITLE='K_S law fitting pix by pix method with halpha',$
  XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
  YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
  FONT_SIZE = 20,$
  SYMBOL = 'dot', $
  SYM_FILLED = 1, $
 SYM_FILL_COLOR = 'black');,vert_colors=bytscl(pix_count), RGB_TABLE=0)
 ;cbar = COLORBAR(rgb_table=0, ORIENTATION = 1)
 ;p2=plot(logindep[aa],logdep[aa],'6',$
       ; SYMBOL = '+', $
;        SYM_FILLED = 1, $
;        SYM_FILL_COLOR = 'red',/overplot)
p1=plot([max(logindep[pos]),min(logindep[pos])],$
        [max(logindep[pos]),min(logindep[pos])]*result[0]+const,$
        'r2',/overplot)
t1=text(-0.3,-10,$
  '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
  
  ;print, number,format='(f20.1)'
 ; stop
 t2=text(-0.3,-10.5,$
  'N = '+strtrim(string(number,format='(f20.1)'),2),$
  /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
  
  ;stop
 ; h2d = HIST_2D(logindep[pos],logdep[pos])
 ; ct = COLORTABLE(0, /REVERSE)
  ;p0 = IMAGE(h2d, RGB_TABLE=ct, AXIS_STYLE=2, MARGIN=0.1)
  ;cbar = COLORBAR(TARGET = p0, ORIENTATION = 1)
  END