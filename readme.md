# learn-docker-env

> 一个简单的项目，学习多种方式向 Docker 容器中传递环境变量

## 构建/拉取镜像

```bash
docker build -t wxh16144/learn-docker-env:latest . # <= 注意最后的点
# or
docker pull wxh16144/learn-docker-env:latest # <= 从 Docker Hub 拉取
```

## 1. 通过 docker run 命令行参数传递环境变量

```bash
docker run --rm -it -e MY_FOO=bar wxh16144/learn-docker-env:latest
```

<details>
  <summary>查看输出</summary>
  
  ```log
➜ docker run --rm -it -e MY_FOO=bar wxh16144/learn-docker-env:latest
============================================================================
========================== ENVIRONMENT VARIABLES ===========================
============================================================================
HOSTNAME=83479b1e89e0
MY_FOO=bar
SHLVL=1
HOME=/root
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/app
============================================================================
========================== END OF ENVIRONMENT VARIABLES ====================
============================================================================
Container is running. Press Ctrl+C to exit.

  ```
  
</details>

## 2. 通过 docker-compose.yml 中的 environment 传递环境变量

_docker-compose.yml_

```yaml
services:
  learn-docker-env:
    image: wxh16144/learn-docker-env:latest
    environment:
      MY_BAR: bar
```

<details>
  <summary>查看输出</summary>
  
  ```log
============================================================================
========================== ENVIRONMENT VARIABLES ===========================
============================================================================
HOSTNAME=42f8af0b7093
SHLVL=1
HOME=/root
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
MY_BAR=bar
PWD=/app
============================================================================
========================== END OF ENVIRONMENT VARIABLES ====================
============================================================================
Container is running. Press Ctrl+C to exit.

  ```

</details>

## 3. 通过 docker-compose.yml 中的 .env 文件传递环境变量

_.env_

```ini
MY_BAZ=bar
```

_docker-compose.yml_

```yaml
services:
  learn-docker-env:
    image: wxh16144/learn-docker-env:latest
    env_file:
      - .env
```

<details>
  <summary>查看输出</summary>
  
  ```log
============================================================================
========================== ENVIRONMENT VARIABLES ===========================
============================================================================
HOSTNAME=bdda7aa8cd0e
SHLVL=1
HOME=/root
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/app
MY_BAZ=bar
============================================================================
========================== END OF ENVIRONMENT VARIABLES ====================
============================================================================
Container is running. Press Ctrl+C to exit.

  ```

</details>

## 其他

### 将宿主机的以 `MY_` 开头的环境变量传递给容器

```bash
docker run -it --rm \
  $(printenv | grep '^MY_' | sed 's/^/-e /') \
  wxh16144/learn-docker-env:latest
```

1. `printenv | grep '^MY_'`：获取所有以 `MY_` 开头的环境变量。
2. `sed 's/^/-e /'`：在每个环境变量前面加上 `-e` 选项，以便 `docker run` 能够识别它们。

### docker-compose 中使用插值法

> Read more: [Environment variables in Compose](https://docs.docker.com/compose/how-tos/environment-variables/)

_docker-compose.yml_

```yaml
services:
  learn-docker-env:
    image: wxh16144/learn-docker-env:latest
    environment:
      MY_FOO: ${MY_FOO：default}
```
