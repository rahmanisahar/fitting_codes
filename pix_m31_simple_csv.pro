pro pix_m31_simple_csv
  indep=mrdfits('~/Desktop/project/proms/h2/m31_co_reproj_rot.fits',0,h_indep)
  ; indep=mrdfits('/Users/saharrahmani/Desktop/hi/reg_to_hi_idl/co_reg_hi_sb.fits',0,h_indep)
  ;indep=mrdfits('~/Desktop/proms/to_36/co_reg_36_sb.fits',0,h_indep)
  indep*=2d20
  dep=mrdfits('~/Desktop/project/proms/h2/reg_to_co/sfr_fuv_reg_co_sb.fits',0,h_dep)
  ; dep=mrdfits('/Users/saharrahmani/Desktop/hi/reg_to_hi_idl/fir_reg_hi_sb.fits',0,h_dep)
  ;dep=mrdfits('~/Desktop/final_before_conv/sfr_halpha_corr_NII_reg_to_co_sb.fits',0,h_dep)
  ; check = mrdfits('/Users/saharrahmani/Desktop/proms/idl_res/halpha_reg_sb.fits',0,h)
  
  ;stop
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
  ;------------------------------------------------------
  ;make error files
  ;------------------------------------------------------
  logdep=alog10(dep[where ( dep GT 0 AND gas_mass_sun GT 0 )])
  logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0 )])
  ; aa=where(check ne check); and logindep GT -1,count)
  pos=where(logindep GT -1)
  logdep=logdep[pos]
  logindep=logindep[pos]
  dev_sfr=stddev(logdep)
  dev_gas=stddev(logindep)
  len=n_elements(logindep)
  err_sfr = dev_sfr*(RANDOMN(seed, len, POISSON=1)-1)
  err_gas=dev_gas*(RANDOMN(seed, len, POISSON=1)-1)
  err_sfr*=logdep
  err_gas*=logindep
  index=intarr(len)+31
  
 ;stop
  ;------------------------------------------------------
  ;csv
  ;------------------------------------------------------
  WRITE_CSV, 'M31data.csv',index,logindep,err_gas,logdep,err_sfr
  
END