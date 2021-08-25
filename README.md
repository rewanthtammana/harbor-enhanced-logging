## Improving the security audit logging in Harbor using OpenResty

> 
Harbor is an open-source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted. Harbor, a CNCF Graduated project, delivers compliance, performance, and interoperability to help you consistently and securely manage artifacts across cloud-native compute platforms like Kubernetes and Docker.
 https://goharbor.io/

When it comes to the Security Standards and requirements of compliance Harbor doesn't have a mechanism to perform audit logging functionality. This repo contains code to sovle this problem.

## Installation

- During the installation of Harbor, copy `nginx-custom` folder to `nginx`
- Update `docker-compose.yml` with `./make/docker-compose.yml`
- Start Harbor

## Explanation

`./make/common/config/nginx-custom/conf/nginx.conf` contains the customized code to solve the auditing problem.

