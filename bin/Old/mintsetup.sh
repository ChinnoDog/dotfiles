#/bin/sh

#start by setting btrfs/noatime mount options, remounting, and rebalancing

sudo apt-add-repository ppa:w-rouesnel/openssh-hpn	#hpn-ssh repo
sudo add-apt-repository -y ppa:tualatrix/ppa	#ubuntu-tweak repo
sudo apt-add-repository -y ppa:stebbins/handbrake-releases  #handbrake official repo
sudo apt-get update
sudo apt-get -y install ssh ubuntu-tweak picard lyx rubygems vim-gnome inkscape p7zip-full rdesktop filezilla xsensors audacity gparted handbrake-gtk
# dropbox not included now because of issues

#sudo apt-get -y --no-install-recommends install digikam
# bad idea for now

sudo gem install taskjuggler
# should cron a job to repeat the above

mkdir /home/chinnodog/.vim
mkdir /home/chinnodog/.vim/syntax
cp /var/lib/gems/1.8/gems/taskjuggler-3.2.0/data/tjp.vim /home/chinnodog/.vim/syntax
echo augroup filetypedetect                                    >>~/.vim/filetype.vim
echo au BufNewFile,BufRead *.tjp,*.tji               setf tjp  >>~/.vim/filetype.vim
echo augroup END                                               >>~/.vim/filetype.vim
echo au! Syntax tjp          so ~/.vim/syntax/tjp.vim          >>~/.vim/syntax.vim
# VIM syntax highlighting configured

# Install calibre
sudo python -c "import sys; py3 = sys.version_info[0] > 2; u = __import__('urllib.request' if py3 else 'urllib', fromlist=1); exec(u.urlopen('http://status.calibre-ebook.com/linux_installer').read()); main(install_dir='/opt')"

# Install Crashplan
echo fs.inotify.max_user_watches=1048576 #Increase max files for live monitoring > /etc/sysctl.d/60-crashplan.conf
sudo service procps start
# Must retrieve and install Crashplan files from here
