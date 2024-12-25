        program main
            use parameter
            use func
            use coulfunc
            use mesh 
            use system
            use variable
            use potential
            use match
            implicit none
ccccccc     
            real*8::t1,t2                   !运行时长t2-t1
            integer::i                      !循环指标
ccccccc
            namelist /pot/ v0,r0,a          !!势参数的namelist
            namelist /systems/ mass_1,mass_2,z1,z2,E,L
            namelist /meshs/ nint
ccccccc         
            call cpu_time(t1)            
ccccccc 
            open(77,file='test.in')
            read(77,nml=pot)
            read(77,nml=systems)
            read(77,nml=meshs)
ccccccc     
            allocate(z(0:nint))
            allocate(y(0:nint))
            allocate(psi(0:nint))
            allocate(V(0:nint))
            allocate(f(0:nint))
            allocate(r(0:nint))
            allocate(FC(0:L),GC(0:L))
            allocate(FCP(0:L),GCP(0:L))
ccccccc     
            KFN=0       
            XLMIN=0d0          
            mu=amu*(mass_2*mass_1)/(mass_1+mass_2)
            k2=2d0*mu*E/hbarc**2             !k^2
            k=sqrt(k2)                       !k
            eta=mu*z1*z2*e2/hbarc/hbarc/k 
            h=0.001d0/k                      !步长h
            r_0=(2d0*l)*h                    !r_0起始点
            r_1=r_0+nint*h                   !r_1终点
ccccccc     
            write(*,*) 'Ecm=',E,'MeV'
ccccccc
            do i=0,nint                     !r写在最前面
                r(i)=r_0+i*h
            end do
ccccccc     

!如果以后要用complex的potential直接在里面改成real部分和aimag部分即可
!因为define的时候是complex的
            do i=0,nint                     !V
                V(i)=gausspot(r(i),v0,r0,a)
            end do
ccccccc
!f从i=1开始取,避免从0开始取会用到r(0)=0使分母为0
            do i=1,nint                     !
                f(i)=2d0*mu*(V(i)-E)/(hbarc**2)+l*(l+1d0)/r(i)**2
            end do
!modified numerov method计算波函数(trial wf&final wf)及其导数
            z(0)=0d0                        !auxiliary wf初值
            z(1)=h                          !斜率初值取1

ccccccc    !f从i=1开始取
!得到auxiliary wf
            do i=2,nint                     
                z(i)=2d0*z(i-1)-z(i-2)+h**2*f(i-1)*z(i-1)
            end do
ccccccc 
            y(0)=0d0                        !r=0处单独给
            do i=1,nint                     !得到trial wf
                y(i)=(1d0-h**2*f(i)/12d0)*z(i) 
            end do
ccccccc    
    
!match处选择nint-2远处,使用中心四点差分
            dy=(-y(nint)+8.d0*y(nint-1)-8.d0*y(nint-3)+y(nint-4))/12d0/h
ccccccc        
       
            call COUL90(k*r(nint-2),eta,XLMIN,l,FC,GC,FCP,GCP
     &      ,KFN,IFAIL)
ccccccc
            !write(*,*) 'IFAIL=',IFAIL
            if(IFAIL /= 0 ) then
                write(*,*)"error when call coulomb function!"
            end if
ccccccc
            hlp=complex(GC(l),FC(l))
            hln=complex(GC(l),-FC(l))
            dhlp=complex(GCP(l),FCP(l))
            dhln=complex(GCP(l),-FCP(l))
ccccccc     
            !S矩阵元S_{l}                      
            Sl=(dy*hln-y(nint-2)*dhln*k)/
     &      (dy*hlp-y(nint-2)*dhlp*k)

            write(*,*) 'L=',l,',','Sl=',Sl
ccccccc
            c=(hln-Sl*hlp)*(0d0,1d0)/2d0/y(nint-2)/k
            !match point的常数
            !write(*,*) 'c=',c
ccccccc
            !复数波函数
            psi=c*y
            
ccccccc
            do i=0,nint
            write(31,*) r(i),real(y(i))   !试探解(只有实部,相当于实数)
            write(32,*) r(i),real(psi(i)) !波函数的实部
            write(33,*) r(i),aimag(psi(i))!波函数的虚部
            write(34,*) r(i),abs(psi(i))  !波函数的模
            end do
ccccccc
            deallocate(z,y,psi,V,f,r)
            deallocate(FC,GC,FCP,GCP)
            call cpu_time(t2)
            write(*,*)'运行时长:',t2-t1,'s'
        end program
