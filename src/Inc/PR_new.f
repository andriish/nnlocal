!--- The variables R and P provide the Regular and Plus pieces associated
!--- with radiation from leg 1 (Q1(a,b,c,is) and leg 2 (Q2(a,b,c,is)
!--- In each case the parton labelling is Using the normal QM notation of putting 
!--- everything backward
!---       emitted line after emission =   a
!---       emitter before emission     =    b
!---       spectator                   =    c
!--- There is no label for he or she who is emitted.
!--- Note that in general each piece will be composed of many different
!--- dipole contributions

      double precision  T1(-1:1,-1:1,-1:1,4),T2(-1:1,-1:1,-1:1,4)
      double precision  Tp1(3,-1:1,-1:1,-1:1,4,0:2)
      double precision  Tp2(3,-1:1,-1:1,-1:1,4,0:2)
      common/RP_new/T1,T2,Tp1,Tp2
