ABS1NTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;MAR 15, 1995@10:25:33
 ;;0.0;;**3**;
 ;;7.2;MAR 15, 1995@10:25:33
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
ABS1I001 ;;7818523
ABS1I002 ;;11408865
ABS1I003 ;;9013926
ABS1I004 ;;7013301
ABS1I005 ;;6856879
ABS1I006 ;;6562577
ABS1I007 ;;7257517
ABS1I008 ;;8466069
ABS1I009 ;;6759463
ABS1I00A ;;7317383
ABS1I00B ;;11007322
ABS1I00C ;;13774494
ABS1I00D ;;1536787
ABS1I00E ;;4618135
ABS1I00F ;;5711328
ABS1I00G ;;6541495
ABS1I00H ;;6090366
ABS1I00I ;;6687339
ABS1I00J ;;6105344
ABS1I00K ;;6693282
ABS1I00L ;;6610834
ABS1I00M ;;6798520
ABS1I00N ;;5597746
ABS1I00O ;;4188913
ABS1I00P ;;8419860
ABS1I00Q ;;7945402
ABS1I00R ;;5838561
ABS1I00S ;;2809650
ABS1INI1 ;;4907915
ABS1INI2 ;;5232473
ABS1INI3 ;;16804694
ABS1INI4 ;;3357645
ABS1INI5 ;;1081187
ABS1INIS ;;2202077
ABS1INIT ;;10273649
ABS1PRE ;;802722
ABS1PST ;;1572831
ABSVL ;;13264067
ABSVLS ;;2632193
ABSVMT ;;4642544
ABSVNIT2 ;;7665450
ABSVSERV ;;9555552
ABSVSITE ;;11694572
ABSVTP2 ;;15868345
ABSVTPR ;;15703530
ABSVTPR1 ;;12810268
ABSVVIEW ;;4370885
