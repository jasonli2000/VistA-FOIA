ORB3C2 ; slc/CLA - Routine to post-convert OE/RR 2.5 to OE/RR 3 notifications ;12/2/97  9:52 [ 04/03/97  1:41 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
 Q
POSTORB ;initiate post-inits for converting OE/RR 2.5 notification fields to OE/RR 3.0 notification parameters
 N ORBC
 S ORBC=$$GET^XPAR("SYS","ORBC CONVERSION",1,"Q")
 I +$G(ORBC)>1 D BMES^XPDUTL("Notifications already POST-converted.") Q
 D BMES^XPDUTL("POST-conversion of notifications...")
 D KILLC,PROTO,POSTRU,POSTRG,POSTPF,POSTEX
 D EN^XPAR("SYS","ORBC CONVERSION",1,"2",.ORBERR) ;2:post-convert done
 D BMES^XPDUTL("POST-conversion of notifications completed.")
 Q
KILLC ;kill then rebuild "C" x-ref
 K ^ORD(100.9,"C")
 S DIK="^ORD(100.9,",DIK(1)=".02^C" D ENALL^DIK  ;rebuild the "C" x-ref
 K DA,DIK
 Q
PROTO ;update protocols
 N ORBP1,ORBP2,ORBPX
 S DIC="^ORD(101,",DIC(0)="",X="OR EVSEND DGPM" D ^DIC Q:+Y<1  S ORBP1=+Y
 K DIC,Y,DUOUT,DTOUT
 S DIC="^ORD(101,",DIC(0)="",X="DGPM PROVIDER UPDATE EVENT" D ^DIC Q:+Y<1  S ORBP2=+Y
 S ORBPX=0 F  S ORBPX=$O(^ORD(101,ORBP1,10,ORBPX)) Q:'ORBPX  Q:(+^ORD(101,ORBP1,10,ORBPX,0)=ORBP2)
 K DIC,Y,DUOUT,DTOUT
 Q:+$G(ORBPX)>0
 S X="Adding protocol DGPM PROVIDER UPDATE EVENT as an item on protocol OR EVSEND DGPM..."
 D BMES^XPDUTL(X)
 S:'$D(^ORD(101,ORBP1,10,0)) ^ORD(101,ORBP1,10,0)="^101.01PA^^"
 S (DIE,DIC)="^ORD(101,"_ORBP1_",10,"
 F DA=1:1 Q:'$D(^ORD(101,ORBP1,10,DA,0))
 S DA(1)=ORBP1,DR=".01///DGPM PROVIDER UPDATE EVENT"
 D ^DIE
 K DIC,DIE,DA,DR,X,DTOUT
 Q
POSTRU ;post-init conversion of OE/RR 2.5 RECIPIENT USERS
 N ORBN,ORBU,ORBERR,X,ORBTOT,I,ORX
 S ORBTOT=$G(^XTMP("ORBC","USER PROCESSING FLAG",0))
 Q:+$G(ORBTOT)<1
 S XPDIDTOT=ORBTOT
 D UPDATE^XPDID(0)
 S I=0 F  S I=$O(^XTMP("ORBC","USER PROCESSING FLAG",I)) Q:I=""  D
 .D UPDATE^XPDID(I)
 .S ORX=^XTMP("ORBC","USER PROCESSING FLAG",I)
 .S ORBU=$P(ORX,U),ORBN=$P(ORX,U,2)
 .Q:'$L($G(^VA(200,ORBU,0)))
 .Q:'$L($G(^ORD(100.9,ORBN,0)))
 .Q:$L($$GET^XPAR("USR.`"_+ORBU,"ORB PROCESSING FLAG","`"_ORBN,"Q"))
 .D EN^XPAR("USR.`"_+ORBU,"ORB PROCESSING FLAG","`"_ORBN,"E",.ORBERR)
 .I +ORBERR>0 D
 ..S X="Error: "_ORBERR_" - converting USER "_$P(^VA(200,ORBU,0),U)_" to ORB PROCESSING FLAG user level for notification "_$P(^ORD(100.9,ORBN,0),U)_"!"
 ..D BMES^XPDUTL(X)
 K XPDIDTOT
 Q
POSTRG ;post-init conversion of OE/RR 2.5 RECIPIENT GROUPS
 N ORBN,ORBT,ORBERR,X,ORBTOT,I,ORX
 S ORBTOT=$G(^XTMP("ORBC","DEFAULT RECIPIENTS",0))
 Q:+$G(ORBTOT)<1
 S XPDIDTOT=ORBTOT
 D UPDATE^XPDID(0)
 S I=0 F  S I=$O(^XTMP("ORBC","DEFAULT RECIPIENTS",I)) Q:I=""  D
 .D UPDATE^XPDID(I)
 .S ORX=^XTMP("ORBC","DEFAULT RECIPIENTS",I)
 .S ORBT=$P(ORX,U),ORBN=$P(ORX,U,2)
 .Q:'$L($G(^OR(100.21,ORBT,0)))
 .Q:'$L($G(^ORD(100.9,ORBN,0)))
 .Q:$L($$GET^XPAR("OTL.`"_+ORBT,"ORB DEFAULT RECIPIENTS","`"_ORBN,"Q"))
 .D EN^XPAR("OTL.`"_+ORBT,"ORB DEFAULT RECIPIENTS","`"_ORBN,"Yes",.ORBERR)
 .I +ORBERR>0 D
 ..S X="Error: "_ORBERR_" - converting RECIPIENT GROUP "_$P(^OR(100.21,ORBT,0),U)_" to ORB DEFAULT RECIPIENTS!"
 ..D BMES^XPDUTL(X)
 K XPDIDTOT
 Q
POSTPF ;post-init conversion of OE/RR 2.5 PROCESSING FLAG
 N ORBN,ORBF,ORBERR,X,ORBTOT,I,ORX
 S ORBTOT=$G(^XTMP("ORBC","SITE PROCESSING FLAG",0))
 Q:+$G(ORBTOT)<1
 S XPDIDTOT=ORBTOT
 D UPDATE^XPDID(0)
 S I=0 F  S I=$O(^XTMP("ORBC","SITE PROCESSING FLAG",I)) Q:I=""  D
 .D UPDATE^XPDID(I)
 .S ORX=^XTMP("ORBC","SITE PROCESSING FLAG",I)
 .S ORBF=$P(ORX,U),ORBN=$P(ORX,U,2)
 .Q:ORBF=""
 .Q:'$L($G(^ORD(100.9,ORBN,0)))
 .Q:$L($$GET^XPAR("SYS","ORB PROCESSING FLAG","`"_ORBN,"Q"))
 .D EN^XPAR("SYS","ORB PROCESSING FLAG","`"_ORBN,ORBF,.ORBERR)
 .I +ORBERR>0 D
 ..S X="Error: "_ORBERR_" - converting SYSTEM to ORB PROCESSING FLAG system level for notification "_$P(^ORD(100.9,ORBN,0),U)_"!"
 ..D BMES^XPDUTL(X)
 K XPDIDTOT
 Q
POSTEX ;post-init conversion of OE/RR 2.5 EXCLUDE ATTENDING & EXCLUDE PRIMARY
 N ORBN,ORBEX,ORBXA,ORBXP,ORBNTOP,ORBPKG,ORBSYS,ORBERR,X,ORBTOT,I,ORX
 S ORBTOT=$G(^XTMP("ORBC","PROVIDER RECIPIENTS",0))
 Q:+$G(ORBTOT)<1
 S XPDIDTOT=ORBTOT
 D UPDATE^XPDID(0)
 ;
 S I=0 F  S I=$O(^XTMP("ORBC","PROVIDER RECIPIENTS",I)) Q:I=""  D
 .D UPDATE^XPDID(I)
 .S ORX=^XTMP("ORBC","PROVIDER RECIPIENTS",I)
 .S ORBXA=$P(ORX,U),ORBXP=$P(ORX,U,2),ORBNTOP=$P(ORX,U,3),ORBN=$P(ORX,U,4)
 .I '$L(ORBNTOP),(+$G(ORBXA)<1),(+$G(ORBXP)<1) Q
 .I ($L(ORBNTOP))!($L(ORBXA))!($L(ORBXP)) D
 ..S ORBPKG=$$GET^XPAR("PKG","ORB PROVIDER RECIPIENTS","`"_ORBN,"Q")
 ..;
 ..;if Notif to Phys is "All" and Pkg value doesn't contain "P":
 ..I $G(ORBNTOP)=0,$F(ORBPKG,"P")=0 S ORBPKG=ORBPKG_"P"
 ..;
 ..;if Notif to Phys is Attending only and Pkg value doesn't contain "A":
 ..I $L(ORBNTOP)>0,$F(ORBPKG,"A")=0 S ORBPKG=ORBPKG_"A"
 ..;
 ..S ORBXA=$S($G(ORBXA)=1:"A",1:"")
 ..S ORBXP=$S($G(ORBXP)=1:"P",1:"")
 ..S ORBEX=ORBXA_ORBXP
 ..Q:$L($$GET^XPAR("SYS","ORB PROVIDER RECIPIENTS","`"_ORBN,"Q"))
 ..S ORBSYS=$TR(ORBPKG,ORBEX) ;exclude attending and/or primary
 ..D EN^XPAR("SYS","ORB PROVIDER RECIPIENTS","`"_ORBN,ORBSYS,.ORBERR)
 ..I +ORBERR>0 D
 ...S X="Error: "_ORBERR_" - converting EXCLUDE ATTENDING/PRIMARY "_$P(^ORD(100.9,+ORBN,0),U)_" to ORB PROVIDER RECIPIENTS system level!"
 ...D BMES^XPDUTL(X)
 K XPDIDTOT
 Q
