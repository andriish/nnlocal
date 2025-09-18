      integer, parameter :: sp = selected_real_kind(6)
      integer, parameter :: dp = selected_real_kind(15)
!#ifdef __NVCOMPILER
      integer, parameter :: ex = selected_real_kind(15)
      integer, parameter :: qp = selected_real_kind(15)
!#else
!      integer, parameter :: ex = selected_real_kind(18)
!      integer, parameter :: qp = selected_real_kind(33)
!#endif
      integer, parameter :: ki = qp
      
