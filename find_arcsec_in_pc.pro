;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Find how many parsecs correspond to one arcsec in distance of the galaxy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pro find_arcsec_in_pc,size_of_arcsec
read, dist,prompt='Inter distance of the galaxy in parsec( e.g. for galaxy in distance 0.78Mpc write 0.78d6) :'
dist=double(dist)
;1'' is equavalant with 4.848 microrad
size_of_arcsec=4.484d-6*dist
print, '1 arcsec is equal to '+strtrim(size_of_arcsec,2)+' parsec in the given distance'
;For example in distance of Andromeda each arcsec is equal to 3.78pc 
END
