ONCPRE14 ;HIRMFO/WAA - Pre-INIT for Patch ONC*2.11*12;2/28/97  13:00
 ;;2.11;Oncology;**14**;Mar 07, 1995
EN1 ; This is to Delete the old 160.2 global prior to installation
 ; of the new copy of the data.
 K ^ONCO(160.2)
 K ^ONCO(160.16)
 K ^ONCO(160.17)
 Q
