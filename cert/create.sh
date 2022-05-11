#!/bin/bash

#user=$1
#password=$2

# create CA
#openssl req \
#  -new \
#  -x509 \
#  -days 365 \
#  -keyout ca.key \
#  -out ca.crt \
#  -subj "/C=PL/L=Warsaw/CN=Certificate Authority" \
#  -passout pass:iS0qNliawf

# create truststore
#keytool -keystore <Company>.trust -alias CARoot -importcert -file ca.crt

## create keystore for user 
#keytool -genkey -keystore ${user}.key -alias ${user} -dname CN=${user} -keyalg RSA -validity 365 -storepass ${password}
#keytool -certreq -keystore ${user}.key -alias ${user} -file ${user}.unsigned.crt -storepass ${password}
#openssl x509 -req -CA $PWD/ca.crt -CAkey $PWD/ca.key -in ${user}.unsigned.crt -out ${user}.crt -days 365 -CAcreateserial -passin pass:iS0qNliawf
#keytool -import -file $PWD/ca.crt -keystore ${user}.key -alias ca -storepass ${password} -noprompt
#keytool -import -file ${user}.crt -keystore ${user}.key -alias ${user} -storepass ${password} -noprompt
#rm -f ${user}.crt ${user}.unsigned.crt
