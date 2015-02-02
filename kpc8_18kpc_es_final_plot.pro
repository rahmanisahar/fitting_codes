pro kpc8_18kpc_es_final_plot, filename1, filename2, filename3, filename4, filename5, filename6

  filename1= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/ES/fir_vs_h2/M31data.csv'
  filename2= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/ES/fir_vs_hi/M31data.csv'
  filename3= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/ES/fir_vs_tot/M31data.csv'
  filename4= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/ES/fuv_vs_h2/M31data.csv'
  filename5= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/ES/fuv_vs_hi/M31data.csv'
  filename6= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/ES/fuv_vs_tot/M31data.csv'
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
    SYM_FILL_COLOR = 'gold',POSITION=[0.15,0.3,0.9,0.83]);,layout=[3,1,1],ASPECT_RATIO=2)
  t2=text(-2.5,-13.5,0,$
    '$N = 1.00, \beta = 0.40, A = -9.66$',$
    /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.9990+[max(logstar),min(logstar)]*0.3958-9.6587,[max(logstar),min(logstar)],$
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
  p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_8kpc_18kpc_fir_vs_h2.png", BORDER=10, RESOLUTION=300
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
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.7744+[max(logstar),min(logstar)]*0.7464-10.7059,[max(logstar),min(logstar)],$
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
  p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_8kpc_18kpc_fir_vs_hi.png", BORDER=10, RESOLUTION=300
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
  t2=text(-3,-15.7,0,$
    '$N = 0.47, \beta = 0.69, A = -10.44$',$
    /DATA, FONT_SIZE=10, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.4718+[max(logstar),min(logstar)]*0.6860-10.4458,[max(logstar),min(logstar)],$
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
  p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_8kpc_18kpc_fir_vs_tot.png", BORDER=10, RESOLUTION=300
  
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
    '$N = 1.15, \beta = 0.33, A = -9.89$',$
    /DATA, FONT_SIZE=10, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*1.1531+[max(logstar),min(logstar)]*0.3267-9.8904,[max(logstar),min(logstar)],$
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
  p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_8kpc_18kpc_fuv_vs_h2.png", BORDER=10, RESOLUTION=300
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
  t2=text(-3,-14,0,$
    '$N = 0.81, \beta = 0.61, A = -10.73$',$
    /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.8085+[max(logstar),min(logstar)]*0.6141-10.7296,[max(logstar),min(logstar)],$
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
  p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_8kpc_18kpc_fuv_vs_hi.png", BORDER=10, RESOLUTION=300
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
  t2=text(-3,-14,0,$
    '$N = 0.44, \beta = 0.45, A = -10.58$',$
    /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
  ax = p.AXES
  ax[2].HIDE = 1
  ax[6].HIDE = 1
  ax[7].HIDE = 1
  fit=plot3d([max(logindep),min(logindep)],$
    [max(logindep),min(logindep)]*0.4423+[max(logstar),min(logstar)]*0.4521-10.5804,[max(logstar),min(logstar)],$
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
    
  p.Save, "~/Desktop/project/plots_after_new_mips/bayes/es_8kpc_18kpc_fuv_vs_tot.png", BORDER=10, RESOLUTION=300
  
END