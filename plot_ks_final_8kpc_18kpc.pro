pro plot_ks_final_8kpc_18kpc, filename1,filename2,filename3,filename4,filename5,filename6
 filename1= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/KS/fir_vs_h2/M31data.csv'
  filename2= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/KS/fir_vs_hi/M31data.csv'
  filename3= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/KS/fir_vs_tot/M31data.csv'
  filename4= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/KS/fuv_vs_h2/M31data.csv'
  filename5= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/KS/fuv_vs_hi/M31data.csv'
  filename6= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc_18kpc/KS/fuv_vs_tot/M31data.csv'
  
  readcol,filename1,v1,logindep,v3,logdep,v5
  p=plot(logindep ,logdep ,'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR, TIR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    ;;FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold', layout=[3,2,1])
  ; stop
  p1=plot([max(logindep ),min(logindep )],$
    [max(logindep ),min(logindep )]*1.0836-8.9018,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(76,334,$
    'N = 1.08, A = -8.90',$
    /device, FONT_SIZE=8, FONT_NAME='Helvetica')
    
  readcol,filename2,v1,logindep,v3,logdep,v5
  p=plot(logindep ,logdep ,'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{HI}$ (M$\odot$ pc$^{-2}$)',$
    ;YTITLE='$\Sigma_{SFR, TIR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    ;FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',/current, layout=[3,2,2],yrange=[-14,-7])
    
  p1=plot([max(logindep ),min(logindep )],$
    [max(logindep ),min(logindep )]*1.0920-9.5427,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(270,334,$
    'N = 1.09, A = -9.54',$
    /device,FONT_SIZE=8, FONT_NAME='Helvetica')
    
  readcol,filename3,v1,logindep,v3,logdep,v5
  p=plot(logindep ,logdep ,'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{Total gas}$ (M$\odot$ pc$^{-2}$)',$
    ; YTITLE='$\Sigma_{SFR, TIR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    ;FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',/current, layout=[3,2,3],yrange=[-13,-7])
    
  p1=plot([max(logindep ),min(logindep )],$
    [max(logindep ),min(logindep )]*0.7489-9.8092,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(493,334,$
    'N = 0.75, A = -9.81',$
    /device,  FONT_SIZE=8, FONT_NAME='Helvetica')
    
  readcol,filename4,v1,logindep,v3,logdep,v5
  p=plot(logindep ,logdep ,'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{2}}$ (M$\odot$ pc$^{-2}$)',$
    YTITLE='$\Sigma_{SFR, FUV+24\mum}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    ;FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',/current, layout=[3,2,4],yrange=[-13,-7])
    
  p1=plot([max(logindep ),min(logindep )],$
    [max(logindep ),min(logindep )]*1.2145-9.2682,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(76,69,$
    'N = 1.21, A = -9.27',$
    /device, FONT_SIZE=8, FONT_NAME='Helvetica')
    
  readcol,filename5,v1,logindep,v3,logdep,v5
  p=plot(logindep ,logdep ,'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{H_{HI}}$ (M$\odot$ pc$^{-2}$)',$
    ; YTITLE='$\Sigma_{SFR, TIR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    ;FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold',/current, layout=[3,2,5],yrange=[-13,-7])
    
  p1=plot([max(logindep ),min(logindep )],$
    [max(logindep ),min(logindep )]*1.17860-9.81354,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;    /DATA, FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(271,69,$
    'N = 1.18, A = -9.81',$
    /device,FONT_SIZE=8, FONT_NAME='Helvetica')
    
  readcol,filename6,v1,logindep,v3,logdep,v5
  p11=plot(logindep ,logdep ,'6',$
    ;TITLE='K_S law fitting pix by pix method with halpha',$
    XTITLE='$\Sigma_{Total gas}$ (M$\odot$ pc$^{-2}$)',$
    ; YTITLE='$\Sigma_{SFR, TIR}$ (M$\odot$ yr$^{-1}$pc$^{-2}$)',$
    ;FONT_SIZE = 20,$
    SYMBOL = 'dot', $
    SYM_FILLED = 1, $
    SYM_FILL_COLOR = 'gold', /current,layout=[3,2,6],yrange=[-13,-7])
    
  p12=plot([max(logindep ),min(logindep )],$
    [max(logindep ),min(logindep )]*0.7127-10.0165,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t6=text(490,69,$
    'N = 0.71, A = -10.02',$
    /device, FONT_SIZE=8, FONT_NAME='Helvetica')
    
    
END