#!/bin/bash

#####
#
# Monitoring plugin to check, if the Piwik version of the given URL is up to date.
#
# Copyright (c) 2017 Jan Vonde <mail@jan-von.de>
#
#
# Usage: ./check_piwik.sh -u http://example.net/piwik/ -t MYTOKEN
#
# 
# For more information visit https://github.com/janvonde/check_piwik
#####



USAGE="Usage: check_piwik -u [URL] -t [TOKEN]"

if [ $# -gt 2 ]; then
	while getopts "hu:t:"  OPCOES; do
		case $OPCOES in
			h ) echo $USAGE exit 1;;
			u ) PIWIKURL=$OPTARG;;
			t ) TOKEN=$OPTARG;;
			? ) echo $USAGE 
			     exit 1;;
			* ) echo $USAGE
			     exit 1;;
		esac
	done
else echo $USAGE; exit 3
fi


## check if needed programs are installed
type -P curl &>/dev/null || { echo "ERROR: curl is required but seems not to be installed.  Aborting." >&2; exit 1; }
type -P sed &>/dev/null || { echo "ERROR: sed is required but seems not to be installed.  Aborting." >&2; exit 1; }


## get latest piwik version from piwik api
LATESTVERSION=$(curl -s http://api.piwik.org/1.0/getLatestVersion/)


## get piwik version from given url
LOCALURL="$PIWIKURL/index.php?module=API&method=API.getPiwikVersion&format=xml&token_auth=$TOKEN"
LOCALVERSION=$(curl -s $LOCALURL | sed -n -e 's/.*<result>\(.*\)<\/result>.*/\1/p')


## output
if [ "$LOCALVERSION" == "" ]; then
  echo "Can not check for update. Local Piwik is not responding";
  exit 3
fi

if [ "$LATESTVERSION" != "$LOCALVERSION" ]; then
  echo "A new version is available: $LOCALVERSION -> $LATESTVERSION"
  exit 2
else 
  echo "Your current version $LOCALVERSION is up to date"
fi

