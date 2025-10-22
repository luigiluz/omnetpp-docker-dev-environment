# OMNeT++ Docker Development Environment

This docker container environment contains the installation of OMNeT++ using the "opp_env" package manager, as recommended in the [OMNeT++ official website](https://omnetpp.org/download/) for version 6.0.2.

## Building docker image

To build and run the docker image, simply run:

```bash
docker compose up -d --build
```

## Allowing the container to use the host display

This step is necessary to allow the OMNeT++ GUI appear correctly.

```bash
xhost +local:docker
```

## Getting inside the running container

To get inside the running container, run the following command:

```bash
docker exec -it omnetpp_dev /bin/bash
```

This will get you inside the container with access to bash, so you can use the command line to navigate inside the container.

## Creating your environment and installing OMNeT++ and INET framework

Once inside the container, go to the workspace folder:

```bash
cd workspace/
```

Initialize the workspace:

```bash
opp_env init
```

Download and build INET and a matching version of OMNeT++:

```bash
opp_env install inet-latest
```

**Note:** This step is only needed to be done once when you do not have anything installed yet. This will usually take a lot of time. In my machine took around 2 hours to build everything.

Start an interactive shell for working with OMNeT++ and INET:

```bash
opp_env shell
```

Once inside the shell, to execute OMNeT++, simply run:

```bash
omnetpp
```

Finally, a new screen should appear with the OMNeT++ GUI.
