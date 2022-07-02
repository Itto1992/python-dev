# python-dev
This is a repository to provide neovim+python codeing environment.

More concretely,
- ubuntu22.04
- neovim
    - with python-related plugins
- python3.7.13
- oh-my-zsh 

## How to use
0. Install docker & docker-compose
1. Fill out `WORK_DIR` in `.env`

```
WORK_DIR=
SSH_AUTH_SOCK=/ssh-agent
```

2. Build docker image

```
docker build -t ${IMAGE_TAG} . 
```

3. Run docker image via `docker-compose`

```
docker-compose run --rm dev 
```
