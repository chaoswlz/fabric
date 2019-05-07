#!/bin/bash
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

while :; do 
    for ((i=1; i<=100; i++)); do
        ((Num=$i %2))
        if ["$Num" == 0]; then
			peer chaincode invoke --tls --cafile ${ORDERER_CA} -C mychannel -n mycc -c '{"Args":["invoke","b","a","20"]}'
		fi
        if ["$Num" != 0]; then
			peer chaincode invoke --tls --cafile ${ORDERER_CA} -C mychannel -n mycc -c '{"Args":["invoke","a","b","20"]}'
		fi
    done
    sleep 1
done