# python-dev
This is a repository to provide neovim+python codeing environment.

More concretely,
- ubuntu20.04
- neovim
    - with python-related plugins
- python3.10.12
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
IMAGE_TAG=simossyi/dev:neovim
docker build -t ${IMAGE_TAG} . 
```

3. Create `.gitconfig`

```
# if .gitconfig has already existed in the home directory
cp ~/.gitconfig .
```

4. Run docker image via `docker-compose`

```
docker-compose run --rm dev 
```

5. Install vim packages and commit image

```
export CONTAINER_ID=
docker commit $CONTAINER_ID $IMAGE_TAG
```
