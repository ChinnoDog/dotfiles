# https://askubuntu.com/questions/313806/how-to-list-available-backport-upgrades
. /etc/os-release
if [ $ID == "ubuntu" ]; then
  alias apt-list-backports="aptitude search -t $(lsb_release -sc)-backports -F '%p %v -> %V' '~U ~Abackports'"
fi

