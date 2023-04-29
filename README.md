# voldocker
Volatility Profile & Symbol Docker Creator

## **How to use**:
+ First, build the image:

```
docker build --build-arg DISTRO=<distro_version> --build-arg KERNEL=<kernel_version> -t voldocker .
```

+ Second, run the docker image and get the profile from it:

```
docker run -it voldocker /bin/bash &

docker cp <container id>:/workspace/Ubuntu-<kernel_version>-profile.zip ./
```

**(For volatility 3's symbol, you need to create it manually)**


+ Last, move the profile to `/volatility/plugins/overlays/linux/` folder or move the symbol to `/volatility3/framework/symbols/linux/` folder. Then enjoy!!


*Example:* 

```
$ docker build --build-arg DISTRO=22.04 --build-arg KERNEL=5.15.0-25-generic -t voldocker .

$ docker run -it voldocker /bin/bash &

$ docker ps    // get the id of the running container

$ docker cp <container id>:/workspace/Ubuntu-5.15.0-25-generic-profile.zip ./

$ docker cp <container id>:/workspace/vmlinux-<kernel_version>.json ./
```