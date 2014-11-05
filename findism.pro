;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Find the ISM type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pro findism,gas,mass_one,gas_dense
gas_kind=' '
read,gas_kind,prompt='Is your ISM map COmap,H2 map, HI Map, or total gas map? please type CO, H2, HI, or total:'             
IF gas_kind EQ 'CO' THEN BEGIN
   xfactor=''
   read,xfactor,prompt='Please Inter the X-factor, to convert to H2/cm^2(e.g. 2e20):'
   xfactor=double(xfactor)
   gas_dense = gas*xfactor
   mass_one= 2.34*1.67d-27  ;reduced mass of the H2
ENDIF

IF gas_kind EQ 'H2' THEN BEGIN 
   print, 'Unit of map must be 1/cm^2'
   gas_dens = gas
   mass_one= 2.34*1.67d-27  ;reduced mass of the H2
ENDIF

IF gas_kind EQ 'HI' THEN BEGIN 
   print, 'Unit of map must be 1/cm^2'
   gas_dense = gas
   mass_one= 1.67d-27  ;Mass of the HI
ENDIF

IF gas_kind EQ 'total' THEN BEGIN 
   print, 'Unit of map must be 1/cm^2'
   gas_dense = gas
   read,mass_one,prompt='Please inter mass of your gas in kg. This will be used to compute mass from coloumn density:'
   mass_one=double(mass_one)
ENDIF
END
