#!/bin/bash -xeu
# Copyright (C) 2017 - Francis Deslauriers <francis.deslauriers@efficios.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

echo SSH_COMMAND="ssh -oStrictHostKeyChecking=no -i $identity_file" >> properties.txt
echo SCP_COMMAND="scp -oStrictHostKeyChecking=no -i $identity_file" >> properties.txt
echo S3_COMMAND="s3cmd -c ${WORKSPACE}/s3cfg" >> properties.txt
