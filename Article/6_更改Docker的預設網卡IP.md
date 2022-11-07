# How to change the default docker subnet IP range?

By default, Docker uses 172.17.0.0/16. This can conflict with your cloud subnet IP range. Here's how to update it.

How To Change The Default Docker Subnet IP Range

- Step 1

SSH into the Hyperglance Instance/VM.

- Step 2

You need to edit /etc/docker/daemon.json:

```bash
sudo vi /etc/docker/daemon.json
```

Add "bip": "172.26.0.1/16" to the JSON, in daemon.json.

The JSON will look like this after you have updated it:

```bash
{
"log-driver": "journald",
"log-opts": {
"tag": "{{.Name}}"
},
"bip": "172.26.0.1/16"
}
```

- Step 3
Restart Docker:

```bash
sudo systemctl restart docker
```

- Step 4
Check the routing table:

```bash
netstat -rn
```

You should see the following output (note the penultimate row):

```bash
Kernel IP routing table
Destination Gateway Genmask Flags MSS Window irtt Iface
0.0.0.0 172.31.16.1 0.0.0.0 UG 0 0 0 eth0
169.254.169.254 0.0.0.0 255.255.255.255 UH 0 0 0 eth0
172.18.0.0 0.0.0.0 255.255.0.0 U 0 0 0 br-e9768d205a82
172.26.0.0 0.0.0.0 255.255.0.0 U 0 0 0 docker0
172.31.16.0 0.0.0.0 255.255.240.0 U 0 0 0 eth0
```

Once you're done, the docker containers will restart, then begin to collect.

---
Reference:
 - https://support.hyperglance.com/knowledge/changing-the-default-docker-subnet
