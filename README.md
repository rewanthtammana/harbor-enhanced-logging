## Improving the security audit logging in Harbor using OpenResty

> 
Harbor is an open-source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted. Harbor, a CNCF Graduated project, delivers compliance, performance, and interoperability to help you consistently and securely manage artifacts across cloud-native compute platforms like Kubernetes and Docker.
 https://goharbor.io/

When it comes to the Security Standards and requirements of compliance Harbor doesn't have a mechanism to perform audit logging functionality. This repo contains code to sovle this problem.

## Current workflow

![rewanthtammana-Harbor-default-flow.png](https://cdn.hashnode.com/res/hashnode/image/upload/v1629466236081/DD2wuKbM2.png)

## Enhanced workflow

![rewanthtammana-Harbor-enhanced-flow.png](https://cdn.hashnode.com/res/hashnode/image/upload/v1629466401602/u6Gn1Fp4l.png)

## Installation

- Clone [Harbor](https://github.com/goharbor/harbor) repository
- Run the install preparation script
- Clone this repo & add the submodules
  ```bash
  git clone https://github.com/rewanthtammana/harbor-logging
  cd harbor-logging
  git submodule add https://github.com/openresty/lua-resty-redis make/common/config/nginx-custom/lua-resty-redis
  ```
- Copy `./make/common/config/nginx-custom/` & `./make/docker-compose.yml` to Harbor's folder
- Start & get Harbor running

## Technicalities

### Default logging configuration

```apacheconf
  log_format timed_combined '$remote_addr - '
    '"$request" $status $body_bytes_sent '
    '"$http_referer" "$http_user_agent" '
    '$request_time $upstream_response_time $pipe';
```

### Custom logging configuration

`./make/common/config/nginx-custom/conf/nginx.conf` contains the customized logging configuration.

Along with a bunch of other Lua codes, [here](https://github.com/rewanthtammana/harbor-logging/blob/master/make/common/config/nginx-custom/lua/user.lua), a considerable upgrade has been performed in the logging conf, [here](https://github.com/rewanthtammana/harbor-logging/blob/master/make/common/config/nginx-custom/conf/nginx.conf)

```apacheconf
  ...
  location / {
    ...
    default_type text/plain;
    access_by_lua_block {
      local user = require "user"
      local redis = require "resty.redis"
      local red = redis:new()

      ngx.var.email=user.fetch(red, ngx.var.cookie_sid)
    }
  }
  ...
  log_format timed_combined escape=none '($email) $remote_addr - '
  '"$request" $status $body_bytes_sent '
  '"$http_referer" "$http_user_agent" '
  '$request_time $upstream_response_time $pipe'
  '$request_body';
```

The above changes along with other replacements in architecture flows allow us to solve this problem.

