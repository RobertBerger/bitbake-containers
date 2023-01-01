source ../container-name.sh
IMAGE_NAME=$1

DB_DIR="/workdir/hashsvr"
PUBLIC_PORT="8687"

if [ $# -lt 1 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <docker image>" 
    echo "+ $0 reslocal/${CONTAINER_NAME}"
    exit
fi

# remove currently running containers
echo "+ ID_TO_KILL=\$(docker ps -a -q  --filter ancestor=$1)"
ID_TO_KILL=$(docker ps -a -q  --filter ancestor=$1)

echo "+ docker ps -a"
docker ps -a
echo "+ docker stop ${ID_TO_KILL}"
docker stop ${ID_TO_KILL}
echo "+ docker rm -f ${ID_TO_KILL}"
docker rm -f ${ID_TO_KILL}
echo "+ docker ps -a"
docker ps -a

echo "+ sudo chmod 666 /var/run/docker.sock"
sudo chmod 666 /var/run/docker.sock

# -t : Allocate a pseudo-tty
# -i : Keep STDIN open even if not attached
# -d : To start a container in detached mode, you use -d=true or just -d option.
# -p : publish port PUBLIC_PORT:INTERNAL_PORT
# -l : ??? without it no root@1928719827
# --cap-drop=all: drop all (root) capabilites
# start ash shell - need to start redis manually 
#echo "+ ID=\$(docker run --cap-drop=all -t -i -d -p ${PUBLIC_PORT}:6379 ${IMAGE_NAME} ash -l)" 
#ID=$(docker run --cap-drop=all -t -i -d -p ${PUBLIC_PORT}:6379 ${IMAGE_NAME} ash -l) 
#echo "+ docker pull ${IMAGE_NAME}"
#docker pull ${IMAGE_NAME}

# usage: bitbake-hashserv [-h] [-b BIND] [-d DATABASE] [-l LOG] [-u UPSTREAM] [-r]
# Hash Equivalence Reference Server. Version=1.0.0
#
# optional arguments:
#  -h, --help            show this help message and exit
#  -b BIND, --bind BIND  Bind address (default "unix://./hashserve.sock")
#  -d DATABASE, --database DATABASE
#                        Database file (default "./hashserv.db")
#  -l LOG, --log LOG     Set logging level
#  -u UPSTREAM, --upstream UPSTREAM
#                        Upstream hashserv to pull hashes from
#  -r, --read-only       Disallow write operations from clients
#
# The bind address is the path to a unix domain socket if it is prefixed with "unix://". Otherwise, it is an IP address and port in form ADDRESS:PORT. To bind to all addresses, leave the
# ADDRESS empty, e.g. "--bind :8686". To bind to a specific IPv6 address, enclose the address in "[]", e.g. "--bind [::1]:8686"

if [ ! -d ${DB_DIR} ]; then
   sudo mkdir -p ${DB_DIR}
fi

set -x
ID=$(docker run -d -v /workdir:/workdir -p ${PUBLIC_PORT}:8687 -v /var/run/docker.sock:/var/run/docker.sock ${IMAGE_NAME} --bind :8687 --database ${DB_DIR}/hashserv.db --log WARNING)
set +x

# set -x
# --> run shell in container
#docker run -it ${IMAGE_NAME} /bin/sh
#docker run -it --privileged -v /workdir:/workdir -p ${PUBLIC_PORT}:8687 -v /var/run/docker.sock:/var/run/docker.sock  ${IMAGE_NAME} /bin/sh
# <-- run shell in container
# set +x

echo "+ ID ${ID}"

# let's attach to it:
echo "+ docker attach ${ID}"
docker attach ${ID}
