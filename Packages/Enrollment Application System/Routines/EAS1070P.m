EAS1070P        ;ALB/AMA - Patch EAS*1.0*70 Post-Install Utility Routine ; 2/6/09 1:37pm
        ;;1.0;ENROLLMENT APPLICATION SYSTEM;**70**;Mar 15, 2001;Build 26
        Q
EN      ;
        ;Check to see how much of this routine has already executed
        N START,EASIEN,EASPP S START=0
        S EASIEN=$O(^EAS(711,"AB","CHILD1 FARM OR BUSINESS INCOME","")) Q:'EASIEN
        I $G(^EAS(711,EASIEN,1))="0^0^0" S START=1
        S EASIEN=+$$KEY711^EASEZU1("APPLICANT COUNTRY")
        I EASIEN'=.1 S START=2
        S EASAPP=$P(^EAS(712,0),U,3)
        I (EASIEN'=.1),$D(^EAS(712,+EASAPP,10,"B",EASIEN)) Q
        ;
        I START<1 D UPDATE
        I START<2 D ADDFLDS
        I START<3 D ADDCTRY
        Q
UPDATE  ;Update the 1010 Mapping File (#711) with numerous changes
        N LINE,CHGS,OLDNM,NEWNM,FSF,DISPNM,NEWHLP,FOUND,DIC,X,TEMP,Y,DIE,DR
        W !!,"Updating the 1010 Mapping (#711) File..."
        F LINE=1:1 S CHGS=$T(CHANGES+LINE) Q:($P(CHGS,";",3)="END")  D
        . ;FORMAT= OLD NAME;NEW NAME;NEW FILE^SUBFILE^FIELD;NEW DISPLAY LABEL;NEW HELP ROUTINE;
        . S OLDNM=$P(CHGS,";",3),NEWNM=$P(CHGS,";",4),FSF=$P(CHGS,";",5)
        . S DISPNM=$P(CHGS,";",6),NEWHLP=$P(CHGS,";",7),FOUND=0
        . ;
        . S DIC="^EAS(711,",DIC(0)="M",X=OLDNM D ^DIC
        . I +Y=-1 D
        . . S TEMP=$E(OLDNM,1,30),(DA,FOUND)=0
        . . F  S DA=$O(^EAS(711,"B",TEMP,DA)) Q:'DA!FOUND  D
        . . . I $P(^EAS(711,DA,0),"^")=OLDNM S FOUND=DA
        . I (+Y=-1),'FOUND Q
        . I FOUND S Y=FOUND
        . ;
        . S DA=+Y,DIE=DIC
        . ;
        . I NEWNM]"" S DR=".01///"_NEWNM D ^DIE
        . I FSF]"" F X=2,3,4 S DR=X_"///"_$P(FSF,"^",(X-1)) D ^DIE
        . I DISPNM]"" S DR="5///"_DISPNM D ^DIE
        . I NEWHLP]"" S DR="6///"_NEWHLP D ^DIE
        ;
        W "  DONE!"
        Q
ADDFLDS ;Add new 1010 Mapping File (711) fields APPLICANT
        ;PROVINCE, APPPLICANT COUNTRY, AND APPLICANT POSTAL CODE
        N X,EASIEN,DINUM,DIC,DIE,DLAYGO,ACTIVE,VERSION,FILE,SUB,EASKEY,FIELD,DISPLAY,TRNSFRM
        W !!,"Adding APPLICANT PROVINCE, APPLICANT POSTAL CODE, and"
        W !,"APPLICANT COUNTRY fields to the 1010 Mapping (#711) File..."
        F X="APPLICANT PROVINCE","APPLICANT POSTAL CODE","APPLICANT COUNTRY" D
        . S EASIEN=+$$KEY711^EASEZU1(X)
        . I EASIEN'=.1 Q
        . S (EASIEN,DINUM)=$O(^EAS(711,99999999),-1)+1
        . S (DIC,DIE)="^EAS(711,",DIC(0)="L",DLAYGO=""
        . K DD,DO D FILE^DICN
        . S ACTIVE="A",VERSION="3.0",(FILE,SUB)=2
        . I X="APPLICANT PROVINCE" D
        . . S EASKEY="I;9F.",FIELD=.1171,DISPLAY="Province"
        . I X="APPLICANT POSTAL CODE" D
        . . S EASKEY="I;9G.",FIELD=.1172,DISPLAY="Postal Code"
        . I X="APPLICANT COUNTRY" D
        . . S EASKEY="I;9H.",FIELD=.1173,DISPLAY="Country",TRNSFRM="S EASRTR=$$COUNTRY^EASEZT1(EZDATA)"
        . S DA=EASIEN,DR=".1///^S X=EASKEY;1///^S X=ACTIVE;1.2///^S X=VERSION;2///^S X=FILE;3///^S X=SUB;4///^S X=FIELD;5///^S X=DISPLAY;"
        . I $G(TRNSFRM)]"" S DR=DR_"10///^S X=TRNSFRM;"
        . D ^DIE
        W "  DONE!"
        Q
ADDCTRY ;Loop through all existing Holding File (712) applications
        ;and add the APPLICANT COUNTRY field entry
        N KEYIEN,EASAPP,X,EASKEY,EASDATA,EASIEN
        N DINUM,DIC,DIE,DLAYGO,DA,DR,MULTIPLE,ACCEPT
        W !!,"Populating APPLICANT COUNTRY fields with 'USA' in all existing applications..."
        S KEYIEN=+$$KEY711^EASEZU1("APPLICANT COUNTRY")
        S EASAPP=0 F  S EASAPP=$O(^EAS(712,EASAPP)) Q:'EASAPP  D
        . I '$D(^EAS(712,EASAPP,10,"B",KEYIEN)) D
        . . S X=KEYIEN,EASKEY="I;9H.",EASDATA="USA"
        . . S (EASIEN,DINUM)=$O(^EAS(712,EASAPP,10,"B"),-1)+1
        . . S (DIC,DIE)="^EAS(712,EASAPP,10,",DIC(0)="L",DLAYGO=""
        . . S DA(1)=EASAPP,DIC("P")=$P(^DD(712,10,0),U,2)
        . . K DD,DO D FILE^DICN
        . . S DA=EASIEN,DR(1)="10;",MULTIPLE=1,ACCEPT=1
        . . S DR=".1///^S X=MULTIPLE;1///^S X=EASDATA;1.1///^S X=ACCEPT;"
        . . D ^DIE
        W "  DONE!",!!
        Q
CHANGES ;FORMAT = OLD NAME;NEW NAME;NEW FILE^SUBFILE^FIELD;NEW DISPLAY LABEL;NEW HELP ROUTINE;
        ;;CHILD1 GROSS ANNUAL INCOME;CHILD1 EMPLOYMENT INCOME;0^0^0;Employment Inc.(Ch+);;
        ;;APPLICANT OTHER INCOME;APPLICANT OTHER INCOME AMOUNTS;;;D H08^EASEZDD2;
        ;;SPOUSE OTHER INCOME;SPOUSE OTHER INCOME AMOUNTS;;;D H08^EASEZDD2;
        ;;CHILD1 OTHER INCOME;CHILD1 OTHER INCOME AMOUNTS;0^0^0;;;
        ;;APPLICANT MEDICAL EXPENSES;APPLICANT TOTAL NON-REIMBURSED MEDICAL EXPENSES;;NonReimb. Med. Exp.;;
        ;;APPLICANT FUNERAL EXPENSES;;;;D H102^EASEZDD2;
        ;;APPLICANT CASH IN BANK;;;;D H201^EASEZDD2;
        ;;SPOUSE CASH IN BANK;;;;D H201^EASEZDD2;
        ;;APPLICANT REAL PROPERTY LESS MORTGAGES;APPLICANT LAND/BLDGS. LESS MORTGAGES;;Land/Bldgs.;D H203^EASEZDD2;
        ;;SPOUSE REAL PROPERTY LESS MORTGAGES;SPOUSE LAND/BLDGS. LESS MORTGAGES;;Land/Bldgs. (Sp.);D HD203^EASEZDD2;
        ;;APPLICANT STOCKS BONDS ASSETS LESS DEBTS;APPLICANT OTHER PROPERTY, ASSETS LESS AMT. OWED;;;D H204^EASEZDD2;
        ;;SPOUSE STOCKS BONDS ASSETS LESS DEBTS;SPOUSE OTHER PROPERTY, ASSETS LESS AMT. OWED;;;D H204^EASEZDD2;
        ;;APPLICANT FARM OR BUSINESS INCOME;;;;D H17^EASEZDD2;
        ;;SPOUSE FARM OR BUSINESS INCOME;;;;D H17^EASEZDD2;
        ;;CHILD(N) GROSS ANNUAL INCOME;CHILD(N) EMPLOYMENT INCOME;; Employment Income;D H14^EASEZDD2;
        ;;CHILD(N) FARM/BUS INCOME;;;;D H17^EASEZDD2;
        ;;CHILD(N) OTHER INCOME;CHILD(N) OTHER INCOME AMOUNTS;;;D H08^EASEZDD2;
        ;;ASSET(N) CHILD CASH;ASSET(N) CASH IN BANK;408.21^408.21^2.01;;D H201^EASEZDD2;
        ;;ASSET(N) CHILD REAL PROPERTY;ASSET(N) LAND/BLDGS. LESS MORTGAGES;408.21^408.21^2.03; Land/Bldgs.;D HD203^EASEZDD2;
        ;;ASSET(N) CHILD OTHER PROPERTY;ASSET(N) OTHER PROPERTY, ASSETS LESS AMT. OWED;408.21^408.21^2.04;;D H204^EASEZDD2;
        ;;CHILD1 REAL PROPERTY LESS MORTGAGES;CHILD1 LAND/BLDGS. LESS MORTGAGES;;Land/Bldgs. (Ch+);;
        ;;CHILD1 STOCKS BONDS ASSETS LESS DEBTS;CHILD1 OTHER PROPERTY, ASSETS LESS AMT. OWED;;;;
        ;;APPLICANT GROSS ANNUAL INCOME2;APPLICANT EMPLOYMENT INCOME;;Employment Income;D H14^EASEZDD2;
        ;;SPOUSE GROSS ANNUAL INCOME2;SPOUSE EMPLOYMENT INCOME;;Employment Inc. (Sp);D H14^EASEZDD2;
        ;;CHILD1 GROSS ANNUAL INCOME2;;0^0^0;Employment Inc.(Ch+);;
        ;;CHILD1 FARM OR BUSINESS INCOME;;0^0^0;;;
        ;;END;END;;;;
