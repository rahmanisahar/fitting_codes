;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;KS_law
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pro KS_law
sfr_file=' '
read, sfr_file, prompt='please inter the SFR file_name:'    ;asking for sfr_file name
print, 'Unit of SFR map must be in mass of sun per year'
sfr=mrdfits(sfr_file,0,h_sfr)        ; reading SFR file
gas_file=' '
read, gas_file, prompt='please inter ISM file_naem:'        ; asking for the psf_file name'
gas=mrdfits(gas_file,0,h_gas)        ; reading gas file

read, psf_sfr, prompt='Please inter PSF of the SFR MAP(in arecsec):'
read, psf_gas, prompt='Please inter PSF of the ISM MAP(in arecsec):'
;checking if the maps need to be convolved or not, if yes do the
;convolution, change the pixel size and scales
IF psf_sfr EQ psf_gas THEN print, 'You do not need to do any convolution'

IF psf_sfr NE psf_gas THEN BEGIN
   print, 'Maps resolutions are not the same'
   print, 'We are going to convolve them'
   print, 'After convolving we will change the pixel size and scale in order both maps have the same pixcel size and scal'
   print, 'To Do so, we use the Aniano convolution package'
   print, 'Yoou need to download the package from http://www.astro.princeton.edu/~ganiano/Kernels.html '
   IF psf_sfr GT psf_gas THEN BEGIN
      print, 'ISM map needs to be smoothed from resolution '+strtrim(psf_gas,2)+'arcsec to resolution '+strtrim(psf_sfr,2)+'arcsec'
      ker_file=' '
      read,ker_file,prompt='please inter the kernel file name for convoloutin from resultion '+strtrim(psf_gas,2)+'arcsec to resolution '+strtrim(psf_sfr,2)+'arcsec:'
      ker=mrdfits(ker_file,0,ker_hd)
      yn=' '
      read,yn,prompt='Do you want to save an adjusted kernel:(Y for yes and N for no)'
      IF yn EQ 'Y' THEN BEGIN
         do_the_convolution,gas,h_gas,ker,ker_hd,result_image,result_header,$
                            result_kernel_image,result_kernel_header,1,1
         writefits,'convolved_'+gas_file,result_image,result_header
         oldim=mrdfits('convolved_'+gas_file,0,oldhd)
         print,'now we have the same resolution we should have the same pixel size and scale too!'
         print,'also centre of out images must be the same'
         print,'we are going to change the size and pixel scale and centre of image and save the new one as registered+filename'
         hastrom, oldim,oldhd,newim,newhd,h_sfr     ;inorder to have all images in the same scales
         writefits,'registered_'+gas_file,newim,newhd
         gas=mrdfits('registered_'+gas_file,0,h_gas)
      ENDIF ELSE BEGIN 
         IF yn EQ 'N' THEN BEGIN
            do_the_convolution,gas,h_gas,ker,ker_hd,result_image,result_header,$
                            result_kernel_image,result_kernel_header,1
            writefits,'convolved_'+gas_file,result_image,result_header
            oldim=mrdfits('convolved_'+gas_file,0,oldhd)
            print,'now we have the same resolution we should have the same pixel size and scale too!'
            print,'also centre of out images must be the same'
            print,'we are going to change the size and pixel scale and centre of image and save the new one as registered+filename'
            hastrom, oldim,oldhd,newim,newhd,h_sfr ;inorder to have all images in the same scales
            writefits,'registered_'+gas_file,newim,newhd
            gas=mrdfits('registered_'+gas_file,0,h_gas)
         ENDIF
      ENDELSE
   ENDIF 

   IF psf_gas GT psf_sfr THEN BEGIN
      print, 'SFR map needs to be smoothed from resolution '+strtrim(psf_sfr,2)+'arcsec to resolution '+strtrim(psf_gas,2)+'arcsec'
      ker_file=' '
      read,ker_file,prompt='please inter the kernel file name for convoloutin from resultion '+strtrim(psf_sfr,2)+'arcsec to resolution '+strtrim(psf_gas,2)+'arcsec:'
      ker=mrdfits(ker_file,0,ker_hd)
      yn=' '
      read,yn,prompt='Do you want to save an adjusted kernel:(Y for yes and N for no)'
      IF yn EQ 'Y' THEN BEGIN
         do_the_convolution,sfr,h_sfr,ker,ker_hd,result_image,result_header,$
                            result_kernel_image,result_kernel_header,1,1
         writefits,'convolved_'+sfr_file,result_image,result_header
         print,'now we have the same resolution we should have the same pixel size and scale too!'
         print,'also centre of out images must be the same'
         print,'we are going to change the size and pixel scale and centre of image and save the new one as registered+filename'
         oldim=mrdfits('convolved_'+sfr_file,0,oldhd)
         hastrom, oldim,oldhd,newim,newhd,h_gas       ;inorder to have all images in the same scales
         writefits,'registered_'+sfr_file,newim,newhd
         sfr=mrdfits('registered_'+sfr_file,0,h_sfr)
      ENDIF ELSE BEGIN 
         IF yn EQ 'N' THEN BEGIN
            do_the_convolution,sfr,h_sfr,ker,ker_hd,result_image,result_header,$
                            result_kernel_image,result_kernel_header,1
            writefits,'convolved_'+sfr_file,result_image,result_header
            oldim=mrdfits('convolved_'+sfr_file,0,oldhd)
            hastrom, oldim,oldhd,newim,newhd,h_gas ;inorder to have all images in the same scales
            writefits,'registered_'+sfr_file,newim,newhd
            sfr=mrdfits('registered_'+sfr_file,0,h_sfr)
         ENDIF
      ENDELSE
   ENDIF

ENDIF ELSE BEGIN 
   IF psf_sfr EQ psf_gas THEN BEGIN
      print, 'Please Note that your maps must have the same pixel size and scale'
   ENDIF
ENDELSE


;------------------------------------------------------
; find the type of ISM map
;------------------------------------------------------
findism,gas,mass_one,gas_dens
;help, gas_dens
;help,mass_one
;------------------------------------------------------   
;fitting
;------------------------------------------------------
Print,'which method of fittinf do you want to use?'
which=' '
read,which,prompt='which method of fitting do you want to use? (cat for using catalouge, pix for pixcel by pixel fitting, and bright for using area for bright regions in your SFR map):'   
IF which EQ 'cat' THEN BEGIN
   print, 'Unit of SFR map must be in mass of sun per year'
   print, 'Unit of Gass map mus be in N/cm^2'
   out_cat_phot=' '
   read,out_cat_phot,prompt='Inter name of the output catalougue which contains surface density e.g. ''K_S_Law_cat'':'
   out_fit= ' '
   read,out_fit,prompt=' Inter name of the output result e.g. ''K_S_law'':'
   fit_cat, gas_dens,h_gas,sfr,mass_one=mass_one,out_cat_phot,out_fit
ENDIF

IF which EQ 'pix' THEN BEGIN
   print, 'Unit of SFR map must be in mass of sun per year'
   print, 'Unit of Gass map mus be in N/cm^2'
   out_fit= ' '
   read,out_fit,prompt=' Inter name of the output result e.g. ''K_S_law'':'
   fit_pix,gas_dens,h_gas,sfr,mass_one=mass_one,out_fit
ENDIF

IF which EQ 'bright' THEN BEGIN
   print, 'Unit of SFR map must be in mass of sun per year'
   print, 'Unit of Gass map mus be in N/cm^2'
   out_fit= ' '
   read,out_fit, prompt='Inter name of the output result e.g. ''K_S_law'':'
   read,percent, prompt='Inter percentage of total luminocity that your bright regin have:'
   percent=double(percent)
   read,radii, prompt='Inter radius of your region around prigth sources in PC:'
   radii=double(radii)
   fit_bright,gas_dens,h_gas,sfr,mass_one=mass_one,percent,radii,out_fit
ENDIF
END
