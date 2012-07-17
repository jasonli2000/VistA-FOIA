ONCPRE21 ;HIRMFO/WAA - Pre-INIT for Patch ONC*2.11*20;12/1/98  13:00
 ;;2.11;Oncology;**21**;Mar 07, 1995
EN1 ; This is to Delete the old 160.16 global prior to installation
 ; of the new copy of the data.
 K ^ONCO(160.16)
 K ^ONCO(160.17)
 Q
ENV ; Patch 21 check
 Q
