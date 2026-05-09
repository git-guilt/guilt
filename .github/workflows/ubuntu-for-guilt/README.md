# Ubuntu image with asciidoc

Guilt requires asciidoc to create the documentation.  Running `apt
install asciidoc` on a GitLab runner can take a long time (typically
between 30 and 120 seconds, but occasionally much longer), so we do
not want to do that each time a pull request is created.  Instead, we
create a Docker image with asciidoc pre-installed, and use that in our
CI jobs.

../ubuntu-for-guilt.yml and this directory sets up a workflow that can
be manually triggered to generate the new image.  It is also scheduled
to run weekly.

This file explains how everything is set up, and where to verify that
we are using the latest versions of the tools.

## Dockerfile

The `Dockerfile` is very basic. It sets up a new image that is based
on Ubuntu 24.04 and innstalls asciidoc-base, git and make.

## ../ubuntu-for-guilt.yml

This sets up a GitHub workflow that is triggered manually.  It builds
the Docker image and publishes it on Github.  See below for details.

## ../makefile.yml

A future commit will teach this file to use the generated Docker image
and runs the testsuite.

# ../ubuntu-for-guilt.yml explained

The file is based on the [Publishing Docker
images](https://docs.github.com/en/actions/tutorials/publish-packages/publish-docker-images)
tutorial (read 2026-04-26).

## env

We set `REGISTRY` to `ghcr.io` (GitHub Container Registry).

We set the `IMAGE_NAME` to `ubuntu-for-guilt` scoped by the
`github.repository_owner`.  The tutorial recomends using
`github.repository`, but since this image doesn't provide `guilt` that
would be inappropriate here.

## jobs.build-and-push-image

This workflow contains a single job.

### Checkout repo

`actions/checkout` is documented here:
https://github.com/marketplace/actions/checkout

### Login to the Container registry

`docker/login-action` is documented here:
https://github.com/marketplace/actions/docker-login

### Extract metadata

`docker/metadata-action` is documented here:
https://github.com/marketplace/actions/docker-metadata-action

### Build and push Docker image

`docker/build-push-action` is documented here:
https://github.com/marketplace/actions/build-and-push-docker-images

### Generate artifact attestation

`actions/attest` is documented here:
https://github.com/marketplace/actions/generate-generic-attestations
