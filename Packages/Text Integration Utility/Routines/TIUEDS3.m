TIUEDS3 ; ;09/17/08
 S X=DE(12),DIC=DIE
 K ^TIU(8925,"CA",$E(X,1,30),DA)
 S X=DE(12),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"AAU",+X,+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),+DA)
 S X=DE(12),DIC=DIE
 I +$P($G(^TIU(8925,+DA,15)),U) K ^TIU(8925,"AAUP",+X,+$P($G(^TIU(8925,+DA,15)),U),+DA)
 S X=DE(12),DIC=DIE
 D KACLAU^TIUDD01(1202,X)
 S X=DE(12),DIC=DIE
 ;
