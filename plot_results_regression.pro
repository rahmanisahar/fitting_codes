 pro plot_results_regression,filename
 filename='M31data.csv'
  readcol,filename,v1,logindep,v3,logstar,v5,logdep,v7
 x=fltarr(n_elements(v7))+max(logindep)+2
 y=fltarr(n_elements(v7))+max(logdep)+2
 z=fltarr(n_elements(v7))+min(logstar)-2
p=plot3d(logindep,logdep,logstar,'6',$
   TITLE='fitting pix by pix method',$
   XTITLE='$\Sigma_{H_2}$ (M$\odot$ pc$^{-2}$)',$
   YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
   zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
   SHADOW_COLOR="deep sky blue",$
  ; XY_SHADOW=1, YZ_SHADOW=1, XZ_SHADOW=1,$
   AXIS_STYLE=2,$
   ;LINESTYLE=1,$
   DEPTH_CUE=[0, 2], /PERSPECTIVE,ZRANGE=[min(logstar)-2,max(logstar)+2],XRANGE=[min(logindep)-2,max(logindep)+2],yRANGE=[min(logdep)-2,max(logdep)+2], $
   SYMBOL = 'dot', $
   SYM_FILLED = 1, $
   SYM_FILL_COLOR = 'gold')
 ax = p.AXES
 ax[2].HIDE = 1
 ax[6].HIDE = 1
 ax[7].HIDE = 1
 fit=plot3d([max(logindep),min(logindep)],$
   [max(logindep),min(logindep)]*0.8052+[max(logstar),min(logstar)]*0.5974-10.6989,[max(logstar),min(logstar)],$
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
 
 
; p=SCATTERPLOT3D(logindep,logdep,logstar,SYM_OBJECT=ORB(), /SYM_FILLED,$
;   TITLE='fitting pix by pix method',$
;   XTITLE='$\Sigma_{H_2}$ (M$\odot$ pc$^{-2}$)',$
;   YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
;   zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
;   RGB_TABLE=7, AXIS_STYLE=2, SYM_SIZE=1, MAGNITUDE=logstar)
; ax = p.AXES
; ax[2].HIDE = 1
; ax[6].HIDE = 1
; ax[7].HIDE = 1
;
;
; Plot_3dbox, logindep,logdep,logstar, /XY_PLANE, /YZ_PLANE, /XZ_PLANE, $
;                   /SOLID_WALLS,AZ=40, XYSTYLE=1, XZSTYLE=1, $
;                    YZSTYLE=1,psym=3,     $
;                    TITLE='fitting pix by pix method',$
;                    XTITLE='$\Sigma_{H_2}$ (M$\odot$ pc$^{-2}$)',$
;                    YTITLE='$\Sigma_{SFR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
;                    zTITLE= '$\Sigma_{stars}$ (M$\odot$ pc$^{-2}$)',$
;                    /YSTYLE, zCharsize=1.6,pCOLOR = 86
;                  
;                  
END