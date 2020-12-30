# CodeWithMe

## one deployment for one night

### Usage

#### Local

##### Prerequisites

 - make
 - docker
 - kind
 - kubectl
 - helm
 - terraform
 - lobby-server-linux-x64.*.tar.gz
 - ws-relayd*

##### Deploy kind cluster

```bash
    $ make kind
```

##### Deploy ingress controller

```bash
    $ make ingress
```

##### Deploy ingress controller

```bash
    $ make ingress
```

##### Download and move binaries to right place

 - place downloaded lobby-server-linux-x64.*.tar.gz to lobby directory of project root
 - place downloaded ws-relayd* to relay directory of project root

##### Run local building and deployment

```bash
    $ make local \
      LOBBY_DISTRIBUTION_VERSION=<asterisked_number_of_lobby_tarball> \
      RELAY_DISTRIBUTION_VERSION=<asterisked_number_of_relay_binary>
```
