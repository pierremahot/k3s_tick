# k3s_tick

File to set a k3s stack on raspberry pi3 b with certbot(certmanager) and github OAuth for the chronograf connexion.  
It expose the port 80 for http challenge. A redirection to https is done too.
  
k3s_version   v1.17.3+k3s1  
cert-manager_version v0.14.0  

Before installing k3s if your are using it behind a nat you have to setup dns server.  
I use dnsmasq the conf is in dnsmasq.conf you have to change it to work with your dnsname.  
The k3s install will copy the ip in /etc/resolve.conf to set in all container so you have to set it to your localdns.  
In my case it's my local ip (not 127.0.0.1 but 192.168.x.x) for k3s to ask my dnsmasq.  

add options in /boot/cmdline.txt

```bash
cgroup_enable=cpuset cgroup_memory=1 cgroup_enable="memory" swapaccount=1
```

and reboot.

Need apt install rng-tools dnsmasq

In cert-manager.yaml i change all the images with the "-arm" to have the arm version of the image  
the file came frome <https://github.com/jetstack/cert-manager/releases/download/v0.14.0/cert-manager.yaml>  

Change to make :

```bash
yourlocalIP :
    - dnsmasq.conf
yourdnsname :
    - dnsmasq.conf
    - deployment_chronograf.yaml
    - ingress.yaml
user@domain.xx :
    - le-prod.yaml
    - le-staging.yaml
your-dns-name-tls :
    - ingress.yaml
kapacitorUser, kapacitorPassword :
    - deployment_kronograf.yaml
    - deployment_influxdb.yaml
dbUser, dbPassword  :
    - deployment_chronograf.yaml
    - deployment_kronograf.yaml
    - deployment_influxdb.yaml
    - deployment_telegraf.yaml
admin, adminpassword :
    - deployment_influxdb.yaml
```

if you are using OAuth with github :  
in file deployement_chronograf.yaml  
tocken  
secret  
id  

The init.sh file is just for oder. it will not work because k3s takes time to start containers for the cert-manager.

I use help from <https://www.thebookofjoel.com/k3s-cert-manager-letsencrypt> and find answer from google for others problems
