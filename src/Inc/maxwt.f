! --- Common block for keeping track of weights, used
! --- if unweighting is selected :
      double precision wtmax,newwt
      logical evtgen
      logical unweight
      logical skipnt
      integer nevtrequested
      common/maxwt/wtmax,newwt,nevtrequested,evtgen,skipnt,unweight

! --- Useful local variables where weights are being checked :
      double precision wtabs
