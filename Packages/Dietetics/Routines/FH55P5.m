FH55P5 ;ALB/TDP - POST-INIT FOR PATCH FH*5.5*5 ;12/13/2005
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 Q
POST ;
 D BMES^XPDUTL("Searching for DIETS (#111) file entries which are out of sync with the")
 D MES^XPDUTL("   corresponding entry in the ORDERABLE ITEM (#101.43) file...")
 D DIET
 D BMES^XPDUTL("Searching for TUBEFEEDING (#118.2) file entries which are out of sync with")
 D MES^XPDUTL("   the corresponding entry in the ORDERABLE ITEM (#101.43) file...")
 D TF
 D BMES^XPDUTL("Searching for DIET PATTERN (#111.1) names which are out of sync with")
 D MES^XPDUTL("   corresponding DIET ABBREVIATED LABELS...")
 D UPDPAT
 D BMES^XPDUTL("Post-init complete.")
 Q
 ;
DIET ;
 N DIFF,FH0,FHACT,FHFILE,FHFLNM,FHIEN,FHIEN1,FHINACT
 N FHNM,FHORIEN,FHSYN,FHTYP
 K ^TMP($J,"FH55P5_nutrition"),^TMP($J,"FH55P5_order")
 S FHTYP="D"
 S FHFILE="111",FHFLNM=$P($G(^FH(111,0)),"^",1)
 S FHNM=""
 F  S FHNM=$O(^FH(111,"B",FHNM)) Q:FHNM=""  D
 . S FHIEN=""
 . F  S FHIEN=$O(^FH(111,"B",FHNM,FHIEN)) Q:FHIEN=""  D
 .. S DIFF=0
 .. S FHINACT=$G(^FH(111,+FHIEN,"I")) I FHINACT="N" S FHINACT=""
 .. S FH0=$G(^FH(111,+FHIEN,0))
 .. S FHNM=$P(FH0,U,1) I FHNM="" Q
 .. S ^TMP($J,"FH55P5_nutrition",FHNM)=FHINACT
 .. F FHIEN1=0:0 S FHIEN1=$O(^FH(111,+FHIEN,"AN",FHIEN1)) Q:FHIEN1<1  D
 ... S FHSYN=$G(^FH(111,+FHIEN,"AN",FHIEN1,0))
 ... S:'$D(^TMP($J,"FH55P5_nutrition",FHNM,FHSYN)) ^TMP($J,"FH55P5_nutrition",FHNM,FHSYN)=""
 .. S FHSYN=$P(FH0,U,2)
 .. I FHSYN'="" S:'$D(^TMP($J,"FH55P5_nutrition",FHNM,FHSYN)) ^TMP($J,"FH55P5_nutrition",FHNM,FHSYN)=""
 .. D ORDER
 .. D COMPARE
 .. I DIFF D UPDATE
 .. K ^TMP($J,"FH55P5_nutrition"),^TMP($J,"FH55P5_order")
 Q
TF ;
 N DIFF,FH0,FHACT,FHFILE,FHFLNM,FHIEN,FHIEN1,FHINACT
 N FHNM,FHORIEN,FHSYN,FHTYP
 K ^TMP($J,"FH55P5_nutrition"),^TMP($J,"FH55P5_order")
 S FHTYP="T"
 S FHFILE="118.2",FHFLNM=$P($G(^FH(118.2,0)),"^",1)
 S FHNM=""
 F  S FHNM=$O(^FH(118.2,"B",FHNM)) Q:FHNM=""  D
 . S FHIEN=""
 . F  S FHIEN=$O(^FH(118.2,"B",FHNM,FHIEN)) Q:FHIEN=""  D
 .. S DIFF=0
 .. S FHINACT=$G(^FH(118.2,+FHIEN,"I")) I FHINACT="N" S FHINACT=""
 .. S FH0=$G(^FH(118.2,+FHIEN,0))
 .. S FHNM=$P(FH0,U,1) I FHNM="" Q
 .. S ^TMP($J,"FH55P5_nutrition",FHNM)=FHINACT
 .. F FHIEN1=0:0 S FHIEN1=$O(^FH(118.2,+FHIEN,1,FHIEN1)) Q:FHIEN1<1  D
 ... S FHSYN=$G(^FH(118.2,+FHIEN,1,FHIEN1,0))
 ... S:'$D(^TMP($J,"FH55P5_nutrition",FHNM,FHSYN)) ^TMP($J,"FH55P5_nutrition",FHNM,FHSYN)=""
 .. ;S FHSYN=$P(FH0,U,2)
 .. ;I FHSYN'="" S:'$D(^TMP($J,"FH55P5_nutrition",FHNM,FHSYN)) ^TMP($J,"FH55P5_nutrition",FHNM,FHSYN)=""
 .. D ORDER
 .. D COMPARE
 .. I DIFF D UPDATE
 .. K ^TMP($J,"FH55P5_nutrition"),^TMP($J,"FH55P5_order")
 Q
ORDER ;COMPILE ORD(101.43 DATA RELATED TO DIET ORDER/TF PRODUCT
 N FHORIN,FHORNM,FHORSYN
 S FHORIEN=$O(^ORD(101.43,"ID",+FHIEN_";99FH"_FHTYP,0))
 I +FHORIEN<1 Q
 S FHORIN=$G(^ORD(101.43,FHORIEN,.1))
 I FHORIN'="" S FHORIN="Y"
 S FHORNM=$P($G(^ORD(101.43,FHORIEN,0)),U,1) I FHORNM="" S FHORNM="UNKNOWN NAME (FH55P5)"
 S ^TMP($J,"FH55P5_order",FHORNM)=FHORIN
 S FHORSYN=""
 F  S FHORSYN=$O(^ORD(101.43,FHORIEN,2,"B",FHORSYN)) Q:FHORSYN=""  D
 . S:'$D(^TMP($J,"FH55P5_order",FHORNM,FHORSYN)) ^TMP($J,"FH55P5_order",FHORNM,FHORSYN)=""
 Q
COMPARE ;COMPARE ORD(101.43 ENTRY TO FH(111 OR FH(118.2 ENTRY
 N FHINACT,FHNM,FHORIN,FHORNM,FHORSYN,FHSYN
 I '$D(^TMP($J,"FH55P5_order")) Q
 S (FHACT,FHNM,FHORNM,FHORSYN,FHSYN)=""
 S FHNM=$O(^TMP($J,"FH55P5_nutrition",FHNM))
 S FHORNM=$O(^TMP($J,"FH55P5_order",FHORNM))
 I FHNM'=FHORNM S DIFF=1
 S FHINACT=$G(^TMP($J,"FH55P5_nutrition",FHNM))
 S FHORIN=$G(^TMP($J,"FH55P5_order",FHORNM))
 I FHINACT'=FHORIN S DIFF=1 D
 . I FHINACT="Y" S FHACT=$$FMTHL7^XLFDT($$NOW^XLFDT)
 . I FHINACT'="Y" S FHACT=""
 I FHINACT=FHORIN,FHINACT="Y" D
 . S FHACT=$O(^ORD(101.43,"ID",FHIEN_";99FH"_FHTYP,0))
 . S FHACT=$G(^ORD(101.43,FHACT,.1))
 . S FHACT=$$FMTHL7^XLFDT(FHACT)
CLOOP S FHSYN=$O(^TMP($J,"FH55P5_nutrition",FHNM,FHSYN))
 S FHORSYN=$O(^TMP($J,"FH55P5_order",FHORNM,FHORSYN))
 I FHSYN'="",FHSYN=FHORSYN G CLOOP
 I FHSYN'=FHORSYN S DIFF=1
 Q
UPDATE ;FORMAT AND SEND UPDATE MESSAGE
 N CNT,FHNAM,MSG
 S CNT=1
 S MSG(CNT)="MSH|^~\&|DIETETICS|"_^DD("SITE",1)_"|||||MFN"
 ; code MFI
 S CNT=CNT+1
 S MSG(CNT)="MFI|"_FHFILE_"^"_FHFLNM_"^99DD||UPD|||NE"
 S FHNAM=""
 F  S FHNAM=$O(^TMP($J,"FH55P5_nutrition",FHNAM)) Q:FHNAM=""  D
 . S CNT=CNT+1
 . S MSG(CNT)="MFE|MUP||"_FHACT_"|^^^"_FHIEN_"^"_FHNAM_"^99FH"_FHTYP
 . S CNT=CNT+1
 . I FHTYP="D" S MSG(CNT)="ZFH|D|"_$P(FH0,U,4)_"||"_$P(FH0,U,3)
 . I FHTYP="T" S MSG(CNT)="ZFH|T|"
 . S FHSYN=""
 . F  S FHSYN=$O(^TMP($J,"FH55P5_nutrition",FHNAM,FHSYN)) Q:FHSYN=""  D
 .. S CNT=CNT+1,MSG(CNT)="ZSY|"_CNT_"|"_FHSYN
 I $D(MSG) D SEND
 Q
SEND ; Send Message to OE/RR
 D MSG^XQOR("FH ORDERABLE ITEM UPDATE",.MSG)
 D BMES^XPDUTL("   Updated ORDERABLE ITEM (#101.43) file entry #"_FHORIEN_" with data")
 D MES^XPDUTL("      for "_FHNM_" from the "_$S($G(FHTYP)="D":"DIETS (#111) file",1:"TUBEFEEDING (#118.2) file"))
 K MSG
 Q
UPDPAT ; Update Diet Pattern names
 S FLG=0 F FHDPIEN=0:0 S FHDPIEN=$O(^FH(111.1,FHDPIEN)) Q:FHDPIEN'>0  D
 .S FHFND=0,FHOLDNM=$P($G(^FH(111.1,FHDPIEN,0)),U,1),FHNEWNM=""
 .S FHDPDTS=$P($G(^FH(111.1,FHDPIEN,0)),U,2,6)
 .F FHPCE=1:1:5 D
 ..S FHDTPTR=$P(FHDPDTS,U,FHPCE) Q:FHDTPTR=""
 ..S FHNEWNM=FHNEWNM_$S(FHNEWNM="":"",1:", ")
 ..S FHNEWNM=FHNEWNM_$P($G(^FH(111,FHDTPTR,0)),U,7)
 .I FHOLDNM=FHNEWNM Q
 .S FLG=1 D BMES^XPDUTL("   Updated "_FHOLDNM_" to  "_FHNEWNM)
 .K DIE S DIE="^FH(111.1,",DA=FHDPIEN,DR=".01////^S X=FHNEWNM" D ^DIE
 Q
