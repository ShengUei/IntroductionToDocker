# Docker網路介紹

### Docker提供幾種 Network driver 可以使用:
* bridge(**常用**): 提供一個虛擬網卡，使包含在其底下的 containers 可以互相連線。
* host(**常用**): 將主機的網段直接配給所指定的 container。  
* none: 關閉該 container 的網路功能。
* overlay: 讓不同主機上的 Docker 裡的 containers 可以互相透過網路連通。
* ipvlan: 自行設定 IPv4 與 IPv6。
* macvlan: 自行設定 MAC。
* network plugins: 使用第三方工具。

![img1](https://godleon.github.io/blog/images/docker/docker-bridge-network-1.png)

![img2](https://godleon.github.io/blog/images/docker/docker-bridge-network-custom.png)

reference:
1. https://docs.docker.com/network/
2. https://docs.docker.com/network/network-tutorial-standalone/
3. https://godleon.github.io/blog/Docker/docker-network-bridge/
