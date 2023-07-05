# This Dockerfile is building an image for a simple "Hello, world" Swift program that uses the Swift compiler and a chiselled Ubuntu base image

ARG UBUNTU_RELEASE=22.04
ARG SWIFT_VERSION=5.8
ARG UBUNTU_NAME_RELEASE=jammy

FROM swift:${SWIFT_VERSION}-${UBUNTU_NAME_RELEASE} AS builder

WORKDIR /app

RUN apt-get update && apt-get upgrade -y
# Updates the package lists

RUN echo 'print("hello, world")' > hello.swift
# Creates a "hello.swift" file for a simple "Hello, world" Swift program in the current working directory

RUN swiftc hello.swift -o ./hello-world -static-stdlib
# Compiles the "hello.swift" file using the Swift compiler and creates a "hello-world" binary in the current working directory

FROM chiselled-base:${UBUNTU_RELEASE}
# Starts a new build stage from the previously built chiselled base image for the specified Ubuntu release (22.04 by default)

COPY --from=builder /app/hello-world /
# Copies the "hello-world" binary from the "builder" build stage to the root directory ("/") of the new image

CMD [ "/hello-world" ]
# Sets the default command to run when the container is started from this image to "/hello-world"

# USAGE:
# 
# 1. Build the "chisel:22.04" image using the "../Dockerfile" file
#    ```  docker build .. --build-arg UBUNTU_RELEASE=22.04 -t chisel:22.04 ```
# 2. Build the chiselled Ubuntu base image using the provided "chiselled-base.dockerfile" file
#    ```  docker build . --build-arg UBUNTU_RELEASE=22.04 -f chiselled-base.dockerfile -t chiselled-base:22.04 ```
# 3. Build the "hello-world" image using this Dockerfile
#    ```  docker build . --build-arg UBUNTU_RELEASE=22.04 -f swift-example.dockerfile -t hello-world ```
# 4. Run the "hello-world" container from the built image
#    ```  docker run --rm -it hello-world  ```
# 5. Make sure the output shows the "hello, world" text!