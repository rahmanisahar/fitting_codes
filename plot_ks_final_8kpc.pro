pro plot_ks_final_8kpc, filename1,filename2,filename3,filename4,filename5,filename6
  filename1= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc/KS/fir_vs_h2/M31data.csv'
  filename2= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc/KS/fir_vs_hi/M31data.csv'
  filename3= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc/KS/fir_vs_tot/M31data.csv'
  filename4= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc/KS/fuv_vs_h2/M31data.csv'
  filename5= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc/KS/fuv_vs_hi/M31data.csv'
  filename6= 'Desktop/project/result/res_from_sharcnet/bayes/diff_region/8kpc/KS/fuv_vs_tot/M31data.csv'
  
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
    [max(logindep ),min(logindep )]*0.9645-8.9539,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(76,324,$
    'N = 0.96, A = -8.95',$
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
    [max(logindep ),min(logindep )]*0.7939-9.8866,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(270,324,$
    'N = 0.79, A = -9.89',$
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
    [max(logindep ),min(logindep )]*1.0037-10.0367,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(493,324,$
    'N = 1.00, A = -10.04',$
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
    [max(logindep ),min(logindep )]*1.0431-9.2932,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(76,69,$
    'N = 1.04, A = -9.29',$
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
    [max(logindep ),min(logindep )]*0.6822-10.0341,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;    /DATA, FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t2=text(271,69,$
    'N = 0.68, A = -10.03',$
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
    [max(logindep ),min(logindep )]*0.8763-10.1242,$
    'r2',/overplot)
  ;  t1=text(-0.3,-10,$
  ;    '$log(\Sigma_{SFR,FIR}) = const + N \times log(\Sigma_{H_{2}})$',$
  ;      FONT_SIZE=8, FONT_NAME='Helvetica')
  ;
  ;
  t6=text(490,69,$
    'N = 0.88, A = -10.12',$
    /device, FONT_SIZE=8, FONT_NAME='Helvetica')
    
    
END