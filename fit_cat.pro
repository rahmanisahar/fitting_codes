;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fitting Using catalougue 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pro fit_cat,out_cat_phot, out_fit,indep2
indep=mrdfits('/Users/saharrahmani/Desktop/fiiting/conv_to_23/test_sfr_law/m31_co_tan_rot_cut.fits',0,h_indep)  
dep=mrdfits('/Users/saharrahmani/Desktop/fiiting/conv_to_23/test_sfr_law/sfr_fir_reg_to_co_scaled.fits',0,h_dep)
cat=mrdfits('/Users/saharrahmani/Desktop/fiiting/conv_to_23/test_sfr_law/HIIcat_mohad_complete.fits',1)
mass_one= 2.34*1.67d-27  
  ; read, cat_file, prompt='please inter a catalouge which containe RA,DEC, luminocity in erg/s and radius of region in parsec(diam):'
  ; cat=mrdfits(cat_file,1)
npar = N_params()
IF npar EQ 7 THEN print,'unit of the stellar mass must be per mass of sun'
;h_indep is a header of the independat map
;------------------------------------------------------
;calculate the pix_size of the images
;------------------------------------------------------
find_the_pixel_size, h_indep,pix_size ;find the pixel size in arcsec
;------------------------------------------------------
;Find the position of apr
;------------------------------------------------------
extast, h_indep, ast     ;extract astrometry
ad2xy, cat.RA, cat.DEC, ast, x, y   ; converting ra,dec to x,y
;------------------------------------------------------
;Find how many parsecs correspond to one arcsec in distance of the galaxy
;------------------------------------------------------
find_arcsec_in_pc,size_of_arcsec
;------------------------------------------------------
;Find the size of apr
;------------------------------------------------------
Diam = cat.Diam
lum = cat.LUM
radii = Diam[where(Diam GT size_of_arcsec*pix_size*2 )]/2d
radii_arcsec= radii/size_of_arcsec  ; radii of photometry to arcsec
radii_pix= radii_arcsec/pix_size   ; radii of photemetry in pixels
;stop
;------------------------------------------------------
;Do some photometry  
;------------------------------------------------------
x=x[where(Diam GT size_of_arcsec*pix_size*2 )]
y=y[where(Diam GT size_of_arcsec*pix_size*2 )]
;indep_phot=dblarr(n_elements(x))
;edep=dblarr(n_elements(x))
;eindep=dblarr(n_elements(x))
;dep_phot=dblarr(n_elements(x))
;FOR i=0, n_elements(x)-1 DO BEGIN
 ;  dist_circle, area_for_phot, radii_pix[i], x[i], y[i]  ;Create a distance circle image
  ; indep_phot[i]=total(indep[area_for_phot],/nan)
   ;dep_phot[i]=total(dep[area_for_phot],/nan)
;ENDFOR
;IF npar EQ 7 THEN BEGIN
 ;  indep2_phot=dblarr(n_elements(x))
  ; FOR i=0, n_elements(x)-1 DO BEGIN
   ;   dist_circle, area_for_phot, radii_pix[i], x[i], y[i]  ;Create a distance circle image
    ;  indep_phot[i]=total(indep[area_for_phot])
     ; dep_phot[i]=total(dep[area_for_phot])
      ;indep2_phot[i]=total(dep[area_for_phot])
 ;  ENDFOR
;ENDIF
;indep_phot_aper=dblarr(n_elements(x))
;dep_phot_aper=dblarr(n_elements(x))
;eindep_aper=dblarr(n_elements(x))
;edep_aper=dblarr(n_elements(x))
;FOR i=0, n_elements(x)-1 DO BEGIN

;skyrad = [[radii_pix],[(radii_pix+1)]]
;skyrad = dblarr(2,128)
skyrad = [[radii_pix],[radii_pix+1]]
skyrad=transpose(skyrad)
stop
For i = 0 , n_elements(x)-1,1 DO BEGIN
   aper,indep,x[i],y[i],indep_phot_aper,eindep_aper,$
     sky, skyerr, 1, radii_pix[i], skyrad[*,i], /exact,/nan ;,setsky = 0 ;Do the photometry using aper.pro for independet data


;aper, dep, x,y,dep_phot_aper,edep_aper, sky, skyerr, 1,$
 ;     radii_pix,skyrad,/exact,/flux,/nan;,setsky= 0 ; Do the photomery using aper.pro for dependet data
ENDFOR

;IF npar EQ 7 THEN BEGIN
 ;  aper,indep2, x,y,indep2_phot_aper,eindep2,sky,skyerr, 1, radii_pix,/flux,/nan ;Do the photometry using aper.pro for second independet data
;ENDIF
;stop
;------------------------------------------------------
;calculate the gas_mass
;------------------------------------------------------
;convert diameters from pc to cm: 1 pc = 3.086*10^18
diam_cm=cat.Diam*3.086d18   ;Diameter of the region in cm
radii_cm= diam_cm/2d             ;raduis of the region in cm
gas_vdens=indep_phot/diam_cm     ;volume density of the region in N/cm^3
vol= 4d*!pi*(radii_cm)^3/3d      ;volume of the regions assume our clouds are spherical
gas_mass=mass_one*vol*gas_vdens  ;mass of the ISM region in Kg
mass_sun = 1.9891d30      ;mass of sun is 1.9891 * 10^30kg
gas_mass_sun = gas_mass/mass_sun ;mass of the ISM regions per mass of sun 
;------------------------------------------------------
;calculate the surface density
;------------------------------------------------------
area = 4*!pi*(radii)^(2d)     ;in pc^2
sigma_dep= dep_phot/area      ;unit of dependet map per pc^2
sigma_indep= indep_phot/area  ;unit of independate map per pc^2
sigma_gas= gas_mass_sun/area  ;gas surface density in mass per mass of sun per pc^2

IF npar EQ 7 THEN sigma_indep2= indep2_phot/area  ;unit of independate map2 per pc^2
;------------------------------------------------------
;fit the sfr laws 
;------------------------------------------------------
; K_S law is sigma_sfr=A*sigma_gass^N
; ES law is sigma_sfr=A*sigma_gass^N*sigma_stars^B
; one can take the logarithm from both side and have a
; log(sigma_sfr)=N*log(sigma_gass) + const
; log(sigma_sfr)=B*log(sigma_stars) + const
;we use IDL regress routin to fit the line
logdep=alog10(sigma_dep[where(sigma_gas GT 0)])
logindep=alog10(sigma_gas[where(sigma_gas GT 0)])
stop
IF npar EQ 7 THEN BEGIN
   logindep2= alog10(sigma_indep2)
   Weights1=fltarr(n_elements(logdep)-1)+1
   measure_errors1 = sqrt(1/Weights1)
   result1 = REGRESS(logindep, logdep, SIGMA=sigma1, CONST=const1, $ 
                    CHISQ=chisq, MEASURE_ERRORS=measure_errors1) 
   PRINT, 'Constant: ', const1 
   PRINT, 'Power index N for gass: ', result1[*] 
   PRINT, 'Standard errors: ', sigma1
   PRINT, 'Chi square: ', chisq
  
   Weights2=fltarr(n_elements(logdep)-1)+1
   measure_errors2 = sqrt(1/Weights2)
   result2 = REGRESS(logindep2, logdep, SIGMA=sigma2, CONST=const2, $ 
                    CHISQ=chisq, MEASURE_ERRORS=measure_errors2) 
   PRINT, 'Constant: ', const2 
   PRINT, 'Power index B for stellar mass: ', result2[*] 
   PRINT, 'Standard errors: ', sigma2
   PRINT, 'Chi square: ', chisq

   logindep2=alog10(sigma_indep2)
   x=[logindep,logdep]
   Weights=fltarr(n_elements(logdep)-1)+1
   measure_errors = sqrt(1/Weights)
   result = REGRESS(logindep, logdep, SIGMA=sigma, CONST=const, $ 
                    CHISQ=chisq, MEASURE_ERRORS=measure_errors) 
   PRINT, 'Constant: ', const 
   PRINT, 'Powerindex N and B : ', result[*] 
   PRINT, 'Standard errors: ', sigma
   PRINT, 'Chi square: ', chisq
ENDIF ELSE BEGIN
   Weights=fltarr(n_elements(logdep)-1)+1
   measure_errors = sqrt(1/Weights)
   result = REGRESS(logindep, logdep, SIGMA=sigma, CONST=const, $ 
                    CHISQ=chisq, MEASURE_ERRORS=measure_errors) 
   PRINT, 'Constant: ', const 
   PRINT, 'Power index N: ', result[*] 
   PRINT, 'Standard errors: ', sigma
   PRINT, 'Chi square: ', chisq
   result_poly = POLY_FIT(logindep, logdep, 1, MEASURE_ERRORS=measure_errors, $
                          SIGMA=sigma_poly)
   PRINT, 'Constant FROM POLYFIT:', result_poly[0]
   PRINT, 'POWER index From POLYFIT:', result_poly[1]
   PRINT, ' Standard errors from POLYFIT:' , sigma_poly
ENDELSE
myfunc='logfit'
start=[0.6,10d-9]
xx=sigma_gas[where(sigma_gas GT 0)]
yy=sigma_dep[where(sigma_gas GT 0)]
weights1=fltarr(n_elements(yy))+1
sigy=sqrt(1/Weights1)
res=mpfitfun(myfunc,xx,yy,sigy,start)
print, res
stop

;------------------------------------------------------
;make a new catalougue using photomery results
;------------------------------------------------------
IF npar EQ 7 THEN BEGIN
   get_lun, unit
   openw, unit, out_cat_phot+'.txt'
   FOR i=0, n_elements(x)-1 DO printf, unit, x[i], y[i],radii[i], sigma_gas[i],sigma_dep[i],sigma_indep2[i]
   close, unit
   free_lun, unit

   data = {X:0., Y:0.0, radii:0.,sigma_gas:0.0,sigma_sfr:0.0,sigma_star:0.0}
   datas = replicate(data, n_elements(x))
   datas.X = x
   datas.Y = y
   datas.radii = radii
   datas.sigma_gas= sigma_gas
   datas.sigma_sfr=sigma_dep
   datas.sigma_star=sigma_indep2
   mwrfits,datas, out_cat_phot+'.fits', /create
ENDIF ELSE BEGIN

   get_lun, unit
   openw, unit, out_cat_phot+'.txt'
   FOR i=0, n_elements(x)-1 DO printf, unit, x[i], y[i], radii[i], sigma_gas[i],sigma_dep[i]
   close, unit
   free_lun, unit

   data = {x:0., y:0.0, radii:0.,sigma_gas:0.0,sigma_sfr:0.0}
   datas = replicate(data, n_elements(x))
   datas.x = x
   datas.y = y
   datas.radii = radii
   datas.sigma_gas= sigma_gas
   datas.sigma_sfr=sigma_dep
   mwrfits,datas, out_cat_phot+'.fits', /create
ENDELSE

;------------------------------------------------------
;ploting
;------------------------------------------------------
IF npar EQ 7 THEN BEGIN
   set_plot_ps,out_fit +'.ps'
   colours
   cgplot,logindep,logdep,psym=2,symsize = 0.15, title = 'ES law fitting using catalougue of region for gas' ,xtitle='$\Sigma$!Igas!N (M$\sun$pc!E-2!N)',ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)' 
   cgoplot, [min(logindep),max(logindep)]*result1[0]+const1, linestyle=0, thick=1,colo=2
   cgplot,logindep2,logdep,psym=2,symsize = 0.15, title = 'ES law fitting using catalougue of region for stars' ,xtitle='$\Sigma$!Istar!N (M$\sun$pc!E-2!N)',$
          ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)'
   cgoplot, [max(logindep2),min(logindep2)]*result2[0]+const2,logdep, linestyle=0, thick=1,colo=2
   endps

   p=plot(logindep,logdep,'6',$
       TITLE='ES law fitting using catalougue of region for gas',$
       XTITLE='$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
       YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
       FONT_SIZE = 20,$
       SYMBOL = 'circle', $
       SYM_FILLED = 1, $
       SYM_FILL_COLOR = 'gold')
   p2=plot([min(logindep),max(logindep)]*result1[0]+const,logdep,'r2',/overplot)
   t1=text(logindep[10],logdep[10]+4,$
        '$log(\Sigma_{SFR}) = cont+N*log(\Sigma_{gas})$',$
         /DATA, FONT_SIZE=14, FONT_NAME='Helvetica')

    p3=plot(logindep2,logdep,'6',$
       TITLE='ES law fitting using catalougue of region for stars',$
       XTITLE='$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
       YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
       FONT_SIZE = 20,$
       SYMBOL = 'circle', $
       SYM_FILLED = 1, $
       SYM_FILL_COLOR = 'gold')
   p4=plot([min(logindep2),max(logindep2)]*result2[0]+const,logdep,'g2',/overplot)
   t2=text(logindep2[10],logdep[10]+4,$
        '$log(\Sigma_{SFR}) = cont+B*log(\Sigma_{star})$',$
         /DATA, FONT_SIZE=14, FONT_NAME='Helvetica')
ENDIF ELSE BEGIN
   set_plot_ps,out_fit +'.ps'
   colours
   cgplot,logindep,logdep,psym=2,symsize = 0.15, title = 'K-S law fitting using catalougue of region' ,xtitle='$\Sigma$!Igas!N (M$\sun$pc!E-2!N)',ytitle='$\Sigma$!ISFR!N (M$\sun$ yr!E-1!Npc!E-2!N)' 
   cgoplot, [min(logindep),max(logindep)]*result[0]+const,linestyle=0, thick=1,colo=2
   endps

   p=plot(logindep,logdep,'6',$
       TITLE='K-S law fitting using catalougue of region',$
       XTITLE='$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
       YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
       FONT_SIZE = 20,$
       SYMBOL = 'circle', $
       SYM_FILLED = 1, $
       SYM_FILL_COLOR = 'gold')
   p2=plot(logindep,[min(logindep),max(logindep)]*result[0]+const,'r2',/overplot)
   t1=text(logindep[10],logdep[10]+4,$
        '$log(\Sigma_{SFR}) = cont+N*log(\Sigma_{gas})$',$
         /DATA, FONT_SIZE=14, FONT_NAME='Helvetica')
ENDELSE

END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;logfit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
function logfit,xx,A
index=A[0]
return, A[1]*xx^index
END
