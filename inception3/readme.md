# inception

Lots of scattered notes but ill add some more ongoing thoughts on this 3rd (AND FINAL, MANIFESTING) implimentation

## What is DOcker?
Docker is like a mini VM running off the same host kernel, very convinient and used in a lot of deployment. This project teaches you how to set up a docker network with 3 services and build your own service images from scratch/ a base linux version <can fill more later>

### Why always sudo apt update (and upgrade)?
	So actually apt update is not updating anything itself, but merely the lists of packages you can download. Like refreshing a store page to see if any products have newer versions

	Upgrade is actually installing these updates if anything is out of date, at first I thought it wouldn't be applicable since everything except the base linux image is installed fresh, which should be the penultimate version anyways. But you should still upgrade to install smaller updates for said OS version, for security's sake too!


- **Quick tip** for optimisation it's best to minimize the amount of 'RUN' commands used, since docker will create a new image layer for each one, so a big chained command with lots of &&'s is the way to go

- BUT ALSO 'RUN apt-get update && \
	apt-get upgrade -y' is nice to keep seperate since every container will need it and docker can cache it and share it (hooray out of scope optimisation)




## rebuilding mariadb quick command

docker stop mariadb-test 2>/dev/null && docker rm mariadb-test 2>/dev/null && rm -rf /tmp/mariadb-test-data && docker rmi mariadb-test 2>/dev/null && docker build -t mariadb-test . && docker run -d --name mariadb-test -p 3306:3306 -v /tmp/mariadb-test-data:/var/lib/mysql mariadb-test
