# Docker網路介紹

### Docker提供幾種 Network Driver 可以使用:
* host(**常用**): 將主機的網段直接配給所指定的 container。
* bridge(**常用**): 提供一個虛擬網卡，使包含在其底下的 containers 可以互相連線。  
* none: 關閉該 container 的網路功能。
* overlay: 讓不同主機上的 Docker 裡的 containers 可以互相透過網路連通。
* ipvlan: 自行設定 IPv4 與 IPv6。
* macvlan: 自行設定 MAC。
* network plugins: 使用第三方工具。

```bash
# 顯示當前有哪些 network
docker network ls

# result
NETWORK ID          NAME                DRIVER              SCOPE
a1c7b6f80389        bridge              bridge              local
dc2f51e1056f        host                host                local
f28460d3a620        none                null                local
# dokcer 預設有 bridge 、 host 、 none 這三種 network ，且 name 與 driver 相同
```


### Host Driver 介紹:

```bash
docker container run --name webserver -d -p 9090:80 nginx
# --name 自定義 container 名字
# -d(--detach) 讓 container 在背景執行
# -p 9090:80 指定 host 的 9090 port 對應到該 cotainer 的 80 port
````

![img0](https://miro.medium.com/max/720/1*6xUdGsh3ALVtcfvG5Q7VdQ.png)

### Bridge Driver 介紹:

```bash
docker run -dit --name alpine1 alpine ash
docker run -dit --name alpine2 alpine ash

docker network inspect bridge

# result
[
    {
        "Name": "bridge", # docker network 的名字
        "Id": "a1c7b6f8038999f034b8e64ae66885fa8094a020a306ce4f5b5692d7230890b0",
        "Created": "2018-07-09T01:23:03.98371109Z",
        "Scope": "local",
        "Driver": "bridge", # 使用什麼 driver
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        # 該虛擬網卡中各 container 的網路資訊
        "Containers": {
            "16aa4a102b14de3e151cb5e19522925bb4e143034d5b2aac4ce239c79716b703": {
                "Name": "alpine2",
                "EndpointID": "4dc3947583ece828dd4371351501e7d0ba9fa149ac5373ea4ddb9466d333b85d",
                "MacAddress": "02:42:ac:11:00:03",
                "IPv4Address": "172.17.0.3/16", # alpine2 的 IP
                "IPv6Address": ""
            },
            "b75464efd30bf09e118450de2abaeb35549e732bac5805671f1e6e97cd970897": {
                "Name": "alpine1",
                "EndpointID": "ea0138a2c51812f3f142db086e1690f6696e36ff972c826727be30e3c8b8cb41",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16", # alpine1 的 IP
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```

![img1](https://godleon.github.io/blog/images/docker/docker-bridge-network-1.png)

![img2](https://godleon.github.io/blog/images/docker/docker-bridge-network-custom.png)

reference:
1. https://docs.docker.com/network/
2. https://docs.docker.com/network/network-tutorial-standalone/
3. https://azole.medium.com/docker-container-%E5%9F%BA%E7%A4%8E%E5%85%A5%E9%96%80%E7%AF%87-2-c14d8f852ae4
4. https://godleon.github.io/blog/Docker/docker-network-bridge/
