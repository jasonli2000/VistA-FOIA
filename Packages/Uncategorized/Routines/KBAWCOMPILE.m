KBAWCOMPILE ; Compile the VistACom application ; 9/23/11 8:43pm
 ;Need to change from this hard-coded scheme
 ZSY "rm ~/w/5.4-001_x8664/ewdWLvistacom*.o","rm ~/w/ewdWLvistacom*.m"
 ;Compiler _should_ KILL the following
 ;K ^zewd("comboMethod","VistACom"),^zewd("loader","vistacom"),^%zewdIndex("vistacom")
 ;K ^%zewd("relink")
 D relink^%zewdGTM,compileAll^%zewdAPI("VistACom")
 Q
