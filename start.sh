#!/usr/bin/env bash

function show_help {
	echo "Option:
  -r		Run Nuclei (options -u and -t mandatory)
    -u		URL to run with nuclei
    -t		Template to run with nuclei

  -e		Environment to register findings, [prd, hml] default prd
  -k		Conviso Platform API KEY
  -p		Conviso Platform project id
  -i		Nuclei output in json format
  -h		Prints this help"
  exit 1;
}

ENVIRONMENT="prd"
NUCLEI_OUTPUT_DIR="/workspace"
NUCLEI_OUTPUT=""
TEMPLATE_DIR="${HOME}/nuclei-templates"
VERBOSE="FALSE"
COLOR="TRUE"

while getopts "hru:t:k:p:i:e:" c
do
	case $c in
		h) show_help ;;
		r) NUCLEI="TRUE" ;;
		u) URL=$OPTARG ;;
		t) TEMPLATE=$OPTARG ;;
		k) API_KEY=$OPTARG ;;
		p) PROJECT_ID=$OPTARG ;;
		i) NUCLEI_OUTPUT=$OPTARG ;;
		e) ENVIRONMENT=$OPTARG ;;
	esac
done

if [[ $API_KEY == "" || $PROJECT_ID == "" ]]; then
	show_help
fi

if [[ $NUCLEI == "TRUE" ]]; then
	if [[ $URL != "" && $TEMPLATE != "" ]]; then
		NUCLEI_OUTPUT="nuclei_output.json"
		echo "nuclei -u $URL -t ${TEMPLATE_DIR}/$TEMPLATE -j -irr -o ${NUCLEI_OUTPUT_DIR}/${NUCLEI_OUTPUT}";
		nuclei -u $URL -t ${TEMPLATE_DIR}/$TEMPLATE -j -irr -o ${NUCLEI_OUTPUT_DIR}/${NUCLEI_OUTPUT};
	else
		show_help
	fi
fi

COMMAND="ruby /electrosphere/start.rb -k $API_KEY -p $PROJECT_ID -i $NUCLEI_OUTPUT -e $ENVIRONMENT"

${COMMAND}