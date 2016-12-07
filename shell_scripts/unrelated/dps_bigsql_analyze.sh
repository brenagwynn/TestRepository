#!/usr/bin/ksh

###############################################################################################################
# Shell Script Name: dps_bigsql_analyze.sh                                                                    #
#                                                                                                             #
# Description: This script will run analyze for all the tables                                                #
#                                                                                                             #
#                                                                                                             #
#    Name                         Date                  Modification                                          #
# -----------                   ----------      ---------------------------                                   #
# TCS Offshore                  12-DEC-15                v1.0                                                 #
###############################################################################################################

cycle_id=$1
GRP=$2
########Below Script invokes the control file##########
BIGSQL_PROFILE=`awk -F'|' '{print $13}' /home/edusrdps/dps/${GRP}/common_src_data/dps_tables_enabled.txt|head -1`
. /home/edusrdps/dps/${GRP}/biginsights/bigenv/${BIGSQL_PROFILE}.env
#######################################################

echo "Analyze script started on `date`"

if [ ! -z $ANALYZE_FLG ] && [ $ANALYZE_FLG == 'T' ] ; then
echo " ${JSQSH_HOME}/jsqsh ${BIGSQL_DB} -U ${BIGSQL_ETL_USER} -P ${BIGSQL_TGT_PASSWORD} -e -i ${DPS_BIGDYN_SQL}/dps_bigsql_analyze_${cycle_id}.sql 2>&1 "
${JSQSH_HOME}/jsqsh ${BIGSQL_DB} -U ${BIGSQL_ETL_USER} -P ${BIGSQL_TGT_PASSWORD} -e -i ${DPS_BIGDYN_SQL}/dps_bigsql_analyze_${cycle_id}.sql 2>&1
else
echo "Analyze flag is not set to true. Hence analyze has not run"
fi

echo "Analyze script ended on `date`"
