#!/bin/bash

JAR_FILE=/opt/wallet/Manager.jar
MAIN_CLASS=io.raspberrywallet.manager.Main

if [ -f $JAR_FILE ]; then
	/usr/bin/java -cp $JAR_FILE $MAIN_CLASS -config config.yaml
fi
