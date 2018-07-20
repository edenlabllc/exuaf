#!/bin/bash

POSTGRES_VERSION=9.6

echo "travis TRAVIS_BUILD_NUMBER ${TRAVIS_BUILD_NUMBER}"
echo "travis TRAVIS_JOB_NUMBER ${TRAVIS_JOB_NUMBER}"
#
#echo "listen_addresses = '*'" >> /etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf
#echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/${POSTGRES_VERSION}/main/pg_hba.conf
#
#service postgresql stop
#service postgresql start ${POSTGRES_VERSION}
