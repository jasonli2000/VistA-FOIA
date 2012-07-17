YS37ENV ;DALIRMFO/MJD - YS*5.01*37 PATCH ENVIRONMENT CHECK ROUTINE ;07/18/97  5:22 PM
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
EN ; Does not prevent loading of the transport global.
 ;Environment check is done only during the install.
 QUIT:'$G(XPDENV)
 D CHECK
 D TAG
 ;
EXIT I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install Environment Check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Environment Check is Done...",80)
 K VER,RN,LN2
 QUIT
 ;
CHECK ;
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device is not defined",80),!! S XPDQUIT=2 Q
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2 Q
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2 Q
 S VER=$$VERSION^XPDUTL("MENTAL HEALTH")
 I VER'=5.01 W !,$$CJ^XLFSTR("You must have Mental Health V 5.01 Installed",80),! S XPDQUIT=2 Q
 QUIT
 ;
TAG ;
 ;--> Check for patches
 ;
 S YSPATCH=""
 F YSPATCH="XU*8.0*71","DI*21.0*44" Q:$G(XPDQUIT)=2  D LOOK
 Q
 ;
LOOK ;
 S YSMSG="Checking Your database for "_YSPATCH
 D BMES^XPDUTL(YSMSG)
 S YSP=$$PATCH^XPDUTL(YSPATCH) I 'YSP D
 .  S YSMSG1="--Patch "_YSPATCH_" has not been installed."
 .  D BMES^XPDUTL(YSMSG1)
 .  S XPDQUIT=2
 E  D BMES^XPDUTL("OK")
 QUIT
EOR ;;YS*5.01*37 PATCH ENVIRONMENT CHECK ROUTINE;;
