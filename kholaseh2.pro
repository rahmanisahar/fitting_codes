pro kholaseh2

  ;;;;;;;;;;;;;;;;;;;
  ;data
  ;;;;;;;;;;;;;;;;;;;
  
  reg=[1,2,3]
  
  N_h2_fuv=[1.04d,1.21d,1.87d]
  N_HI_fuv=[0.68d,1.18d,1.22d]
  N_tot_fuv=[0.87,0.71d,0.81d]
  
  err_N_h2_fuv=[1.84e-2,1.53e-2,0.30]
  err_N_HI_fuv=[0.02,2.89e-2,2.96e-2]
  err_N_tot_fuv=[0.026,1.34e-2,1.59e-2]
  
  
  N_h2_fir=[0.96d,1.08d,1.57d]
  N_HI_fir=[0.79d,1.09d,1.17d]
  N_tot_fir=[1.00d,0.75d,0.84d]
  
  err_N_h2_fir=[1.48e-2,1.26e-2,0.26d]
  err_N_HI_fir=[0.03,2.64e-2,4.67e-2]
  err_N_tot_fir=[0.03,0.02d,0.02d]
  
  N_prim_h2_fuv=[1.00d,1.15d,1.33d]
  N_prim_hi_fuv=[0.92d,0.81d,0.79d]
  N_prim_tot_fuv=[0.75d,0.44d,0.42d]
  
  err_N_prim_h2_fuv=[1.85e-2,1.58e-2,0.29]
  err_N_prim_hi_fuv=[0.06d,2.08e-2,2.31e-2]
  err_N_prim_tot_fuv=[0.03d,0.01d,0.01d]
  
  N_prim_h2_fir=[0.88d,1.00d,0.97d]
  N_prim_hi_fir=[0.47d,0.77d,0.76d]
  N_prim_tot_fir=[0.63d,0.47d,0.52d]
  
  err_N_prim_h2_fir=[1.48e-2,1.29e-2,0.20]
  err_N_prim_hi_fir=[0.30d,0.025d,2.31e-2]
  err_N_prim_tot_fir=[0.03d,0.01d,0.01d]
  
  beta_h2_fuv=[0.18d, 0.33d,1.38d]
  beta_hi_fuv=[0.42d,0.61d,0.62d]
  beta_tot_fuv=[0.16d,0.45d,0.52d]
  
  err_beta_h2_fuv=[7.17e-3,6.57e-3,0.12d]
  err_beta_hi_fuv=[0.04d,1.12e-2,1.28e-2]
  err_beta_tot_fuv=[0.04d,0.01d,0.02d]
  
  
  beta_h2_fir=[0.30d,0.40d,1.19d]
  beta_hi_fir=[1.57d,0.75d,0.75d]
  beta_tot_fir=[0.53d,0.55d,0.56d]
  
  err_beta_h2_fir=[6.11e-3,5.74e-3,0.1d]
  err_beta_hi_fir=[0.28d,0.01d,1.48e-2]
  err_beta_tot_fir=[0.08d,0.01d,0.01d]

  a_h2_fir=-1*[8.92,8.9,8.8]
  a_hi_fir=-1*[9.89,8.93,9.65]
  a_tot_fir=-1*[9.84,10.02,9.85]
  
;  err_a_h2_fir=[]
;  err_a_hi_fir=[]
;  err_a_tot_fir=[]
  
  a_h2_fuv=-1*[9.29,9.27,9.14]
  a_hi_fuv=-1*[10.03,9.81,9.22]
  a_tot_fuv=-1*[10.12,10.02,10.06]
  
;  err_a_h2_fuv=[]
;  err_a_hi_fuv=[]
;  err_a_tot_fuv=[]
  
  a_es_h2_fir=-1*[9.54,9.66,10.94]
  a_es_hi_fir=-1*[12.11,10.71,10.72]
  a_es_tot_fir=-1*[10.62,10.53,10.56]
  
;  err_a_es_h2_fir=[]
;  err_a_es_hi_fir=[]
;  err_a_es_tot_fir=[,,0.02]
  
  a_es_h2_fuv=-1*[9.65,9.66,11.65]
  a_es_hi_fuv=-1*[10.50,10.73,10.73]
  a_es_tot_fuv=-1*[10.28,10.58,10.68]
  
;  err_a_es_h2_fuv=[]
;  err_a_es_hi_fuv=[]
;  err_a_es_tot_fuv=[]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ep_fuv=errorplot(reg,N_h2_fuv,err_N_h2_fuv,"r2*-",xrange=[0,4],sym_color="tomato",title='FUV Results',Ytitle="N",name="H2",layout=[2,3,1],/current)
p2=errorplot(reg,N_HI_fuv,err_N_HI_fuv, "b2*-.",sym_color="red",sym_filled=2,/overplot,name="HI")
p3=errorplot(reg,N_tot_fuv,err_N_tot_fuv,"g2*--",sym_color="yellow",sym_filled=2,/overplot,name="$Total Gas$")
leg=legend(target=[ep_fuv,p2,p3],position=[190,450],font_size=8,/device,/auto_text_color)

p4=errorplot(reg,N_prim_h2_fuv,err_N_prim_h2_fuv,"r2tu-",xrange=[0,4],sym_color="tomato",sym_filled=2,title='FUV Results',Ytitle="N'",layout=[2,3,2],/current)
p5=errorplot(reg,N_prim_hi_fuv,err_N_prim_hi_fuv,"b2tu-.",sym_color="red",sym_filled=2,/overplot)
p6=errorplot(reg,N_prim_tot_fuv,err_N_prim_tot_fuv,"g2tu--",sym_color="yellow",sym_filled=2,/overplot)

p7=errorplot(reg,beta_h2_fuv,err_beta_h2_fuv,"r2s-",xrange=[0,4],sym_color="tomato",sym_filled=2,title='FUV Results',Ytitle="$\beta$",layout=[2,3,3],/current)
p8=errorplot(reg,beta_hi_fuv,err_beta_hi_fuv,"b2s-.",sym_color="red",sym_filled=2,/overplot)
p9=errorplot(reg,beta_tot_fuv,err_beta_tot_fuv,"g2s--",sym_color="yellow",sym_filled=2,/overplot)

p_fuv = plot(reg, a_h2_fuv,"r2d-",sym_color="tomato",sym_filled=0.2,xrange=[0,4],title="FUV Results",Ytitle="A",layout=[2,3,4],/current)
p2=plot(reg,a_HI_fuv,"b2d-.",sym_color="red",sym_filled=0.2,/overplot,name="HI")
p3=plot(reg,a_tot_fuv,"g2d--",sym_color="yellow",sym_filled=0.2,/overplot,name="Total Gas")

p_fuv = plot(reg, a_es_h2_fuv,"r2d-",sym_color="tomato",sym_filled=0.2,xrange=[0,4],title="FUV Results",Ytitle="A'",layout=[2,3,5],/current)
p2=plot(reg,a_es_HI_fuv,"b2d-.",sym_color="red",sym_filled=0.2,/overplot,name="HI")
p3=plot(reg,a_es_tot_fuv,"g2d--",sym_color="yellow",sym_filled=0.2,/overplot,name="Total Gas")


ep_fir=errorplot(reg,N_h2_fir,err_N_h2_fir,"r2*-",xrange=[0,4],sym_color="tomato",title='fir Results',Ytitle="N",name="H2",layout=[2,3,1])
p2=errorplot(reg,N_HI_fir,err_N_HI_fir, "b2*-.",sym_color="red",sym_filled=2,/overplot,name="HI")
p3=errorplot(reg,N_tot_fir,err_N_tot_fir,"g2*--",sym_color="yellow",sym_filled=2,/overplot,name="$Total Gas$")
  leg=legend(target=[ep_fir,p2,p3],position=[190,450],font_size=8,/device,/auto_text_color)
  
p4=errorplot(reg,N_prim_h2_fir,err_N_prim_h2_fir,"r2tu-",xrange=[0,4],sym_color="tomato",sym_filled=2,title='fir Results',Ytitle="N'",layout=[2,3,2],/current)
p5=errorplot(reg,N_prim_hi_fir,err_N_prim_hi_fir,"b2tu-.",sym_color="red",sym_filled=2,/overplot)
p6=errorplot(reg,N_prim_tot_fir,err_N_prim_tot_fir,"g2tu--",sym_color="yellow",sym_filled=2,/overplot)

p7=errorplot(reg,beta_h2_fir,err_beta_h2_fir,"r2s-",xrange=[0,4],sym_color="tomato",sym_filled=2,title='fir Results',Ytitle="$\beta$",layout=[2,3,3],/current)
  p8=errorplot(reg,beta_hi_fir,err_beta_hi_fir,"b2s-.",sym_color="red",sym_filled=2,/overplot)
p9=errorplot(reg,beta_tot_fir,err_beta_tot_fir,"g2s--",sym_color="yellow",sym_filled=2,/overplot)

p_fir = plot(reg, a_h2_fir,"r2d-",sym_color="tomato",sym_filled=0.2,xrange=[0,4],title="fir Results",Ytitle="A",layout=[2,3,4],/current)
p2=plot(reg,a_HI_fir,"b2d-.",sym_color="red",sym_filled=0.2,/overplot,name="HI")
p3=plot(reg,a_tot_fir,"g2d--",sym_color="yellow",sym_filled=0.2,/overplot,name="Total Gas")

p_fir = plot(reg, a_es_h2_fir,"r2d-",sym_color="tomato",sym_filled=0.2,xrange=[0,4],title="fir Results",Ytitle="A'",layout=[2,3,5],/current)
p2=plot(reg,a_es_HI_fir,"b2d-.",sym_color="red",sym_filled=0.2,/overplot,name="HI")
p3=plot(reg,a_es_tot_fir,"g2d--",sym_color="yellow",sym_filled=0.2,/overplot,name="Total Gas")
END