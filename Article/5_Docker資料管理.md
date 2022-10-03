# Docker資料管理

### mount
When you use a bind mount, a file or directory on the host machine is mounted into a container. The file or directory is referenced by its absolute path on the host machine. 

### volume
By contrast, when you use a volume, a new directory is created within Docker’s storage directory on the host machine, and Docker manages that directory’s contents.

![img1](https://docs.docker.com/storage/images/types-of-mounts-bind.png)

reference:
1. https://docs.docker.com/storage/bind-mounts/
2. https://docs.docker.com/storage/volumes/
3. https://docs.docker.com/storage/
