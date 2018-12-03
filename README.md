# Arm-Logdna-Agent

Logdna disributes their own agent from [thier own github repo.](https://github.com/logdna/logdna-agent) Unfortunately they do not produce a arm64 build of their agent. 

Using [FPM](https://github.com/jordansissel/fpm) we can build a arm64 package in docker using qemu. This process could be applied to any software that does not produce an arm64 package. 

The documentation for FPM is a bit weird but some of the best is on the github wiki found [HERE!](https://github.com/jordansissel/fpm/wiki)

[Building arm64 everywhere ](https://www.balena.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/)