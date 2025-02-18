
#base image (the base OS that we will build our image on top of)

FROM debian:bullseye


#update all package lists and upgrade all installed pckgs to latest (-y == auto yes to all prompts)

RUN apt get update && apt-get upgrade -y

#install mariadb server and netcat (netcat is for pinging)

RUN apt-get install -y mariadb-server netcat



#copy the config from our host computer to container
COPY ./mdb-conf.sh /mdb-conf.sh


# conf script isn't executable by default
RUN chmod +x /mdb-conf.sh


#default command to run when container starts
ENTRYPOINT ["./mdb-conf.sh"]