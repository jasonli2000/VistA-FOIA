NURCCG73 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2964,0)
 ;;=[Extra Order]^3^NURSC^11^45^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2964,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2964,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2965,0)
 ;;=[Extra Order]^3^NURSC^11^46^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2965,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2965,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2966,0)
 ;;=[Extra Order]^3^NURSC^11^47^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2966,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2966,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2967,0)
 ;;=[Extra Order]^3^NURSC^11^50^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2967,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2967,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2968,0)
 ;;=[Extra Order]^3^NURSC^11^51^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2968,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2968,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2969,0)
 ;;=[Extra Order]^3^NURSC^11^52^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2969,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2969,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2970,0)
 ;;=[Extra Order]^3^NURSC^11^53^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2970,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2970,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2971,0)
 ;;=[Extra Order]^3^NURSC^11^54^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2971,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2971,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2972,0)
 ;;=[Extra Order]^3^NURSC^11^55^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2972,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2972,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2973,0)
 ;;=[Extra Order]^3^NURSC^11^56^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2973,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2973,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2974,0)
 ;;=[Extra Order]^3^NURSC^11^57^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2974,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2974,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2975,0)
 ;;=[Extra Order]^3^NURSC^11^58^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2975,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2975,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2976,0)
 ;;=[Extra Order]^3^NURSC^11^59^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2976,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2976,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2977,0)
 ;;=[Extra Order]^3^NURSC^11^60^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2977,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2977,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2978,0)
 ;;=[Extra Order]^3^NURSC^11^61^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2978,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2978,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2979,0)
 ;;=[Extra Order]^3^NURSC^11^62^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2979,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2979,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2980,0)
 ;;=[Extra Order]^3^NURSC^11^63^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2980,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2980,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2981,0)
 ;;=[Extra Order]^3^NURSC^11^64^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2981,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2981,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2982,0)
 ;;=[Extra Order]^3^NURSC^11^65^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2982,9)
 ;;=D EN2^NURCCPU2
