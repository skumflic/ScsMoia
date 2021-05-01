#!/bin/bash

#export LD_LIBRARY_PATH=/usr/local/sisctus4.4.1/lib/ && java -cp .:/usr/local/siscstus4.4.1/bin/sp-4.4.1/sicstus-4.4.1/bin/jasper.jar joueur pamichau $1 $2 
#export LD_LIBRARY_PATH=/usr/local/sisctus4.4.1/lib/ && 

#java -cp .:/applis/sicstus-4.3.3/lib/sicstus-4.3.3/bin/jasper.jar joueur pamichau 0 $1 $2


#####pamichau /usr/local/sicstus4.4.1/lib/sicstus-4.4.1/bin/jasper.jar

export LD_LIBRARY_PATH=/usr/local/sisctus4.4.1/lib/ && java -cp .:/usr/local/sicstus4.4.1/lib/sicstus-4.4.1/bin/jasper.jar joueur pamichau 0 $1 $2 
