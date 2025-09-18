!--- common block for the calculation of cut efficiencies
!
!--- ntotshot : total number of shots in the run
!--- njetzero : number of shots that failed the jet cuts
!--- ncutzero : number of shots that passed the jet cuts
!--- ntotzero : total number of events that automatically
!---            returned zero weight. Should be approximately
!---            njetzero+ncutzero, with a small extra number
!---            (dependent on 'cutoff') due to 'masscuts' and 'smalls'

      integer njetzero,ncutzero,ntotzero,ntotshot
      common/efficiency/njetzero,ncutzero,ntotzero,ntotshot
      integer ntotborn,ntotquad,ntotskip
      common/efficiency/ntotborn,ntotquad,ntotskip
