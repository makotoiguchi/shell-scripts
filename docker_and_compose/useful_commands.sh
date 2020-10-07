########## LOGS

# Go to docker-compose.yml folder
cd <docker-compose.yml_folder>
 
# Export logs:
docker-compose logs > all.log
   # the logs are not sorted by timestamp, but by app

docker-compose logs SERVICE > log_SERVICE.log
 
# check latest lines
docker-compose logs --tail=1000 SERVICE
 
# "tail -f"
docker-compose logs -f SERVICE
 
# combinig
docker-compose logs --tail=100 -f SERVICE
 
# Remove color
sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" log_SERVICE.log > log_SERVICE.nocolor.log
 
# less with color
less -R iec.log
docker-compose logs SERVICE | less -R


########## Start, Stop, ...

# all running containers
docker ps
# include stopped containers
docker ps -a

# docker-compose.yml running containers
docker-compose ps

## 
# create and start containers, attached
docker-compose up
# dettached 
docker-compose up -d
# service
docker-compose up SERVICE

# start containers
docker-compose start

##
# stop containers 
docker-compose stop
# service
docker-compose stop SERVICE


########## REMOVING

# remove container
docker container rm CONTAINER
# all containers
docker container prune 

# remove image
docker image rm IMAGE
# all images
docker image prune -a


########## CHECKS

##
# containers list
docker container ls

# images list
docker image ls

##
# running process
docker-compose top
# of a service
docker-compose top SERVICE

# top (live)
docker stats
# per container (not service)
docker stats CONTAINER
# top snapshot
docker stats --no-stream

##
# executing commands inside container
docker exec -it CONTAIENR COMMAND

# open a shell on a container
docker exec -it CONTAINER sh
    # sh may be replaced depending on the container image
    # "exit" to quit

# check connections to container
docker exec -it CONTAINER netstat -natp
    # you may not be able to see established connections directly on docker host machine
    # "netstat" may need to be replaced with "ss"


########## Other Commands

##
# copy host file to container
docker cp FILE CONTAINER:/PATH

# copy file from container
docker cp CONTAINER:/PATH_TO_FILE /HOST_PATH

