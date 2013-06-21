DOKKU_REPO=${DOKKU_REPO:-"https://github.com/progrium/dokku.git"}
DOKKU_STACK=${DOKKU_STACK:-"https://s3.amazonaws.com/progrium-dokku/progrium_buildstep.tgz"}

echo "Bootstrapping Dokku"
echo "  Using source files from $DOKKU_REPO"
echo "  Using dokku stack from $DOKKU_STACK"

apt-get install -y linux-image-extra-`uname -r` software-properties-common
add-apt-repository -y ppa:dotcloud/lxc-docker
apt-get update && apt-get install -y lxc-docker git ruby nginx make dnsutils

cd ~ && git clone ${DOKKU_REPO}
cd dokku && make install
if [[ $DOKKU_STACK ]]; then
  curl "$DOKKU_STACK" | gunzip -cd | docker import - progrium/buildstep
else
  cd buildstep && make build
fi

/etc/init.d/nginx start
start nginx-reloader

[[ $(dig +short $HOSTNAME) ]] && HOSTFILE=DOMAIN || HOSTFILE=HOSTNAME
echo $HOSTNAME > /home/git/$HOSTFILE

echo
echo "Be sure to upload a public key for your user:"
echo "  cat ~/.ssh/id_rsa.pub | ssh root@$HOSTNAME \"gitreceive upload-key progrium\""
