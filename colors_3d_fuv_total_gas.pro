pro colors_3d_fuv_total_gas
 filename6= '~/Desktop/project/result/res_from_sharcnet/bayes/diff_region/18kpc_25kpc/ES/fuv_vs_tot/M31data.csv'
filename3= '~/Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/ES/fuv_vs_tot/M31data.csv'
filename2= '~/Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc/ES/fuv_vs_tot/M31data.csv'
 
 readcol,filename6,v1,logindep,v3,logstar,v5,logdep,v7
 x=fltarr(n_elements(v7))+2.5
 y=fltarr(n_elements(v7))-7
 z=fltarr(n_elements(v7))+min(logstar)-2
 p=plot3d(logindep,logdep,logstar,'6',$
   ; TITLE='fitting pix by pix method',$
   XTITLE='$\Sigma_{Total Gas}$ (M$\odot$ pc$^{-2}$)',$
   YTITLE='$\Sigma_{SFR, FUV+ 24\mu m}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
   zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
  ; SHADOW_COLOR="deep sky blue",$
   ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
   AXIS_STYLE=2,$
   ;LINESTYLE=1,$
   DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2],XRANGE=[-1,2.5],yRANGE=[-11,-7], $
   SYMBOL = 'circle',sym_size=0.5, $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'deep sky blue',POSITION=[0.2,0.35,0.8,0.90]);,/CURRENT,layout=[3,1,3])
; t2=text(-2.3,-13,0,$
;   '$N = 0.42, \beta = 0.52, A = -10.68$',$
;   /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
 ax = p.AXES
 ax[2].HIDE = 1
 ax[6].HIDE = 1
 ax[7].HIDE = 1
 fit1=plot3d([max(logindep),min(logindep)],$
   [max(logindep),min(logindep)]*0.4211+[max(logstar),min(logstar)]*0.5181-10.6855,[max(logstar),min(logstar)],$
   'b2',/overplot,name=" 18kpc < R < 25kpc")
 p2=plot3d(logindep,logdep,z,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark blue',/overplot)
   
 p3=plot3d(logindep,y,logstar,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark blue',/overplot)
   
 p4=plot3d(x,logdep,logstar,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark blue',/overplot)
;  stop 
   readcol,filename3,v1,logindep,v3,logstar,v5,logdep,v7
; x=fltarr(n_elements(v7))+max(logindep)+2
; y=fltarr(n_elements(v7))+max(logdep)+2
; z=fltarr(n_elements(v7))+min(logstar)-2
 p=plot3d(logindep,logdep,logstar,'6',$
   ; TITLE='fitting pix by pix method',$
   XTITLE='$\Sigma_{Total Gas}$ (M$\odot$ pc$^{-2}$)',$
   YTITLE='$\Sigma_{SFR, FUV+ 24\mu m}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
   zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
   SHADOW_COLOR="deep sky blue",$
   ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
   AXIS_STYLE=2,$
   ;LINESTYLE=1,$
   DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2],XRANGE=[-1,2.5],yRANGE=[-11,-7], $
   SYMBOL = 'circle',sym_size=0.5, $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'green',POSITION=[0.2,0.35,0.8,0.90],/overplot);,/CURRENT,layout=[3,1,3])
; t2=text(-3,-14,0,$
;   '$N = 0.44, \beta = 0.45, A = -10.58$',$
;   /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
 ax = p.AXES
 ax[2].HIDE = 1
 ax[6].HIDE = 1
 ax[7].HIDE = 1
 pp=plot3d([max(logindep),min(logindep)],$
   [max(logindep),min(logindep)]*0.4423+[max(logstar),min(logstar)]*0.4521-10.5804,[max(logstar),min(logstar)],$
   'g2',/overplot,name=" 8 kpc < R < 18kpc")
 p2=plot3d(logindep,logdep,z,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark green',/overplot)
   
 p3=plot3d(logindep,y,logstar,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark green',/overplot)
   
 p4=plot3d(x,logdep,logstar,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark green',/overplot)

 readcol,filename2,v1,logindep,v3,logstar,v5,logdep,v7
; x=fltarr(n_elements(v7))+max(logindep)+2
; y=fltarr(n_elements(v7))+max(logdep)+2
; z=fltarr(n_elements(v7))+min(logstar)-2
 ppp=plot3d(logindep,logdep,logstar,'6',$
   ; TITLE='fitting pix by pix method',$
   XTITLE='$\Sigma_{Total Gas}$ (M$\odot$ pc$^{-2}$)',$
   YTITLE='$\Sigma_{SFR, FUV+ 24\mu m}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
   zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
   SHADOW_COLOR="deep sky blue",$
   ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
   AXIS_STYLE=2,$
   ;LINESTYLE=1,$
   DEPTH_CUE=[0, 2], /PERSPECTIVE, $
   SYMBOL = 'circle',sym_size=0.5, $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'red',/overplot);,/CURRENT,layout=[3,1,3])
; t2=text(-3,-14.5,0,$
;   '$N = 0.75, \beta = 0.16, A = -10.28$',$
;   /DATA , FONT_SIZE=10, FONT_NAME='Helvetica')
 ax = p.AXES
 ax[2].HIDE = 1
 ax[6].HIDE = 1
 ax[7].HIDE = 1
 fit=plot3d([max(logindep),min(logindep)],$
   [max(logindep),min(logindep)]*0.7534+[max(logstar),min(logstar)]*0.1610-10.2831,[max(logstar),min(logstar)],$
   'r2',/overplot,name=" R < 8kpc ")
 p2=plot3d(logindep,logdep,z,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark red',/overplot)
   
 p3=plot3d(logindep,y,logstar,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark red',/overplot)
   
 p4=plot3d(x,logdep,logstar,'6',$
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'dark red',/overplot)
   leg=legend(target=[fit,pp,fit1],position=[550,60],font_size=8,/device,/auto_text_color)


end