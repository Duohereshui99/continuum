        module mesh                   !积分格点相关
           implicit none
           real*8::r_0,r_1                 !径向起始点和终点
           real*8::h                       !步长
           integer::nint!=10000                  !格点数
        end module
ccccccc
        module system
            implicit none
            real*8::mass_1!=1.0078d0           !组分质量和约化质量
            real*8::mass_2!=1.0087d0!6d0             
            real*8::z1!=1d0                !带电量
            real*8::z2!=0d0                        
            real*8::E!=0.96937542942755306d0  !能量(Ecm,MeV)                                       !能量对应的波矢(及平方)变量
            integer::L!=0   
            real*8::eta                 !Sommerfeld参数
            real*8::mu  
            real*8::k,k2                !角量子数L,有时候也可以是Lmax
        end module
ccccccc     
        module potential         !!potential parameters 
            implicit none
            real*8::v0!=-72.15d0!7d0      !!gausspot势参数,没有下划线
            real*8::r0!=0d0                 
            real*8::a!=1.484d0            
        end module
ccccccc

        module match                            !用hankel做match的相关变量(包括coul90即hankel的输入参数)
            implicit none
            complex*16::dy                   !trial wf导数
            complex*16::hlp,hln,dhlp,dhln    !hankel及其一阶导数,p和n对应向外和向内
            complex*16::Sl                   !S矩阵S_l
            complex*16::c                    !match常数c
            real*8::XLMIN                    !!coul90的输入参数,L的最小值,一般从0开始
            integer::IFAIL                   !!coul90的输入参数
            integer::KFN                     !!coul90的输入参数
            !选择KFN=0 1 2以调整COUL90计算的内容,coulomb,sperical bessel,cylindrical bessel
        end module
