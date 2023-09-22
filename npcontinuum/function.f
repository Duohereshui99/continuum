        module func                 !!potential function
            use parameter
            implicit none
            contains                                 !!contains这个关键词很关键不然报错
            real*16 function gausspot(r,v0,r0,a) !gausspot
            real*8::r,v0,r0,a
            if (a.gt.1e-6) then
            gausspot=V0*exp(-(r-r0)**2/a**2)
            else
            write(*,*)'a too small in gausspot!'
            stop
            end if
            return
            end function gausspot
        end module