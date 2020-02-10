# code_format_docker

A docker container that contains dependencies for formatting code. Currently supporting C++ and java.

This docker is pushed to https://hub.docker.com/repository/docker/thaink/format_code.
To format your code, use:

```
docker run -v `pwd`:/git_dir \
thaink/format_code:latest
```
