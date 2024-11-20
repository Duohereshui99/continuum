        module variable                             !!数组分配内存(静态)的变量
            use mesh                  !里面有nint需要用
            use system                !里面有L需要用来算hankel
            implicit none 
            complex*16,allocatable::z(:)                     !z_n,auxiliary wf
            complex*16,allocatable::y(:)                     !y_n,trial wf   
            complex*16,allocatable::psi(:)                   !final scatwf
            complex*16,allocatable::V(:)                     !总势V
            complex*16,allocatable::f(:)                     !numerov的f,和势V有关 
            real*8,allocatable::r(:)                         !径向自变量r  
            real*8,allocatable::FC(:),GC(:),FCP(:),GCP(:) !coul90的计算参数
            !Coulomb函数F,G及其一阶导数,这里存的是某个位置r处不同l的,不是不同位置处的
        end module
ccccccc