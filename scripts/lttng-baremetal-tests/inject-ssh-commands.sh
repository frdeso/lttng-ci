#!/bin/bash -xeu
echo SSH_COMMAND="ssh -oStrictHostKeyChecking=no -i $identity_file" >> properties.txt
echo SCP_COMMAND="scp -oStrictHostKeyChecking=no -i $identity_file" >> properties.txt
