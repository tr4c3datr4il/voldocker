# voldocker
Volatility Profile Docker Creator

# **How to use**:
+ First, build docker image:

```
docker build --build-arg DISTRO=<distro_version> --build-arg KERNEL=<kernel_version> -t voldocker .
```

+ Second, run the docker images and get the profile from it:

```
docker run -it voldocker /bin/bash &
docker cp <container id>:/workspace/Ubuntu*zip ./
```

+ Last, move the profile to `/volatility/plugins/overlays/linux/` folder. Then enjoy!!