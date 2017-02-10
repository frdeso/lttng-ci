#!/bin/bash -xeu
# Copyright (C) 2016 - Francis Deslauriers <francis.deslauriers@efficios.com>
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

echo 'kernel-built.txt does not exist'
echo 'So we build it'

cd "$LINUX_PATH"
sed -i "1013ichar\ nom[100];" fs/open.c
sed -i "3364ichar\ nom[100];" fs/namei.c
eval "$DEBUG_STRING"

cd -

make --directory="$LINUX_PATH" "-j$NPROC" bzImage modules
make --directory="$LINUX_PATH" INSTALL_MOD_PATH="$MODULES_INSTALL_FOLDER" modules_install

cp "$LINUX_PATH"/arch/x86/boot/bzImage "$DEPLOYDIR"/"$KERNEL_COMMIT_ID".bzImage
cp "$LINUX_PATH"/.config "$DEPLOYDIR"/"$KERNEL_COMMIT_ID".config

tar -czf "$DEPLOYDIR/$KERNEL_COMMIT_ID.linux.modules.tar.gz" -C "$MODULES_INSTALL_FOLDER/" ./

$SCP_COMMAND "$DEPLOYDIR/$KERNEL_COMMIT_ID.bzImage" "$STORAGE_USER@$STORAGE_HOST:$STORAGE_KERNEL_IMAGE"
$SCP_COMMAND "$DEPLOYDIR/$KERNEL_COMMIT_ID.config" "$STORAGE_USER@$STORAGE_HOST:$STORAGE_KERNEL_CONFIG"
$SCP_COMMAND "$DEPLOYDIR/$KERNEL_COMMIT_ID.linux.modules.tar.gz" "$STORAGE_USER@$STORAGE_HOST:$STORAGE_LINUX_MODULES"
$SCP_COMMAND "$LINUX_PATH/Module.symvers" "$STORAGE_USER@$STORAGE_HOST:$STORAGE_KERNEL_MODULE_SYMVERS"
