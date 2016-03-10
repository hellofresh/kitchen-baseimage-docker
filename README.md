# kitchen-baseimage-docker
A base image for test-kitchen docker. 

## What 
This image is baked with tools needed for faster test-kitchen docker converages. Its based on [phusion](https://github.com/phusion/baseimage-docker) a minimal Ubuntu base image. 

## Example kitchen.yml
```yaml
---
driver:
  name: docker

provisioner                 :
    name                    : ansible_push
    playbook                : "test.yml"

platforms:
    - name                  : ubuntu-14.04
      driver_config         :
        image               : quay.io/hellofresh/kitchen-base
        platform            : ubuntu

suites                      :
  - name                    : default
```

License
-------
MIT

Contributors (sorted alphabetically on the first name)
------------------
* [Adham Helal](https://github.com/ahelal)
