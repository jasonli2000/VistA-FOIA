DICATTD9	;SFISC/GFT ;10:55 AM  26 Jan 2001;MUMPS FIELDS
	;;22.2T1;VA FILEMAN;;Dec 14, 2012
	;Per VHA Directive 2004-038, this routine should not be modified.
	;
2	S DICATT2N="K",DICATT3N=""
	S DICATT5N="K:$L(X)>245 X D:$D(X) ^DIM",DICATTLN=245
	S DICATTMN="Enter Standard MUMPS code" D CHNG
	D PUT^DDSVALF(7,,,"@","") ;no WRITE ACCESS
	Q
	;
CHNG	I DICATT5N=DICATT5 K DICATTMN ;No DICATTMN means no change
	D:$D(DICATTMN) PUT^DDSVALF(98,"DICATT",1,DICATTMN)
	Q
	;
