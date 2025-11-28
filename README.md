# Nagios + Puppet + Nginx Project

This project demonstrates automated deployment and configuration of **Nagios monitoring** using **Puppet**, along with Nginx deployment for web access. It includes all configurations from the master, agent, and Nagios VMs.

---

## 📌 **Project Overview**

### **Nagios**

Nagios is used to monitor:

* Host availability
* Services (CPU, Memory, Disk, Network)
* Web service health checks
* Custom service checks
* Alerts and notifications

### **Puppet**

Puppet automates:

* Installing Nagios and required dependencies
* Deploying configuration files
* Ensuring services remain running
* Creating dynamic host/service configs
* Managing plugins and commands

### **Nginx**

Used for deployment of the web interface of the project (e.g., cloned from GitHub). Nginx serves static content and allows monitoring dashboards.

---

## 🖥 **VM Architecture**

| VM  | Role                  | Key Configurations                                                          |
| --- | --------------------- | --------------------------------------------------------------------------- |
| VM1 | Puppet Master + Nginx | Puppet manifests, modules, Nginx deployment, project clone from GitHub      |
| VM2 | Puppet Agent          | Puppet agent configuration, connects to Puppet master                       |
| VM3 | Nagios Server         | Nagios installation, configuration files, plugins, monitored hosts/services |

---

## 📂 **Project Structure**

```
project-upload/
│
├── nagios-config/
│   ├── nagios.cfg
│   ├── resource.cfg
│   ├── objects/
│   │   ├── localhost.cfg
│   │   └── xalon_project.cfg
│   └── other .cfg files
│
├── nagios-plugins/
│   └── plugin scripts (check_disk, check_http, etc.)
│
├── puppet-master-manifests/
│   ├── init.pp
│   ├── install.pp
│   └── service.pp
│
├── puppet-master-modules/
│   └── nagios/
│       ├── manifests/
│       └── templates/
│
└── README.md
```

---

## ⚙️ **How to Run**

### **1. Apply Puppet Configuration on Master**

```bash
puppet apply manifests/init.pp
```

### **2. Start Nagios Service**

```bash
systemctl start nagios
systemctl enable nagios
systemctl status nagios
```

### **3. Access Nagios Web UI**

```text
http://<nagios-server-ip>/nagios
```

---

## 🧪 **Tested Environment**

* OS: Ubuntu / CentOS
* Puppet: 7.x
* Nagios: 4.x
* Nginx: 1.x

---

## 💾 **GitHub Repository Setup**

### Initialize repository (if not already)

```bash
git init
git branch -m main
git remote add origin https://github.com/NITESH7KUMAR/DevOps.git
git add .
git commit -m "Initial upload of Nagios + Puppet + Nginx project"
git push -u origin main
```

### Pulling changes from remote (for future updates)

```bash
git pull origin main --allow-unrelated-histories --no-rebase
git add .
git commit -m "Updated files"
git push origin main
```

---

## 🤝 **Contributing**

Feel free to fork and submit pull requests. Make sure to test all changes in a separate VM environment.

---

## 📧 **Contact**

**Author:** Nitesh Kumar
**Email:** nk6870877@gmail.com
**Project:** Nagios-Puppet-Nginx Monitoring Automation

---

## ⚠️ **Notes**

* Ensure all paths match your VM setup (Nagios may be installed in `/usr/local/nagios` if compiled from source).
* Plugins must have execute permissions (`chmod +x plugin_name`).
* When adding new monitored hosts/services, update `objects/*.cfg` files and apply Puppet configs.
