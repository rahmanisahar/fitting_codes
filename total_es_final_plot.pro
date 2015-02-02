pro total_es_final_plot, filename1, filename2, filename3, filename4, filename5, filename6

  filename1= 'Desktop/project/result/res_from_sharcnet/bayes/E-S/fir_vs_h2/M31data.csv'
  filename2= 'Desktop/project/result/res_from_sharcnet/bayes/E-S/fir_vs_hi/M31data.csv'
  filename3= 'Desktop/project/result/res_from_sharcnet/bayes/E-S/fir_vs_tot/M31data.csv'
  filename4= 'Desktop/project/result/res_from_sharcnet/bayes/E-S/fuv_vs_h2/M31data.csv'
  filename5= 'Desktop/project/result/res_from_sharcnet/bayes/E-S/fuv_vs_hi/M31data.csv'
  filename6= 'Desktop/project/result/res_from_sharcnet/bayes/E-S/fuv_vs_tot/M31data.csv'
 ;w=window( DIMENSIONS=[800,800], LOCATION=[200,250])
  readcol,filename1,v1,logindep,v3,logstar,v5,logdep,v7
  x=fltarr(n_elements(v7))+max(logindep)+2
  y=fltarr(n_elements(v7))+max(logdep)+2
  z=fltarr(n_elements(v7))+min(logstar)-2
  p=plot3d(logindep,logdep,logstar,'6',$
    ;TITLE='fitting pix by pix method',$
    XTITLE='$\Sigma_{H_2}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR,TIR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
    ;SHADOW_COLOR="deep sky blue",$
    ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
    AXIS_STYLE=2,$
    ;LINESTYLE=1,$
    DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2], $
    XRANGE=[min(logindep)-2,max(logindep)+2],yRANGE=[min(logdep)-2,max(logdep)+2], $
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',POSITION=[76,80],/device,layout=[3,1,1]);,ASPECT_RATIO=2)
    t2=text(-2.5,-13.5,0,$
    '$N = 0.94, \beta = 0.34, A = -9.57$',$
    /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
;    t3=text(565,70,$
;    '$\sigma_{scat}=3.88e2$',$
;    /DATA , FONT_SIZE=8, FONT_NAME='Helvetica',/device,/current)
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.9492+[max(logstar),min(logstar)]*0.3395-9.5723,[max(logstar),min(logstar)],$
    'r2',/overplot)
  p2=plot3d(logindep,logdep,z,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p3=plot3d(logindep,y,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p4=plot3d(x,logdep,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
   stop
 p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_tot_fir_vs_h2_22.png", BORDER=10, RESOLUTION=300 
; stop
  readcol,filename2,v1,logindep,v3,logstar,v5,logdep,v7
  x=fltarr(n_elements(v7))+max(logindep)+2
  y=fltarr(n_elements(v7))+max(logdep)+2
  z=fltarr(n_elements(v7))+min(logstar)-2
  p=plot3d(logindep,logdep,logstar,'6',$
    ;TITLE='fitting pix by pix method',$
    XTITLE='$\Sigma_{HI}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR, TIR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
    SHADOW_COLOR="deep sky blue",$
    ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
    AXIS_STYLE=2,$
    ;LINESTYLE=1,$
    DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2],XRANGE=[min(logindep)-2,max(logindep)+2],yRANGE=[min(logdep)-2,max(logdep)+2], $
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',POSITION=[0.15,0.3,0.9,0.83]);,/CURRENT,layout=[3,1,2])
    t2=text(-3,-15.5,0,$
    '$N = 0.77, \beta = 0.74, A = -10.71$',$
    /DATA, FONT_SIZE=10, FONT_NAME='Helvetica')
;    t3=text(565,70,/device,$
;    '$\sigma_{scat}=3.22e2$',$
;    /DATA , FONT_SIZE=8, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.7750+[max(logstar),min(logstar)]*0.7453-10.7129,[max(logstar),min(logstar)],$
    'r2',/overplot)
  p2=plot3d(logindep,logdep,z,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p3=plot3d(logindep,y,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p4=plot3d(x,logdep,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_tot_fir_vs_hi2.png", BORDER=10, RESOLUTION=300 
    ;stop
  readcol,filename3,v1,logindep,v3,logstar,v5,logdep,v7
  x=fltarr(n_elements(v7))+max(logindep)+2
  y=fltarr(n_elements(v7))+max(logdep)+2
  z=fltarr(n_elements(v7))+min(logstar)-2
  p=plot3d(logindep,logdep,logstar,'6',$
    ;TITLE='fitting pix by pix method',$
    XTITLE='$\Sigma_{Total gas}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR, TIR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
    SHADOW_COLOR="deep sky blue",$
    ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
    AXIS_STYLE=2,$
    ;LINESTYLE=1,$
    DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2],XRANGE=[min(logindep)-2,max(logindep)+2],yRANGE=[min(logdep)-2,max(logdep)+2], $
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',POSITION=[0.15,0.3,0.9,0.83]);,/CURRENT,layout=[3,1,3])
    t2=text(-3,-15.5,0,$
    '$N = 0.50, \beta = 0.55, A = -10.53$',$
    /DATA, FONT_SIZE=10, FONT_NAME='Helvetica')
;    t3=text(565,70,/device,$
;    '$\sigma_{scat}=1.50e2$',$
;    /DATA , FONT_SIZE=8, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.5044+[max(logstar),min(logstar)]*0.5529-10.5343,[max(logstar),min(logstar)],$
    'r2',/overplot)
  p2=plot3d(logindep,logdep,z,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p3=plot3d(logindep,y,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p4=plot3d(x,logdep,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
   p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_tot_fir_vs_tot2.png", BORDER=10, RESOLUTION=300  
    
  readcol,filename4,v1,logindep,v3,logstar,v5,logdep,v7
  x=fltarr(n_elements(v7))+max(logindep)+2
  y=fltarr(n_elements(v7))+max(logdep)+2
  z=fltarr(n_elements(v7))+min(logstar)-2
  p=plot3d(logindep,logdep,logstar,'6',$
    ;TITLE='fitting pix by pix method',$
    XTITLE='$\Sigma_{H_2}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR, FUV+24\mum}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
    SHADOW_COLOR="deep sky blue",$
    ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
    AXIS_STYLE=2,$
    ;LINESTYLE=1,$
    DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2],XRANGE=[min(logindep)-2,max(logindep)+2],yRANGE=[min(logdep)-2,max(logdep)+2], $
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',POSITION=[0.2,0.35,0.8,0.90]);,layout=[3,1,1])
    t2=text(-2.5,-15.5,0,$
    '$N = 1.09, \beta = 0.34, A = -9.57$',$
    /DATA, FONT_SIZE=10, FONT_NAME='Helvetica')
;    t3=text(0,-16.0,0,$
;    '$\sigma_{scat}=2.52e2$',$
;    /DATA , FONT_SIZE=8, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*1.0910+[max(logstar),min(logstar)]*0.3395-9.5723,[max(logstar),min(logstar)],$
    'r2',/overplot)
  p2=plot3d(logindep,logdep,z,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p3=plot3d(logindep,y,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p4=plot3d(x,logdep,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
   ; stop
   p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_tot_fuv_vs_h22.png", BORDER=10, RESOLUTION=300  
  readcol,filename5,v1,logindep,v3,logstar,v5,logdep,v7
  x=fltarr(n_elements(v7))+max(logindep)+2
  y=fltarr(n_elements(v7))+max(logdep)+2
  z=fltarr(n_elements(v7))+min(logstar)-2
  p=plot3d(logindep,logdep,logstar,'6',$
   ; TITLE='fitting pix by pix method',$
    XTITLE='$\Sigma_{HI}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR, FUV+ 24\mu m}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
    SHADOW_COLOR="deep sky blue",$
    ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
    AXIS_STYLE=2,$
    ;LINESTYLE=1,$
    DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2],XRANGE=[min(logindep)-2,max(logindep)+2],yRANGE=[min(logdep)-2,max(logdep)+2], $
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',POSITION=[0.2,0.35,0.8,0.90]);,/CURRENT,layout=[3,1,2])
    t2=text(-3,-15.5,0,$
    '$N = 0.80, \beta = 0.60, A = -10.70$',$
    /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
;    t3=text(0,-16.0,0,$
;    '$\sigma_{scat}=2.40e2$',$
;    /DATA , FONT_SIZE=8, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.8052+[max(logstar),min(logstar)]*0.5973-10.6989,[max(logstar),min(logstar)],$
    'r2',/overplot)
  p2=plot3d(logindep,logdep,z,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p3=plot3d(logindep,y,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p4=plot3d(x,logdep,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
   p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_tot_fuv_vs_hi2.png", BORDER=10, RESOLUTION=300  
  readcol,filename6,v1,logindep,v3,logstar,v5,logdep,v7
  x=fltarr(n_elements(v7))+max(logindep)+2
  y=fltarr(n_elements(v7))+max(logdep)+2
  z=fltarr(n_elements(v7))+min(logstar)-2
  p=plot3d(logindep,logdep,logstar,'6',$
    ; TITLE='fitting pix by pix method',$
    XTITLE='$\Sigma_{Total Gas}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR, FUV+ 24\mu m}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
    SHADOW_COLOR="deep sky blue",$
    ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
    AXIS_STYLE=2,$
    ;LINESTYLE=1,$
    DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2],XRANGE=[min(logindep)-2,max(logindep)+2],yRANGE=[min(logdep)-2,max(logdep)+2], $
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',POSITION=[0.2,0.35,0.8,0.90]);,/CURRENT,layout=[3,1,3])
    t2=text(-3,-15.5,0,$
    '$N = 0.0.48, \beta = 0.45, A = -10.57$',$
    /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
;    t3=text(0,-16.0,0,$
;    '$\sigma_{scat}=2.44e2$',$
;    /DATA , FONT_SIZE=8, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.4827+[max(logstar),min(logstar)]*0.4461-10.5730,[max(logstar),min(logstar)],$
    'r2',/overplot)
  p2=plot3d(logindep,logdep,z,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p3=plot3d(logindep,y,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
  p4=plot3d(x,logdep,logstar,'6',$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'black',/overplot)
    
p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_tot_fuv_vs_tot2.png", BORDER=10, RESOLUTION=300 
 




END