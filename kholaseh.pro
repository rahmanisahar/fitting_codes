pro kholaseh


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
N_prim_tot_fir=[0.63d,0.47d,0.50d]

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
beta_tot_fir=[0.53d,0.55d,0.48d]

err_beta_h2_fir=[6.11e-3,5.74e-3,0.1d]
err_beta_hi_fir=[0.28d,0.01d,1.48e-2]
err_beta_tot_fir=[0.08d,0.01d,0.01d]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

p_fuv = plot(reg, N_h2_fuv,"r2d-",sym_color="tomato",sym_filled=0.2,xrange=[0,4],title="FUV Results",name="H2",layout=[2,2,1])
p1=plot(reg,N_h2_fuv,"*",sym_color="tomato",sym_filled=2,name="N",/overplot)
p2=plot(reg,N_HI_fuv,"b2d-.",sym_color="red",sym_filled=0.2,/overplot,name="HI")
p3=plot(reg,N_tot_fuv,"g2d--",sym_color="yellow",sym_filled=0.2,/overplot,name="Total Gas")
p4=plot(reg,N_prim_h2_fuv,"r2tu-",sym_color="tomato",sym_filled=2,/overplot )
p4_1=plot(reg,N_prim_h2_fuv,"tu",sym_color="tomato",sym_filled=2,/overplot,name="N'")
p5=plot(reg,N_prim_hi_fuv,"b2tu-.",sym_color="red",sym_filled=2,/overplot)
p6=plot(reg,N_prim_tot_fuv,"g2tu--",sym_color="yellow",sym_filled=2,/overplot)
p7=plot(reg,beta_h2_fuv,"r2s-",sym_color="tomato",sym_filled=2,/overplot)
p7_1=plot(reg,beta_h2_fuv,"s",sym_color="tomato",sym_filled=2,/overplot,name="$\beta$")
p8=plot(reg,beta_hi_fuv,"b2s-.",sym_color="red",sym_filled=2,/overplot)
p9=plot(reg,beta_tot_fuv,"g2s--",sym_color="yellow",sym_filled=2,/overplot)
leg=legend(target=[p_fuv,p2,p3,p1,p4_1,p7_1],position=[110,440],font_size=8,/device,/auto_text_color)
;stop

p_fir = plot(reg, N_h2_fir,"r2d-",sym_color="tomato",sym_filled=0.2,xrange=[0,4],title="fir Results",name="H2",layout=[2,2,2],/current)
p1=plot(reg,N_h2_fir,"*",sym_color="tomato",sym_filled=2,name="N",/overplot)
p2=plot(reg,N_HI_fir,"b2d-.",sym_color="red",sym_filled=0.2,/overplot,name="HI")
p3=plot(reg,N_tot_fir,"g2d--",sym_color="yellow",sym_filled=0.2,/overplot,name="Total Gas")
p4=plot(reg,N_prim_h2_fir,"r2tu-",sym_color="tomato",sym_filled=2,/overplot )
p4_1=plot(reg,N_prim_h2_fir,"tu",sym_color="tomato",sym_filled=2,/overplot,name="N'")
p5=plot(reg,N_prim_hi_fir,"b2tu-.",sym_color="red",sym_filled=2,/overplot)
p6=plot(reg,N_prim_tot_fir,"g2tu--",sym_color="yellow",sym_filled=2,/overplot)
p7=plot(reg,beta_h2_fir,"r2s-",sym_color="tomato",sym_filled=2,/overplot)
p7_1=plot(reg,beta_h2_fir,"s",sym_color="tomato",sym_filled=2,/overplot,name="$\beta$")
p8=plot(reg,beta_hi_fir,"b2s-.",sym_color="red",sym_filled=2,/overplot)
p9=plot(reg,beta_tot_fir,"g2s--",sym_color="yellow",sym_filled=2,/overplot)
;leg=legend(target=[p_fir,p2,p3,p1,p4_1,p7_1],position=[210,440],font_size=8,/device,/auto_text_color)


ep_fuv=errorplot(reg,N_h2_fuv,err_N_h2_fuv,"r2*-",xrange=[0,4],sym_color="tomato",title='FUV Results',name="H2",layout=[2,2,3],/current)
p1=plot(reg,N_h2_fuv,"*",sym_color="tomato",sym_filled=2,name="N",/overplot)
p2=errorplot(reg,N_HI_fuv,err_N_HI_fuv,	"b2*-.",sym_color="red",sym_filled=2,/overplot,name="HI")
p3=errorplot(reg,N_tot_fuv,err_N_tot_fuv,"g2*--",sym_color="yellow",sym_filled=2,/overplot,name="$Total Gas$")
p4=errorplot(reg,N_prim_h2_fuv,err_N_prim_h2_fuv,"r2tu-",sym_color="tomato",sym_filled=2,/overplot)
p4_1=plot(reg,N_prim_h2_fuv,"tu",sym_color="tomato",sym_filled=2,/overplot,name="N'")
p5=errorplot(reg,N_prim_hi_fuv,err_N_prim_hi_fuv,"b2tu-.",sym_color="red",sym_filled=2,/overplot)
p6=errorplot(reg,N_prim_tot_fuv,err_N_prim_tot_fuv,"g2tu--",sym_color="yellow",sym_filled=2,/overplot)
p7=errorplot(reg,beta_h2_fuv,err_beta_h2_fuv,"r2s-",sym_color="tomato",sym_filled=2,/overplot)
p7_1=plot(reg,beta_h2_fuv,"s",sym_color="tomato",sym_filled=2,/overplot,name="$\beta$")
p8=errorplot(reg,beta_hi_fuv,err_beta_hi_fuv,"b2s-.",sym_color="red",sym_filled=2,/overplot)
p9=errorplot(reg,beta_tot_fuv,err_beta_tot_fuv,"g2s--",sym_color="yellow",sym_filled=2,/overplot)
;leg=legend(target=[ep_fuv,p2,p3,p1,p4_1,p7_1],position=[190,450],font_size=8,/device,/auto_text_color)

ep_fir=errorplot(reg,N_h2_fir,err_N_h2_fir,"r2*-",xrange=[0,4],sym_color="tomato",title='FIR Results',name="H2",layout=[2,2,4],/current)
p1=plot(reg,N_h2_fir,"*",sym_color="tomato",sym_filled=1,name="N",/overplot)
p2=errorplot(reg,N_HI_fir,err_N_HI_fir,	"b2*-.",sym_color="red",sym_filled=2,/overplot,name="HI")
p3=errorplot(reg,N_tot_fir,err_N_tot_fir,"g2*--",sym_color="yellow",sym_filled=2,/overplot,name="$\beta$")
p4=errorplot(reg,N_prim_h2_fir,err_N_prim_h2_fir,"r2tu-",sym_color="tomato",sym_filled=2,/overplot)
p4_1=plot(reg,N_prim_h2_fir,"tu",sym_color="tomato",sym_filled=2,/overplot,name="N'")
p5=errorplot(reg,N_prim_hi_fir,err_N_prim_hi_fir,"b2tu-.",sym_color="red",sym_filled=2,/overplot)
p6=errorplot(reg,N_prim_tot_fir,err_N_prim_tot_fir,"g2tu--",sym_color="yellow",sym_filled=2,/overplot)
p7=errorplot(reg,beta_h2_fir,err_beta_h2_fir,"r2s-",sym_color="tomato",sym_filled=2,/overplot)
p7_1=plot(reg,beta_h2_fir,"s",sym_color="tomato",sym_filled=2,/overplot,name="$\beta$")
p8=errorplot(reg,beta_hi_fir,err_beta_hi_fir,"b2s-.",sym_color="red",sym_filled=2,/overplot)
p9=errorplot(reg,beta_tot_fir,err_beta_tot_fir,"g2s--",sym_color="yellow",sym_filled=2,/overplot)
;leg=legend(target=[ep_fir,p2,p3,p1,p4_1,p7_1],position=[190,450],font_size=8,/device,/auto_text_color)





END
