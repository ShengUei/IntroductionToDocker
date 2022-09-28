# Docker 與 VM的差別

- Docker 是透過 Container 技術在主機上建立隔離且獨立的空間，所以每個 Container 都可以直接使用主機的硬體資源，因此不用像 VM 每一臺虛擬主機都需要有 OS ，這大幅的降低建立虛擬主機的硬碟大小，且可快速建立。
- 為了讓 Container 可以跟主機進行互動，還是要有 OS 系統，由於 Container 的特性，所以不需要安裝完整的 OS ，僅需安裝具基本功能的輕量化 OS (ex: alpine)。

![Docker vs VM](https://www.oracle.com/a/ocom/img/cc01-what-is-docker-figure1.png)

Reference:
1. https://www.oracle.com/tw/cloud/cloud-native/container-registry/what-is-docker/
