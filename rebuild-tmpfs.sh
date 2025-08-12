umount /build || :  # if /build exists then umount it, otherwise ignore this line
mkdir -p /build
mount -v -t tmpfs -o defaults,size=10G,mode=755 tmpfs /build;
nixos-rebuild -v --show-trace $@;  # script argument $@ should contain nixos-rebuild arguments
umount -Rv /build;  # unmount /build when done
