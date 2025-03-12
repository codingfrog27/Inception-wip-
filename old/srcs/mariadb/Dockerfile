FROM debian:bullseye

#base image (the base OS that we will build our image on top of)

# Avoid prompts during package installation
# ENV DEBIAN_FRONTEND=noninteractive


#update all package lists and upgrade all installed pckgs to latest (-y == auto yes to all prompts)

RUN apt-get update -y && apt-get upgrade -y

#install mariadb server and netcat (netcat is for pinging)

RUN apt-get install -y mariadb-server netcat



#copy the config from our host computer to container
COPY ./MariaDB_config.sh /MariaDB_config.sh


# conf script isn't executable by default
RUN chmod +x /MariaDB_config.sh

EXPOSE 3306
#??

#default command to run when container starts
ENTRYPOINT ["./MariaDB_config.sh"]