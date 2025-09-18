      logical PDFerrors
      integer maxPDFsets,currentPDF
!--- 40 is my choice for the maximum number of dipoles
!--- 50 is the old choice for the maximum number of PDF error sets,
!--- that has been increased to 1000 in order to include NNPDF sets
      double precision PDFxsec(0:1000),PDFxsec_nd(0:1000,0:40)
      double precision PDFwgt(0:1000)
      common/PDFerrors/PDFerrors,maxPDFsets,PDFxsec,PDFwgt  
