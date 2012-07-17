IBDENTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2960528.111934
 ;;0.0;
 ;;7.3;2960528.111934
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 G CONT^IBDENTE0
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
IBDEI001 ;;6779851
IBDEI002 ;;2801846
IBDEI003 ;;7467083
IBDEI004 ;;6454679
IBDEI005 ;;6972020
IBDEI006 ;;6789610
IBDEI007 ;;880726
IBDEI008 ;;2945080
IBDEI009 ;;13018425
IBDEI00A ;;13309002
IBDEI00B ;;13196678
IBDEI00C ;;13315428
IBDEI00D ;;13180359
IBDEI00E ;;12342183
IBDEI00F ;;12090966
IBDEI00G ;;11949202
IBDEI00H ;;12595402
IBDEI00I ;;11039948
IBDEI00J ;;11315993
IBDEI00K ;;12953357
IBDEI00L ;;12684451
IBDEI00M ;;12886643
IBDEI00N ;;12737595
IBDEI00O ;;12889520
IBDEI00P ;;11884475
IBDEI00Q ;;13433130
IBDEI00R ;;13694461
IBDEI00S ;;11605364
IBDEI00T ;;1377998
IBDEI00U ;;3114630
IBDEI00V ;;3991818
IBDEI00W ;;4029096
IBDEI00X ;;4049998
IBDEI00Y ;;4006228
IBDEI00Z ;;3979446
IBDEI010 ;;3997385
IBDEI011 ;;4018804
IBDEI012 ;;4029592
IBDEI013 ;;4017180
IBDEI014 ;;3976094
IBDEI015 ;;4037975
IBDEI016 ;;4082243
IBDEI017 ;;4052948
IBDEI018 ;;4051574
IBDEI019 ;;4037045
IBDEI01A ;;4113696
IBDEI01B ;;4044024
IBDEI01C ;;4031085
IBDEI01D ;;4132882
IBDEI01E ;;4088370
IBDEI01F ;;4095660
IBDEI01G ;;4042255
IBDEI01H ;;935843
IBDEI01I ;;3773440
IBDEI01J ;;3597019
IBDEI01K ;;3550409
IBDEI01L ;;3649977
IBDEI01M ;;3708731
IBDEI01N ;;3711936
IBDEI01O ;;3644059
IBDEI01P ;;3826090
IBDEI01Q ;;3791321
IBDEI01R ;;3752169
IBDEI01S ;;3662467
IBDEI01T ;;3630961
IBDEI01U ;;3876239
IBDEI01V ;;3803805
IBDEI01W ;;3736778
IBDEI01X ;;3714163
IBDEI01Y ;;3809313
IBDEI01Z ;;3582096
IBDEI020 ;;3640061
IBDEI021 ;;3816645
IBDEI022 ;;3628151
IBDEI023 ;;3612972
IBDEI024 ;;3674410
IBDEI025 ;;3628902
IBDEI026 ;;3577029
IBDEI027 ;;3793118
IBDEI028 ;;3725466
IBDEI029 ;;3952513
IBDEI02A ;;3836967
IBDEI02B ;;3667315
IBDEI02C ;;3722769
IBDEI02D ;;3595893
IBDEI02E ;;3570442
IBDEI02F ;;3640938
IBDEI02G ;;3565632
IBDEI02H ;;3642298
IBDEI02I ;;3837558
IBDEI02J ;;3674563
IBDEI02K ;;3732568
IBDEI02L ;;4027323
IBDEI02M ;;3930390
IBDEI02N ;;3808477
IBDEI02O ;;3748386
IBDEI02P ;;3859710
IBDEI02Q ;;3749859
IBDEI02R ;;3766869
IBDEI02S ;;3700984
IBDEI02T ;;3697813
IBDEI02U ;;3620894
IBDEI02V ;;3567315
IBDEI02W ;;3539928
IBDEI02X ;;3539024
IBDEI02Y ;;3689640
IBDEI02Z ;;3818625
IBDEI030 ;;3811242
IBDEI031 ;;3674766
IBDEI032 ;;3852780
IBDEI033 ;;3769503
IBDEI034 ;;3764464
IBDEI035 ;;3712585
IBDEI036 ;;3811335
IBDEI037 ;;3888795
IBDEI038 ;;3836623
IBDEI039 ;;3667395
IBDEI03A ;;3842100
IBDEI03B ;;3814970
IBDEI03C ;;3965324
IBDEI03D ;;3733834
IBDEI03E ;;3821140
IBDEI03F ;;3641565
IBDEI03G ;;3693232
IBDEI03H ;;3513442
IBDEI03I ;;3689512
IBDEI03J ;;3666407
IBDEI03K ;;3680250
IBDEI03L ;;3724434
IBDEI03M ;;3903625
IBDEI03N ;;3785518
IBDEI03O ;;3780281
IBDEI03P ;;3777940
IBDEI03Q ;;3714281
IBDEI03R ;;3811586
IBDEI03S ;;3692050
IBDEI03T ;;3725139
IBDEI03U ;;3745112
IBDEI03V ;;3767514
IBDEI03W ;;3890113
IBDEI03X ;;3905056
IBDEI03Y ;;3956147
IBDEI03Z ;;3915959
IBDEI040 ;;3914270
IBDEI041 ;;4202002
IBDEI042 ;;3752975
IBDEI043 ;;3785725
IBDEI044 ;;3779166
IBDEI045 ;;3801171
IBDEI046 ;;3915151
IBDEI047 ;;3775295
