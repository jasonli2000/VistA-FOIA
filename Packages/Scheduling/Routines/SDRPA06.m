SDRPA06 ;bp-oifo/swo pait hl7 ack handling ; 10/31/04 3:53pm
        ;;5.3;Scheduling;**290,333,349,376,491**;AUG 13, 1993;Build 53
        ;routine called from Vista HL7 when ack messages are received in response
        ;to an out going HL7 message generated by protocol SC-PAIT-EVENT
ACK     ;entry point from Vista HL7
        ;ACKDATE   :  date/time ack received
        ;FLDSEP    :  field separator
        ;CMPNTSEP  :  component separator
        ;REPTNSEP  :  repetition separator
        ;ACKCODE   :  acknowledgement code
        ;ERROR     :  reject reason
        ;BATCHID   :  batch control ID
        ;BATCHIDO  :  original batch control ID
        N ACKCODE,ACKDATE,BATCHID,BATCHIDO,CMPNTSEP,ERROR,FLDSEP,REPTNSEP,RUNIEN,SDZAP,V1
        ;disable automatic repair of the last run, not needed to process acks
        ;NHD will be notified when the completion message does not come out
        ;D RSTAT^SDRPA02 ;check the status of the last run
        K ^TMP("SDRPA06",$J)
        S SDZAP=0
        S ACKDATE=$$NOW^XLFDT()
        S FLDSEP=HL("FS")
        S CMPNTSEP=$E(HL("ECH"),1)
        S REPTNSEP=$E(HL("ECH"),2)
        S ACKCODE=$P(HLMSA,FLDSEP)
        S ERROR=$P(HLMSA,FLDSEP,4)
        S (BATCHID,BATCHIDO)=$P(HLMSA,FLDSEP,2)
        S RUNIEN=$$RUNIEN(BATCHIDO) Q:'RUNIEN
        S BATCHID=$$OURB(RUNIEN,BATCHIDO) ;convert to our batch id
        Q:'BATCHID  ;error needs to be handled
        ;S V1=$O(^SDWL(409.6,"AMSG",BATCHID,"")),RUNIEN=$O(^SDWL(409.6,"AMSG",BATCHID,V1,""))
        S V1=$O(^SDWL(409.6,"AMSG",BATCHID,"")) Q:V1=""
        Q:'$$DUP^SDRPA02(RUNIEN,BATCHIDO)  ;check for duplicate
        S ^XTMP("SDRPA-"_BATCHID,0)=$$FMADD^XLFDT($$DT^XLFDT(),3)_"^"_$$DT^XLFDT() ;set xtmp global for diagnostics
        I $E(ACKCODE,1,2)="AR" D AR(BATCHID,BATCHIDO),MSG(BATCHIDO,3,RUNIEN,BATCHID) Q  ;whole batch rejection
        ;Q:($E(ACKCODE,1,2)'="AA")  ;quit if not a application ack
        ;will only be 2 ACKCODEs AA and AE so don't have to screen anymore
        F  X HLNEXT Q:(HLQUIT'>0)  D  ;start looping the msg text
        . Q:($E(HLNODE,1,3)'="MSA")  ;skip if not a MSA segment
        . I $P(HLNODE,FLDSEP,2)="AE" D  ;it's an error
        .. Q:($P($P(HLNODE,FLDSEP,3),"-",2))=""  ;no message number
        .. S ^TMP("SDRPA06",$J,+$P($P(HLNODE,FLDSEP,3),"-",2))=+$P(HLNODE,"^",4) ;set xref with message #
        I '$D(^TMP("SDRPA06",$J)) D AA(BATCHID,BATCHIDO),MSG(BATCHIDO,2,RUNIEN,BATCHID) Q  ;whole batch accept
        D AAAR(BATCHID,BATCHIDO),MSG(BATCHIDO,1,RUNIEN,BATCHID) ;batch accept with errors
        Q
AR(BATCH,BATCHIDO)      ;whole batch rejection
        ;BATCH    :  originating batch number
        ;BATCHIDO :  original batch number from HL7 ACK
        ;V1       :  sequence #  (individual message number in batch)
        ;V2       :  run #       (ien of multiple entry)
        ;V3       :  ien         (ien in patient multiple)
        ;V4       :  ien         (ien batch tracking multiple)
        Q:($G(BATCH)="")
        N DA,DIE,DR,V1,V2,V3,V4,ZNODE
        S V1=0
        F  S V1=$O(^SDWL(409.6,"AMSG",BATCH,V1)) Q:'V1  D
        . S V2=$O(^SDWL(409.6,"AMSG",BATCH,V1,"")) Q:'V2
        . ;batch tracking enhancement
        . S V4=$O(^SDWL(409.6,V2,2,"B",BATCHIDO,"")) Q:'V4  D
        .. S DA=V4,DA(1)=V2,DIE="^SDWL(409.6,"_V2_",2,",DR=".04///"_$$NOW^XLFDT_";.05///"_ACKCODE
        .. D ^DIE K DIE
        . S V3=0 F  S V3=$O(^SDWL(409.6,"AMSG",BATCH,V1,V2,V3)) Q:'V3  D
        .. S ZNODE=$G(^SDWL(409.6,V2,1,V3,0)) Q:ZNODE=""
        .. ;4TH PIECE IS MESSAGE NUMBER
        .. S DA=V3,DA(1)=V2,DIE="^SDWL(409.6,"_V2_",1,"
        .. S DR="7////"_$O(^SCPT(404.472,"B","R","")) D ^DIE
        .. I $D(^SDWL(409.6,"AE","Y",V2,V3)) Q
        .. I $D(^SDWL(409.6,"AE","N",V2,V3)) D
        ... S DR="4///Y" D ^DIE
        Q
AA(BATCH,BATCHIDO)      ;whole batch accept
        ;if the batch is accepted and no rejections then get the run # sequence #
        ;from AMSG xref.  If no "AE","Y" xref then call DIK to delete the entry
        ;BATCH    :  originating batch number
        ;BATCHIDO :  original batch number from HL7 ACK
        ;V1       :  sequence #  (individual message number in batch)
        ;V2       :  run #       (ien of multiple entry)
        ;V3       :  ien         (ien in patient multiple)
        ;V4       :  ien         (ien batch tracking multiple)
        Q:($G(BATCH)="")
        N DA,DIK,DR,V1,V2,V3,V4,ZNODE
        S V1=0
        F  S V1=$O(^SDWL(409.6,"AMSG",BATCH,V1)) Q:'V1  D
        . S V2=$O(^SDWL(409.6,"AMSG",BATCH,V1,"")) Q:'V2
        . ;batch tracking enhancement
        . S V4=$O(^SDWL(409.6,V2,2,"B",BATCHIDO,"")) Q:'V4  D
        .. S DA=V4,DA(1)=V2,DIE="^SDWL(409.6,"_V2_",2,",DR=".04///"_$$NOW^XLFDT_";.05///"_ACKCODE
        .. D ^DIE K DIE
        . S V3=0 F  S V3=$O(^SDWL(409.6,"AMSG",BATCH,V1,V2,V3)) Q:'V3  D
        .. S ZNODE=$G(^SDWL(409.6,V2,1,V3,0)) Q:ZNODE=""
        .. ;4th piece is the message #
        .. I '$D(^SDWL(409.6,"AE","Y",V2,V3)) D
        ... S DIK="^SDWL(409.6,"_V2_",1,"
        ... S DA(1)=V2,DA=V3 D ^DIK
        ... S ^XTMP("SDRPA-"_BATCH,+$P(ZNODE,"^",4),0)=ZNODE ;diagnostics
        Q
AAAR(BATCH,BATCHIDO)    ;batch accept with errors
        ;BATCH    :  originating batch number
        ;BATCHIDO :  original batch number from HL7 ACK
        ;V1       :  sequence #  (individual message number in batch)
        ;V2       :  run #       (ien of multiple entry)
        ;V3       :  ien         (ien in patient multiple)
        ;V4       :  ien         (ien batch tracking multiple))
        Q:($G(BATCH)="")
        N DA,DIK,DR,V1,V2,V3,V4,ZNODE
        S V1=0
        F  S V1=$O(^SDWL(409.6,"AMSG",BATCH,V1)) Q:'V1  D
        . S V2=$O(^SDWL(409.6,"AMSG",BATCH,V1,"")) Q:'V2
        . ;batch tracking enhancement
        . S V4=$O(^SDWL(409.6,V2,2,"B",BATCHIDO,"")) Q:'V4  D
        .. S DA=V4,DA(1)=V2,DIE="^SDWL(409.6,"_V2_",2,",DR=".04///"_$$NOW^XLFDT_";.05///"_ACKCODE
        .. D ^DIE K DIE
        . S V3=0 F  S V3=$O(^SDWL(409.6,"AMSG",BATCH,V1,V2,V3)) Q:'V3  D
        .. S ZNODE=$G(^SDWL(409.6,V2,1,V3,0)) Q:ZNODE=""
        .. ;4th piece is the message #
        .. ;next line screens for accepted batch + accepted message + status final and can be deleted
        .. I '$D(^SDWL(409.6,"AE","Y",V2,V3))&('$D(^TMP("SDRPA06",$J,$P(ZNODE,"^",4)))) D
        ... S DIK="^SDWL(409.6,"_V2_",1,"
        ... S DA(1)=V2,DA=V3 D ^DIK
        ... S ^XTMP("SDRPA-"_BATCH,+$P(ZNODE,"^",4),0)=ZNODE ;diagnostics
        .. ;next line screens for accepted batch + error message
        .. I $D(^TMP("SDRPA06",$J,$P(ZNODE,"^",4))) D
        ... S DA=V3,DA(1)=V2,DIE="^SDWL(409.6,"_V2_",1,"
        ... S DR="7////"_$O(^SCPT(404.472,"B",$G(^TMP("SDRPA06",$J,$P(ZNODE,"^",4))),"")) D ^DIE
        ... I $D(^SDWL(409.6,"AE","Y",V2,V3)) Q
        ... I $D(^SDWL(409.6,"AE","N",V2,V3)) D
        .... S DR="4///Y" D ^DIE
        Q
CLEAN(RUN)      ;housekeeping
        ;clean up batch previous to current one by checking for "AE",("S" or "R") xref and
        ;deleting if entry in xref exists
        ;RUN  :  run #           (ien of multiple entry)
        ;V1   :  previous run #  (ien of multiple entry)
        ;V2   :  ien           (ien in multiple)
        Q:($G(RUN)="")
        N V1,V2,V3
        S V1=$O(^SDWL(409.6,RUN),-1) Q:'V1
        F V3="R","S" S V2=0 F  S V2=$O(^SDWL(409.6,"AE",V3,V1,V2)) Q:'V2  D
        . S ZNODE=$G(^SDWL(409.6,V1,1,V2,0))
        . S DIK="^SDWL(409.6,"_V1_",1,"
        . S DA(1)=V1,DA=V2 D ^DIK
        . S ^XTMP("SDRPA-"_$P(ZNODE,"^",3),"CLEAN",+$P(ZNODE,"^",4),0)=ZNODE ;diagnostics
        Q
MSG(BATCHIDO,TYPE,RUNIEN,BATCHID)       ;acknowledgement notification to mail group
        ;BATCHID :  Our Message ID
        ;BATCHIDO:  Batch Control ID
        ;TYPE    :  type of message (accept with rejects - 1, whole accept 2, whole reject -3)
        ;RUNIEN  :  run ien associated with this batch
        ;SDAMX   :  message text array
        ;XMSUB   :  subject
        ;XMY     :  addressee
        ;XMTEXT  :  location of text array
        ;XMDUZ   :  sender of the message
        ;RUNZ    :  zero node of run associated with this batch
        N RUNZ,SDAMX,V0,V1,V2,V3,XMSUB,XMY,XMTEXT,XMDUZ
        Q:BATCHID=""
        L +^SDWL(409.6,RUNIEN,2,0)
        S V0=$P($G(^SDWL(409.6,RUNIEN,2,0)),"^",4)
        S (V1,V3)=0 F  S V1=$O(^SDWL(409.6,RUNIEN,2,V1)) Q:'V1  D
        . S:$P($G(^SDWL(409.6,RUNIEN,2,V1,0)),"^",4)'="" V3=V3+1
        L -^SDWL(409.6,RUNIEN,2,0)
        S RUNZ=$G(^SDWL(409.6,RUNIEN,0))
        S XMSUB="PAIT BATCH ACKNOWLEGEMENT "_BATCHIDO
        S XMY("G.SD-PAIT")=""
        S XMY("S.SD-PAIT-SERVER@FORUM.VA.GOV")=""
        S XMTEXT="SDAMX("
        S XMDUZ="POSTMASTER"
        I TYPE=1 D
        . S SDAMX(1)="  Station Number: "_$P($$SITE^VASITE(),"^",3)
        . S SDAMX(2)="Batch Control ID: "_BATCHIDO
        . S SDAMX(3)="      Message ID: "_BATCHID
        . S SDAMX(4)="       Log Entry: "_RUNIEN
        . S SDAMX(5)="        Run Date: "_$$FMTE^XLFDT($P(RUNZ,"^",7))
        . S SDAMX(6)="          Status: Acknowledged - with rejections "
        . S SDAMX(7)="                  "_V3_" of "_V0_" ACKs received for this run date"
        . S SDAMX(8)=""
        . S SDAMX(9)="Use option SD-PAIT REJECTED  Rejected Transmissions to view the rejections."
        I TYPE=2 D
        . S SDAMX(1)="  Station Number: "_$P($$SITE^VASITE(),"^",3)
        . S SDAMX(2)="Batch Control ID: "_BATCHIDO
        . S SDAMX(3)="      Message ID: "_BATCHID
        . S SDAMX(4)="       Log Entry: "_RUNIEN
        . S SDAMX(5)="        Run Date: "_$$FMTE^XLFDT($P(RUNZ,"^",7))
        . S SDAMX(6)="          Status: Acknowledged - No Rejections"
        . S SDAMX(7)="                  "_V3_" of "_V0_" ACKs received for this run date"
        I TYPE=3 D
        . S SDAMX(1)="  Station Number: "_$P($$SITE^VASITE(),"^",3)
        . S SDAMX(2)="Batch Control ID: "_BATCHIDO
        . S SDAMX(3)="      Message ID: "_BATCHID
        . S SDAMX(4)="       Log Entry: "_RUNIEN
        . S SDAMX(5)="        Run Date: "_$$FMTE^XLFDT($P(RUNZ,"^",7))
        . S SDAMX(6)="          Status: Acknowledged - Entire Batch Rejected"
        . S SDAMX(7)="                  "_V3_" of "_V0_" ACKs received for this run date"
        D ^XMD
        Q
OURB(RUNIEN,BATCHIDO)   ;match batch id to msg control id ("AMSG" xref)
        ;RUNIEN     :  the ien in file 409.6 of the run
        ;BATCHIDO   :  batchid pulled from the ACK message
        ;V2         :  returns 0 if none, or msg control id
        N V1,V2,VNODE
        S V2=0
        I '$G(RUNIEN) Q V2
        I '$G(BATCHIDO) Q V2
        I $G(^SDWL(409.6,RUNIEN,2,0))="" Q V2
        S V1=0 F  S V1=$O(^SDWL(409.6,RUNIEN,2,"B",BATCHIDO,V1)) Q:'V1  D
        . S VNODE=$G(^SDWL(409.6,RUNIEN,2,V1,0)) Q:VNODE=""
        . I $P(VNODE,"^",3)="" Q
        . S V2=$P(VNODE,"^",3) Q
        Q V2
RUNIEN(BATCHID) ;get runien
        N V1,V2
        S V2=0
        S V1=999999999 F  S V1=$O(^SDWL(409.6,V1),-1) Q:'V1!(V2)  D
        . I $O(^SDWL(409.6,V1,2,"B",BATCHID,"")) S V2=V1 Q
        Q V2
