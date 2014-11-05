;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Find the pixel size
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pro find_the_pixel_size, h_indep,pix_size
; your catalougue must contain the RA, DEC and diameter columns
extast, h_indep, ast                  ;extract astrometr

pix_scale, h_indep, pix_size_degree ;pix_size_degree is in unit of degree/pix

pix_size = pix_size_degree*3600.0d   ;pix_size is in unit of arcsec 
print,'pixel size is equal '+strtrim(pix_size,1) + 'arcsec'
;print, pix_size ,  pix_size1
IF pix_size le 0 THEN BEGIN
   print,'There is no astromety provided'
   read, pix_size, prompt='inter pixel size in arcsec'
   pix_size=double(pix_size)
ENDIF
END
