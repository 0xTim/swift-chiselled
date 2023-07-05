# Chiselled Swift Demo

This is a demo of using [Chiselled Ubuntu Containers](https://canonical.com/blog/chiselled-containers-perfect-gift-cloud-applications) to run a Swift application.

Chiselled containers are inspired by the Distroless concept and produce a tiny container image that contains only the application and its runtime dependencies. This is in contrast to the traditional approach of using a base image such as Ubuntu or Alpine Linux, which can be many times larger than the application itself. The hello world example in this repository is 13.2MB.

They also include no package manager or shell, greatly reducing the attack surface of the container.

To build the Swift demo run:

```bash
cd examples
docker build .. --build-arg UBUNTU_RELEASE=22.04 -t chisel:22.04
docker build . --build-arg UBUNTU_RELEASE=22.04 -f chiselled-base.dockerfile -t chiselled-base:22.04
docker build . --build-arg UBUNTU_RELEASE=22.04 -f swift-example.dockerfile -t hello-world
docker run --rm -it hello-world
```