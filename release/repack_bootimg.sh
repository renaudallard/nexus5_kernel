#!/bin/sh
RAMV=$1
KVER=`cat ../.version`
RELV="`cat ../.version`-${RAMV}"
RELV="_FuguMod_$(date +%Y%m%d_r)${RELV}"
if [ "ZZ${RAMV}" -eq "ZZ" ]
then
	echo "No version specified"
	exit 1
else
	cd initramfs-${RAMV} || exit 1
	find . | cpio -o -H newc | lzop > ../new_initramfs.cpio.lzo
	cd ..
	abootimg --create ${HOME}/kernel${RELV}.img -k ../arch/arm/boot/zImage -f bootimg.cfg -r new_initramfs.cpio.lzo

	git tag -a r${KVER} -m r${KVER}

	cd cwm
	mv ${HOME}/kernel${RELV}.img boot.img
        zip -q -r ${HOME}/kernel${RELV}.zip boot.img META-INF || exit 1
        sha256sum ${HOME}/kernel${RELV}.zip > ${HOME}/kernel${RELV}.zip.sha256sum

	scp ${HOME}/kernel* isildur.arnor.org:public_html/nexus5/testing-${RAMV}/

	cd ..
	rm new_initramfs.cpio.lzo cwm/boot.img ${HOME}/kernel*
	
fi

