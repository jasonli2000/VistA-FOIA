IMRARVCK ;HIRMFO/FAI-HIV REGISTRY ARV REPORT-ADD SUMMARY ;06/12/00 15:00;
 ;;2.1;IMMUNOLOGY CASE REGISTRY;**5**;Feb 09, 1998
 ;
ADDCATS S ZNAM="" F  S ZNAM=$O(^IMR(158.7,"B",ZNAM)) Q:ZNAM=""  D ALLCAT
 Q
ALLCAT S:(IMRCAT=1)&(NAME=ZNAM) IMRONE=$P(^TMP($J,NAME),U,1),IMRONE=IMRONE+1,$P(^TMP($J,NAME),U,1)=IMRONE
 S:(IMRCAT=2)&(NAME=ZNAM) IMRTWO=$P(^TMP($J,NAME),U,2),IMRTWO=IMRTWO+1,$P(^TMP($J,NAME),U,2)=IMRTWO
 S:(IMRCAT=3)&(NAME=ZNAM) IMRTHR=$P(^TMP($J,NAME),U,3),IMRTHR=IMRTHR+1,$P(^TMP($J,NAME),U,3)=IMRTHR
 S:(IMRCAT=4)&(NAME=ZNAM) IMRFOR=$P(^TMP($J,NAME),U,4),IMRFOR=IMRFOR+1,$P(^TMP($J,NAME),U,4)=IMRFOR
 S:(IMRCAT="UNK")&(NAME=ZNAM) IMRU=$P(^TMP($J,NAME),U,5),IMRU=IMRU+1,$P(^TMP($J,NAME),U,5)=IMRU
 Q
TOTCAT S:IMRCAT=1 IMRONE=$P(^TMP("IMRALO",$J),U,1),IMRONE=IMRONE+1,$P(^TMP("IMRALO",$J),U,1)=IMRONE
 S:IMRCAT=2 IMRTWO=$P(^TMP("IMRALO",$J),U,2),IMRTWO=IMRTWO+1,$P(^TMP("IMRALO",$J),U,2)=IMRTWO
 S:IMRCAT=3 IMRTHR=$P(^TMP("IMRALO",$J),U,3),IMRTHR=IMRTHR+1,$P(^TMP("IMRALO",$J),U,3)=IMRTHR
 S:IMRCAT=4 IMRFOR=$P(^TMP("IMRALO",$J),U,4),IMRFOR=IMRFOR+1,$P(^TMP("IMRALO",$J),U,4)=IMRFOR
 S:IMRCAT="UNK" IMRU=$P(^TMP("IMRALO",$J),U,5),IMRU=IMRU+1,$P(^TMP("IMRALO",$J),U,5)=IMRU
 Q
