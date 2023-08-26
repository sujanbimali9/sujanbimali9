mkfs.ext4 /dev/nvme0n1p7
mkfs.ext4 /dev/nvme0n1p10
mkswap /dev/nvme0n1p6
swapon /dev/nvme0n1p6

mount /dev/nvme0n1p7 /mnt      
# Mount root

mkdir /mnt/home         
# Create home directory

mount /dev/nvme0n1p10 /mnt/home
 # Mount home

mkdir /mnt/boot            
 # Create boot directory

mount /dev/nvme0n1p1 /mnt/boot  
# Mount ESP

pacman -Syu

pacstrap /mnt pulseaudio pulseaudio-alsa wpa_supplicant intel-ucode linux-headers base-devel base linux-lts linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt