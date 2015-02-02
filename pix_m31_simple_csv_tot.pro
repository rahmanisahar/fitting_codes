pro pix_m31_simple_csv_tot
dep=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/sfr_halpha_reg_hi_sb.fits',0,h_dep)
 gas_mass_sun=mrdfits('~/Desktop/project/proms/total_gas/total_gas_sun.fits',0)
 err_sfr=mrdfits('~/Desktop/project/proms/hi/reg_to_hi/err_sfr_halpha_reg_hi_sb.fits',0)
 err_tot_gas_sun=mrdfits('~/Desktop/project/proms/total_gas/err_tot_gas_sun.fits',0)
 stop
 size_of_arcsec= 3.4975200d
 pix_size=43.749994d
 ;------------------------------------------------------
 ;calculate the gas_mass
 ;-----------------------------------------------------
 ;convert diameters from pc to cm: 1 pc = 3.086*10^18 cm
 diam_cm=3.086d18*pix_size*size_of_arcsec   ;Diameter of the region in cm
 radii_cm= diam_cm/2d             ;raduis of the region in cm
 radii_pc=radii_cm/(3.086d18)
 area = 4*!pi*(radii_pc)^(2d)  ;in pc^2
 ;area=1d
 dep= dep/area      ;unit of dependet map per pc^2
; indep= indep/area  ;unit of independate map per pc^2
 gas_mass_sun= gas_mass_sun/area  ;gas surface density in mass per mass of sun per pc^2
 
 err_sfr/=area
 err_gas_mass_sun=err_tot_gas_sun/area
; stop
 ;------------------------------------------------------
 ;fit the sfr laws
 ;------------------------------------------------------
 logdep=alog10(dep[where (dep GT 0 AND gas_mass_sun GT 0)])
 logindep=alog10(gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)])
 ;logdep=double(logdep)
 ;logindep=double(logindep)
 err_sfr=err_sfr[where (dep GT 0 AND gas_mass_sun GT 0)]
 err_gas=err_gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0 )]
 dep2=dep[where (dep GT 0 AND gas_mass_sun GT 0)]
 gas_mass_sun2=gas_mass_sun[where (dep GT 0 AND gas_mass_sun GT 0)]
 pos=where(err_gas eq err_gas)
 err_sfr_f=abs(err_sfr/(alog(10)*dep2))
 err_gas_f=abs(err_gas/(alog(10)*gas_mass_sun2))
 len=n_elements(pos)
 index=intarr(len)+31
 
 stop
 ;------------------------------------------------------
 ;csv
 ;------------------------------------------------------
 WRITE_CSV, 'M31data.csv',index,logindep[pos],err_gas_f[pos],logdep[pos],err_sfr_f[pos]
 END
