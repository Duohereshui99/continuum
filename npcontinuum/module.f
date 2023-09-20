        module mesh                   !积分格点相关
           implicit none
           real*8::r_0,r_1                 !径向起始点和终点
           real*8::h                       !步长
           integer,parameter::nint=8000                  !格点数
        end module
ccccccc
        module system
            use parameter
            implicit none
            real*8,parameter::mass_1=1.0078d0           !组分质量和约化质量
            real*8,parameter::mass_2=1.0087d0!6d0
            real*8::mu                  
            real*8,parameter::z1=1d0                !带电量
            real*8,parameter::z2=0d0
            real*8::eta                              !Sommerfeld参数
            real*8,parameter::E=0.96937542942755306d0  !能量(Ecm,MeV)
            real*8::k,k2                            !能量对应的波矢(及平方)变量
            integer,parameter::L=0                  !角量子数L,有时候也可以是Lmax
        end module
ccccccc     
        module potpar         !!potential parameters 
            implicit none
            real*8,parameter::v0=-72.15d0!7d0      !!gausspot势参数,没有下划线
            real*8,parameter::r0=0d0                 
            real*8,parameter::a=1.484d0            
        end module
ccccccc
        module variable                             !!数组分配内存(静态)的变量
            use mesh                  !里面有nint需要用
            use system                !里面有L需要用来算hankel
            implicit none 
            complex*16::z(0:nint)                     !z_n,auxiliary wf
            complex*16::y(0:nint)                     !y_n,trial wf   
            complex*16::psi(0:nint)                   !final scatwf
            complex*16::V(0:nint)                     !总势V
            complex*16::f(0:nint)                     !numerov的f,和势V有关 
            real*8::r(0:nint)                         !径向自变量r  
            real*8::FC(0:L),GC(0:L),FCP(0:L),GCP(0:L) !coul90的计算参数
            !Coulomb函数F,G及其一阶导数,这里存的是某个位置r处不同l的,不是不同位置处的
        end module
ccccccc
        module match                            !用hankel做match的相关变量(包括coul90即hankel的输入参数)
            implicit none
            complex*16::dy                   !trial wf导数
            complex*16::hlp,hln,dhlp,dhln    !hankel及其一阶导数,p和n对应向外和向内
            complex*16::Sl                   !S矩阵S_l
            complex*16::c                    !match常数c
            real*8::XLMIN                    !!coul90的输入参数,L的最小值，一般从0开始
            integer::IFAIL                   !!coul90的输入参数
            integer::KFN                     !!coul90的输入参数
            !选择KFN=0 1 2以调整COUL90计算的内容，coulomb,sperical bessel,cylindrical bessel
        end module