pro fit_rad_m31_simple
  ;indep=mrdfits('~/Desktop/proms/m31_co_reproj_rot.fits',0,h_indep)
  indep=mrdfits('/Users/saharrahmani/Desktop/hi/reg_to_hi_idl/co_reg_hi_sb.fits',0,h_indep)
  indep*=2d20
  ;dep=mrdfits('~/Desktop/proms/idl_res/fir_reg_sb.fits',0,h_dep)
  ;dep=mrdfits('~/Desktop/final_before_conv/sfr_halpha_corr_NII_reg_to_co_sb.fits',0,h_dep)
 ; dep=mrdfits('~/Desktop/proms/idl_res/sfr_fuv_reg_co_sb.fits',0,h_dep)
  ; check = mrdfits('/Users/saharrahmani/Desktop/proms/idl_res/halpha_reg_sb.fits',0,h)
  dep=mrdfits('/Users/saharrahmani/Desktop/hi/reg_to_hi_idl/fir_reg_hi_sb.fits',0,h_dep)
  mass_one=3.35d-27
  ;size_of_arcsec= 3.4975200d ;pc
  ; pix_size=7.9999993d ;arcsec
  size_of_arcsec= 3.4975200d
  pix_size=43.749994d
  xc=392.5 ;x value of centre using ds9
  yc= 142.5 ;y value of centre using ds9
  dep[where(dep ne dep)]=0
  indep[where(indep ne indep)]=0
  dep=double(dep)
  indep=double(indep)
  ;------------------------------------------------------
  ;regions based on their dist from centre
  ;------------------------------------------------------
  x = findgen(sxpar(h_indep, 'naxis1')) ; convert FITS to IDL convention
  y = findgen(sxpar(h_indep, 'naxis2'))
  
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
;  stop
  ra=10.724382145
  dec=41.332205842 
  ADXY, h_indep, ra, dec, x_c, y_c       ;Get X and Y corresponding to RA and Dec
  ;GETROT, h_indep, rot, cdelt        ;CDELT gives plate scale degrees/pixel
  ;cdelt = abs( cdelt)*3600.    ;CDELT now in arc seconds/pixel
  DIST_ELLIPSE, ell1,[360,251], x_c, y_c,4.1,38 ;Create a elliptical image mask

 ell = ell1*3600
  pp= contour(indep)
  pp1=contour(ell,/overplot)
;  stop
  ;print, minmax(ell)
  ;contour, ell
;  stop
  good1= where(ell le 1e5);dist_from_centre[1]/size_of_arcsec)
  dep1=dep[good1]
  indep1=gas_mass_sun[good1]
;stop
  good2= where(ell gt 1e5 and ell le 2e5);dist_from_centre[1]/size_of_arcsec and ell le dist_from_centre[2]/size_of_arcsec)
  dep2=dep[good2]
  indep2=gas_mass_sun[good2]
  
  good3= where(ell gt 2e5 and ell le 3e5) ;dist_from_centre[2]/size_of_arcsec and ell le dist_from_centre[3]/size_of_arcsec)
  dep3=dep[good3]
  indep3=gas_mass_sun[good3]
  
  good4= where(ell gt 3e5 and ell le 4e5);dist_from_centre[3]/size_of_arcsec and ell le dist_from_centre[4]/size_of_arcsec)
  dep4=dep[good4]
  indep4=gas_mass_sun[good4]
  
  good5= where(ell gt 4e5 and ell le 5e5);dist_from_centre[4]/size_of_arcsec and ell le dist_from_centre[5]/size_of_arcsec)
  dep5=dep[good5]
  indep5=gas_mass_sun[good5]
  good6= where(ell gt 5e5 and ell le 6e5);dist_from_centre[4]/size_of_arcsec and ell le dist_from_centre[5]/size_of_arcsec)
  dep6=dep[good6]
  indep6=gas_mass_sun[good6]
  
  ;------------------------------------------------------
  ;dep1
  ;------------------------------------------------------
;  zz=0
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[0] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[1] then begin
;        zz+=1
;      endif
;    endfor
;  endfor
;  dep1=fltarr(zz)
;  indep1=fltarr(zz)
;  zz1=0
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[0] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[1] then begin
;        dep1[zz1]=dep[i,j]
;        indep1[zz1]=gas_mass_sun[i,j]
;        zz1+=1
;      endif
;    endfor
;  endfor
;  ;------------------------------------------------------
;  ;dep2
;  ;------------------------------------------------------
;  zz2=0d
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[1] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[2] then begin
;       ; stop
;        zz2+=1d
;      endif
;    endfor
;  endfor
; ; stop
;  dep2=fltarr(zz2)
;  indep2=fltarr(zz2)
;  zz3=0d
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[1] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[2] then begin
;        dep2[zz3]=dep[i,j]
;        indep2[zz3]=gas_mass_sun[i,j]
;        zz3+=1d
;      endif
;    endfor
;  endfor
;  ;------------------------------------------------------
;  ;dep3
;  ;------------------------------------------------------
;  zz4=0d
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[2] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[3] then begin
;        zz4+=1d
;      endif
;    endfor
;  endfor
;  dep3=fltarr(zz4)
;  indep3=fltarr(zz4)
;  zz5=0d
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[2] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[3] then begin
;        dep3[zz5]=dep[i,j]
;        indep3[zz5]=gas_mass_sun[i,j]
;        zz5+=1d
;      endif
;    endfor
;  endfor
;  ;------------------------------------------------------
;  ;dep4
;  ;------------------------------------------------------
;  zz6=0d
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[3] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[4] then begin
;        zz6+=1d
;      endif
;    endfor
;  endfor
;  dep4=fltarr(zz6)
;  indep4=fltarr(zz6)
;  zz7=0d
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[3] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[4] then begin
;        dep4[zz7]=dep[i,j]
;        indep4[zz7]=gas_mass_sun[i,j]
;        zz7+=1d
;      endif
;    endfor
;  endfor
;  ;------------------------------------------------------
;  ;dep5
;  ;------------------------------------------------------
;  zz8=0d
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[4] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[5] then begin
;        zz8+=1d
;      endif
;    endfor
;  endfor
;  dep5=fltarr(zz8)
;  indep5=fltarr(zz8)
;  zz9=0d
;  for i = 0 , n_elements(x)-1 do begin
;    for j = 0 , n_elements(y)-1 do begin
;      if sqrt((i-xc)^2+(j-yc)^2) gt dist_from_centre_pix[4] and sqrt((i-xc)^2+(j-yc)^2) lt dist_from_centre_pix[5] then begin
;        dep5[zz9]=dep[i,j]
;        indep5[zz9]=gas_mass_sun[i,j]
;        zz9+=1d
;      endif
;    endfor
;  endfor
; ;------------------------------------------------------
; ;log of the diff regions
; ;------------------------------------------------------
 logdep1=alog10(dep1[where(dep1 gt 0 and indep1 gt 0)])
 logindep1=alog10(indep1[where(dep1 gt 0 and indep1 gt 0)])
 ;;;;;;;;;;;;;;;;;;;;;;
 logdep2=alog10(dep2[where(dep2 gt 0 and indep2 gt 0)])
 logindep2=alog10(indep2[where(dep2 gt 0 and indep2 gt 0)])
 ;;;;;;;;;;;;;;;;;;;;;;
 logdep3=alog10(dep3[where(dep3 gt 0 and indep3 gt 0)])
 logindep3=alog10(indep3[where(dep3 gt 0 and indep3 gt 0)])
 ;;;;;;;;;;;;;;;;;;;;;;
 logdep4=alog10(dep4[where(dep4 gt 0 and indep4 gt 0)])
 logindep4=alog10(indep4[where(dep4 gt 0 and indep4 gt 0)])
 ;;;;;;;;;;;;;;;;;;;;;;
 logdep5=alog10(dep5[where(dep5 gt 0 and indep5 gt 0)])
 logindep5=alog10(indep5[where(dep5 gt 0 and indep5 gt 0)])
 logdep6=alog10(dep6[where(dep6 gt 0 and indep6 gt 0)])
 logindep6=alog10(indep6[where(dep6 gt 0 and indep6 gt 0)])
; ;;;;;;;;;;;;;;;;;;;;;;
  ;------------------------------------------------------
  ;fit the sfr laws
  ;------------------------------------------------------

  logdep=alog10(dep[where ( dep GT 0 AND gas_mass_sun GT 0 )])
  ;logdep_2=alog10(dep)
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0 )])
 
  ; aa=where(check ne check); and logindep GT -1,count)
  pos=where(logindep GT -0.5)
  Weights=fltarr(n_elements(logdep[pos])-1)+1
  ;pos_e=where(logdep lt -9 and logdep gt -8)
 ; Weights[pos_e]*=0.00001d
  measure_errors = sqrt(1/Weights)
  result = REGRESS(logindep[pos], logdep[pos], SIGMA=sigma, CONST=const, $
    MEASURE_ERRORS=measure_errors)
  PRINT, 'Constant: ', const
  PRINT, 'Power index N: ', result[*]
  PRINT, 'Standard errors: ', sigma
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
;  stop
  ;result = REGRESS(logindep, logdep, SIGMA=sigma, CONST=const, $
  ; MEASURE_ERRORS=measure_errors)
  ;PRINT, 'Constant: ', const
  ; PRINT, 'Power index N: ', result[*]
  ; PRINT, 'Standard errors: ', sigma
  pos1=where(logindep1 GT -5 )
  Weights1=fltarr(n_elements(logdep1[pos1])-1)+1
  ;Weights[pos2]*=0.00001d
  measure_errors1 = sqrt(1/Weights1)
  result1 = REGRESS(logindep1[pos1], logdep1[pos1], SIGMA=sigma1, CONST=const1, $
    MEASURE_ERRORS=measure_errors1)
  PRINT, 'Constant1: ', const1
  PRINT, 'Power index N1: ', result1[*]
  PRINT, 'Standard errors1: ', sigma1
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
  pos2=where(logindep2 GT -5)
  Weights2=fltarr(n_elements(logdep2[pos2])-1)+1
  ;Weights[pos2]*=0.00001d
  measure_errors2 = sqrt(1/Weights2)
  result2 = REGRESS(logindep2[pos2], logdep2[pos2], SIGMA=sigma2, CONST=const2, $
    MEASURE_ERRORS=measure_errors2)
  PRINT, 'Constant2: ', const2
  PRINT, 'Power index N2: ', result2[*]
  PRINT, 'Standard errors2: ', sigma2
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
  pos3=where(logindep3 GT -5)
  Weights3=fltarr(n_elements(logdep3[pos3])-1)+1
  ;Weights[pos2]*=0.00001d
  measure_errors3 = sqrt(1/Weights3)
  result3 = REGRESS(logindep3[pos3], logdep3[pos3], SIGMA=sigma3, CONST=const3, $
    MEASURE_ERRORS=measure_errors3)
  PRINT, 'Constant3: ', const3
  PRINT, 'Power index N3: ', result3[*]
  PRINT, 'Standard errors3: ', sigma3
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
  pos4=where(logindep4 GT -5)
  Weights4=fltarr(n_elements(logdep4[pos4])-1)+1
  ;Weights[pos2]*=0.00001d
  measure_errors4 = sqrt(1/Weights4)
  result4 = REGRESS(logindep4[pos4], logdep4[pos4], SIGMA=sigma4, CONST=const4, $
    MEASURE_ERRORS=measure_errors4)
  PRINT, 'Constant4: ', const4
  PRINT, 'Power index N4: ', result4[*]
  PRINT, 'Standard errors4: ', sigma4
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
  pos5=where(logindep5 GT -5)
  Weights5=fltarr(n_elements(logdep5[pos5])-1)+1
  ;Weights[pos2]*=0.00001d
  measure_errors5 = sqrt(1/Weights5)
  result5 = REGRESS(logindep5[pos5], logdep5[pos5], SIGMA=sigma5, CONST=const5, $
    MEASURE_ERRORS=measure_errors5)
  PRINT, 'Constant5: ', const5
  PRINT, 'Power index N5: ', result5[*]
  PRINT, 'Standard errors5: ', sigma5
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
  pos6=where(logindep6 GT -5)
  Weights6=fltarr(n_elements(logdep6[pos6])-1)+1
  ;Weights[pos2]*=0.00001d
  measure_errors6 = sqrt(1/Weights6)
  result6 = REGRESS(logindep6[pos6], logdep6[pos6], SIGMA=sigma6, CONST=const6, $
    MEASURE_ERRORS=measure_errors6)
  PRINT, 'Constant6: ', const6
  PRINT, 'Power index N6: ', result6[*]
  PRINT, 'Standard errors6: ', sigma6
  PRINT, '                                 '
  PRINT,';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
  ;------------------------------------------------------
  ;ploting
  ;------------------------------------------------------
  
 number=Round(result[0]*10)/10. 
  colours  
 
  p=plot(logindep[pos],logdep[pos],'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR,Fuv}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',xrange=[-5,3]);,vert_colors=bytscl(pix_count), RGB_TABLE=0)
   stop
    p1=plot(logindep1[pos1],logdep1[pos1],'6',SYMBOL = 'dot',SYM_FILLED = 1,SYM_FILL_COLOR = 'red',/overplot)
  p2=plot(logindep2[pos2],logdep2[pos2],'6',SYMBOL = 'dot',SYM_FILLED = 1,SYM_FILL_COLOR = 'blue',/overplot)
  p3=plot(logindep3[pos3],logdep3[pos3],'6',SYMBOL = 'dot',SYM_FILLED = 1,SYM_FILL_COLOR = 'black',/overplot)
  p4=plot(logindep4[pos4],logdep4[pos4],'6',SYMBOL = 'dot',SYM_FILLED = 1,SYM_FILL_COLOR = 'Cyan',/overplot)
  p5=plot(logindep5[pos5],logdep5[pos5],'6',SYMBOL = 'dot',SYM_FILLED = 1,SYM_FILL_COLOR = 'green',/overplot)
  p5=plot(logindep6[pos6],logdep6[pos6],'6',SYMBOL = 'dot',SYM_FILLED = 1,SYM_FILL_COLOR = 'Magenta',/overplot)
  t1=text(0.1,-12.5,$
    '2:red;4:blue;6:black;8:pink;10:green',$
  /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
  t2=text(0.1,-10,$
    'N = '+strtrim(string(number,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    p_f1=plot([max(logindep1[pos1]),min(logindep1[pos1])],$
    [max(logindep1[pos1]),min(logindep1[pos1])]*result1[0]+const1,$
    'r2',/overplot)
    p_f2=plot([max(logindep2[pos2]),min(logindep2[pos2])],$
    [max(logindep2[pos2]),min(logindep2[pos2])]*result2[0]+const2,$
    'b2',/overplot)
    p_f3=plot([max(logindep3[pos3]),min(logindep3[pos3])],$
    [max(logindep3[pos3]),min(logindep3[pos3])]*result3[0]+const3,$
    'k2',/overplot)
    p_f4=plot([max(logindep4[pos4]),min(logindep4[pos4])],$
    [max(logindep4[pos4]),min(logindep4[pos4])]*result4[0]+const4,$
    'c2',/overplot)
    p_f5=plot([max(logindep5[pos5]),min(logindep5[pos5])],$
    [max(logindep5[pos5]),min(logindep5[pos5])]*result5[0]+const5,$
    'g2',/overplot)
    p_f6=plot([max(logindep6[pos6]),min(logindep6[pos6])],$
    [max(logindep6[pos6]),min(logindep6[pos6])]*result6[0]+const6,$
    'm2',/overplot)
    p_f=plot([max(logindep[pos]),min(logindep[pos])],$
    [max(logindep[pos]),min(logindep[pos])]*result[0]+const,$
    'k2',/overplot)
    
    
    
;    stop
  
;  p1=plot([max(logindep[pos]),min(logindep[pos])],$
;    [max(logindep[pos]),min(logindep[pos])]*result[0]+const,$
;    'r2',/overplot)
  
 number1=Round(result1[0]*10)/10.
 p_1=plot(logindep1[pos1],logdep1[pos1],'6',$
  ;TITLE='K_S law fitting pix by pix method with halpha',$
  XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
  YTITLE='$\Sigma_{SFR,Fuv}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
  SYMBOL = 'dot', $
  SYM_FILLED = 1, $
  SYM_FILL_COLOR = 'red',xrange=[-1,1.5],LAYOUT=[3,2,1]);,vert_colors=bytscl(pix_count), RGB_TABLE=0)
  p_f1=plot([max(logindep1[pos1]),min(logindep1[pos1])],$
    [max(logindep1[pos1]),min(logindep1[pos1])]*result1[0]+const1,$
    'r2',/overplot)
;  t_1=text(0.1,-10,$
;    '$log(\Sigma_{SFR,Fuv}) = const + N \times log(\Sigma_{H_{2}})$',$
;    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
;    
  t_c1=text(0.1,-10.5,$
    'N = '+strtrim(string(number1,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    
    number2=Round(result2[0]*10)/10.
  p_2=plot(logindep2[pos2],logdep2[pos2],'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR,Fuv}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'blue',xrange=[-1,1.5],/current,LAYOUT=[3,2,2]);,vert_colors=bytscl(pix_count), RGB_TABLE=0)
  p_f2=plot([max(logindep2[pos2]),min(logindep2[pos2])],$
    [max(logindep2[pos2]),min(logindep2[pos2])]*result2[0]+const2,$
    'b2',/overplot)
;  t_2=text(0.1,-10,$
;    '$log(\Sigma_{SFR,Fuv}) = const + N \times log(\Sigma_{H_{2}})$',$
;    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    
  t_c2=text(0.1,-10.5,$
    'N = '+strtrim(string(number2,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica',LAYOUT=[3,2,2])
    
    
  number3=Round(result3[0]*10)/10.
  p_3=plot(logindep3[pos3],logdep3[pos3],'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR,Fuv}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',xrange=[-1,1.5],/current,LAYOUT=[3,2,3]);,vert_colors=bytscl(pix_count), RGB_TABLE=0)
  p_f3=plot([max(logindep3[pos3]),min(logindep3[pos3])],$
    [max(logindep3[pos3]),min(logindep3[pos3])]*result3[0]+const3,$
    'k2',/overplot)
;  t_3=text(0.1,-10,$
;    '$log(\Sigma_{SFR,Fuv}) = const + N \times log(\Sigma_{H_{2}})$',$
;    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
;    
  t_c3=text(0.1,-10.5,$
    'N = '+strtrim(string(number3,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    
    
  number4=Round(result4[0]*10)/10.
  p_4=plot(logindep4[pos4],logdep4[pos4],'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR,Fuv}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'Cyan',xrange=[-1,1.5],/current,LAYOUT=[3,2,4]);,vert_colors=bytscl(pix_count), RGB_TABLE=0)
  p_f4=plot([max(logindep4[pos4]),min(logindep4[pos4])],$
    [max(logindep4[pos4]),min(logindep4[pos4])]*result4[0]+const4,$
    'c2',/overplot)
;  t_4=text(0.1,-10,$
;    '$log(\Sigma_{SFR,Fuv}) = const + N \times log(\Sigma_{H_{2}})$',$
;    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
;    
  t_c4=text(0.1,-10.5,$
    'N = '+strtrim(string(number4,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    
    
  number5=Round(result5[0]*10)/10.
  p_5=plot(logindep5[pos5],logdep5[pos5],'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR,Fuv}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'green',xrange=[-1,1.5],/current,LAYOUT=[3,2,5]);,vert_colors=bytscl(pix_count), RGB_TABLE=0)
  p_f5=plot([max(logindep5[pos5]),min(logindep5[pos5])],$
    [max(logindep5[pos5]),min(logindep5[pos5])]*result5[0]+const5,$
    'g2',/overplot)
;  t_5=text(0.1,-10,$
;    '$log(\Sigma_{SFR,Fuv}) = const + N \times log(\Sigma_{H_{2}})$',$
;    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    
  t_c5=text(0.1,-10.5,$
    'N = '+strtrim(string(number5,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
    
    
  number6=Round(result6[0]*10)/10.
  p_6=plot(logindep6[pos6],logdep6[pos6],'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR,Fuv}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'Magenta',xrange=[-1,1.5],/current,LAYOUT=[3,2,6]);,vert_colors=bytscl(pix_count), RGB_TABLE=0)
  p_f6=plot([max(logindep6[pos6]),min(logindep6[pos6])],$
    [max(logindep6[pos6]),min(logindep6[pos6])]*result6[0]+const6,$
    'm2',/overplot)
;  t_6=text(0.1,-10,$
;    '$log(\Sigma_{SFR,Fuv}) = const + N \times log(\Sigma_{H_{2}})$',$
;    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')
;    
  t_c6=text(0.1,-10.5,$
    'N = '+strtrim(string(number6,format='(f20.1)'),2),$
    /DATA, FONT_SIZE=12, FONT_NAME='Helvetica')

END