echo KEYMAP=us > /etc/vconsole.conf

ln -s /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime

sed -i "s/^#en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8


echo sujan > /etc/hostname
sed -i "s/127\.0\.0\.1\tlocalhost\.localdomain\tlocalhost/127\.0\.0\.1\tlocalhost\.localdomain\tlocalhost\tsujan/g" /etc/hosts

passwd

useradd -m sujan
passwd sujan
usermod -aG wheel,storage,power,audio sujan
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

pacman -S grub efibootmgr dosfstools mtools
mkdir /boot
mkdir /boot/efi
mount /dev/nvme0n1p1 /boot/efi
sed -i 's/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub

pacman -S os-prober

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable dhcpcd.service

systemctl enable Networkmanager.service
