 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;                                                              ;
 ;      Copyright 2001, 2004 Sanchez Computer Associates, Inc.  ;
 ;                                                              ;
 ;      This source code contains the intellectual property     ;
 ;      of its copyright holder(s), and is made available       ;
 ;      under a license.  If you do not know the terms of       ;
 ;      the license, please stop and do not read further.       ;
 ;                                                              ;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%lclcol ; ; ; Local Variable Collation Control
        ;
get()   q $v("YLCT")
getncol()       q $v("YLCT","ncol") ; return null collation order
        ;
set(lct,ncol)
        n ok,$et
        s $et="s $ec="""" s ok=0",ok=1
        if ok&$data(lct)&$data(ncol) v "YLCT":lct:ncol q ok
        if ok&$data(lct)&'$data(ncol) v "YLCT":lct:-1 q ok
        if ok&'$data(lct)&$data(ncol) v "YLCT":-1:ncol q ok
        if ok&'$data(lct)&'$data(ncol) v "YLCT":-1:-1 q ok
        q ok
