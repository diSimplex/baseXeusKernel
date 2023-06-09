# Xeus Kernel Builder

A [Dockerfile](https://docs.docker.com/engine/reference/builder/) which provides
all of the required prerequisites to build any
[xeus](https://xeus.readthedocs.io/en/latest/) based
[jupyter](https://jupyter.org/)
[kernel](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels).

To build a local image type:

```
  ./buildImage
```

To publish this local image to DockerHub type:

```
  ./publishImage <<yourDockerHubUserName>> <<aVersion>>
```
