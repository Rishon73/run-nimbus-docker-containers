#!/bin/bash

echo "------------------------------------------------------------------------------------"
echo "This script accepts 1 parameter: the LeanFT version (e.g. 14.52.0)."
echo "It only works on Linux and Mac (because I'm lazy...)"
echo "It uses Maven pom files to install the jar files and long install for Selenium"
echo "It assumes the LeanFT jar files are located:"
echo "    Linux: /opt/leanft/sdk/Maven and /opt/leanft/selenium-sdk/Java"
echo "    Mac: /Applications/LeanFT/sdk/Maven and /Applications/LeanFT/Selenium SDK/Java"
echo "------------------------------------------------------------------------------------"


# Check number of script arguments - need 1 !!!
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters."
    echo "Expecting LeanFT version in the following format 14.20.0"
    echo "    "
    exit
fi

# Set environment variables
LFT_VERSION=$1
MVN_PATH=$(which mvn)
OS_TYPE=$(uname -a | awk '{print $1}')

# Check OS - Mac or Linux
if [ $OS_TYPE == "Darwin" ]; then
  echo "in Darwin land"
  SDK_MAVEN_PATH="/Applications/LeanFT/sdk/Maven"
  SDK_PATH="/Applications/LeanFT/sdk/Java"
  SELENIUM_SDK_PATH="/Applications/LeanFT/Selenium\ SDK/Java"
  APP_MODEL_CODE_GEN_PATH="/Applications/LeanFT/Tools/appmodel-code-generator/Java"


elif [ $OS_TYPE == "Linux" ]; then
  echo "in Linux zone"
  SDK_MAVEN_PATH="/opt/leanft/sdk/Maven"
  SDK_PATH=""
  SELENIUM_SDK_PATH="/opt/leanft/selenium-sdk/Java"
  APP_MODEL_CODE_GEN_PATH=""
else
  echo "This script can run on Mac or Linux. Exiting..."
  exit
fi

COMMON="com.hp.lft.common"
REPORT="com.hp.lft.report"
REPORT_BUILDER="com.hp.lft.reportbuilder"
SDK="com.hp.lft.sdk"
UNIT_TESTING="com.hp.lft.unittesting"
VERIFICATIONS="com.hp.lft.verifications"
JAVA_DOC="com.hp.lft.sdk-javadoc.jar"
SELENIUM="com.hpe.lft.selenium.jar"
APP_MODEL_MOJO="appmodel-code-generator-mojo"
APP_MODEL_HELPER="appmodel-code-generator-helper"

########################################
# 6 SDK jar files
$MVN_PATH install:install-file -Dfile=$SDK_MAVEN_PATH/$COMMON-$LFT_VERSION.jar -DpomFile=$SDK_MAVEN_PATH/$COMMON-$LFT_VERSION-pom.xml
$MVN_PATH install:install-file -Dfile=$SDK_MAVEN_PATH/$REPORT-$LFT_VERSION.jar -DpomFile=$SDK_MAVEN_PATH/$REPORT-$LFT_VERSION-pom.xml
$MVN_PATH install:install-file -Dfile=$SDK_MAVEN_PATH/$REPORT_BUILDER-$LFT_VERSION.jar -DpomFile=$SDK_MAVEN_PATH/$REPORT_BUILDER-$LFT_VERSION-pom.xml
$MVN_PATH install:install-file -Dfile=$SDK_MAVEN_PATH/$SDK-$LFT_VERSION.jar -DpomFile=$SDK_MAVEN_PATH/$SDK-$LFT_VERSION-pom.xml
$MVN_PATH install:install-file -Dfile=$SDK_MAVEN_PATH/$UNIT_TESTING-$LFT_VERSION.jar -DpomFile=$SDK_MAVEN_PATH/$UNIT_TESTING-$LFT_VERSION-pom.xml
$MVN_PATH install:install-file -Dfile=$SDK_MAVEN_PATH/$VERIFICATIONS-$LFT_VERSION.jar -DpomFile=$SDK_MAVEN_PATH/$VERIFICATIONS-$LFT_VERSION-pom.xml

# JavaDoc
$MVN_PATH install:install-file -Dfile=$SDK_PATH/$JAVA_DOC -DgroupId=com.hp.lft -DartifactId=sdk -Dclassifier=javadoc -Dversion=$LFT_VERSION -Dpackaging=jar

# Selenium SDK
$MVN_PATH install:install-file -Dfile=$SELENIUM_SDK_PATH/$SELENIUM -DgroupId=com.hpe.lft -DartifactId=selenium-sdk -Dversion=$LFT_VERSION -Dpackaging=jar

# Application Model Code Generator
$MVN_PATH install:install-file -Dfile=$APP_MODEL_CODE_GEN_PATH/$APP_MODEL_MOJO-$LFT_VERSION.jar -DpomFile=$APP_MODEL_CODE_GEN_PATH/$APP_MODEL_MOJO-$LFT_VERSION-pom.xml
$MVN_PATH install:install-file -Dfile=$APP_MODEL_CODE_GEN_PATH/$APP_MODEL_HELPER.jar -DpomFile=$APP_MODEL_CODE_GEN_PATH/$APP_MODEL_HELPER-pom.xml

########################################


#### MCUtilities #####
# $MVN_PATH install:install-file -Dfile=/home/demo/IdeaProjects/AOS_Web_LeanFT_Parellel/MCUtils/MCUtils.jar -DgroupId=com.mf -DartifactId=MCUtilities -Dversion=4.0.0 -Dpackaging=jar
