#!/usr/bin/ksh
###############################################################################################################
# Shell Script Name: dps_bigsql_col_extract.sh
#
# Description : This Script will extract cols from Target table
#
#    Name                         Date                  Modification
# -----------                   ----------      ---------------------------
# TCS Offshore                  2015-07-24      	  v1.0
#
##############################################################################################################

program=`echo $0 | cut -d'/' -f2 | cut -d"." -f1`
PROCESSDATE=`date '+%Y%m%d'`

echo "***********************************************************************"
echo "SCRIPT "$0" STARTED ON `date`"
echo "***********************************************************************"

GRP=$3
BIGSQL_PROFILE=$4

. /home/edusrdps/dps/${GRP}/biginsights/bigenv/${BIGSQL_PROFILE}.env

rm -f ${DPS_BIGTMP_DIR}/${1}_cols

${JSQSH_HOME}/jsqsh ${BIGSQL_DB} -U ${BIGSQL_ETL_USER} -P ${BIGSQL_TGT_PASSWORD} -i ${DPS_BIGSQL_DIR}/dps_bigsql_col_extract.sql  -o ${DPS_BIGTMP_DIR}/${1}_cols -v tablename=$1 -v schemaname=${BIGSQL_TGT_SCHEMA}

v_ret=$?

if [[ ${v_ret} -eq 0 ]] ; then

  echo "*******************************************************************************************"
  echo ""
  echo "Connection Successfull to ${BIGSQL_DB}"
  echo ""
  echo "*******************************************************************************************"
else
  echo "*******************************************************************************************"
  echo ""
  echo "Connection Failed to ${BIGSQL_DB}"
  echo ""
  echo "*******************************************************************************************"
  exit 1
fi

echo "***********************************************************************"
echo "SCRIPT "$0" COMPLETED ON `date`"
echo "***********************************************************************"
exit 0
