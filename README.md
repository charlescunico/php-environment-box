php-environment-box
===================

Set up vagrant box for a development environment on CentOS with PHP, Apache, pgsql and oci8 drivers, grunt and sass.

Using CentOS VM from https://atlas.hashicorp.com/puppetlabs/boxes/centos-6.6-64-puppet and puppet class for the installation of packages.

Requirements
------------

* [Oracle VirtualBox 5.0](https://www.virtualbox.org/)
* [Vagrant 1.7.4](https://www.vagrantup.com/)

Add Box
-------

Download .zip, extract, go to /vagrant folder and run:
```bash
vagrant box add puppetlabs/centos-6.6-64-puppet
vagrant init
vagrant reload --provision
```

Configure VM
------------

SSH Access 
```bash
vagrant ssh
```

Add Enterprise Linux 6 repository, see http://blog.famillecollet.com/pages/Config-en
```bash
cd /opt
sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
sudo wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
sudo rpm -Uvh remi-release-6.rpm epel-release-latest-6.noarch.rpm
cd
```

On [remi] change enable=0 to enable=1
```bash
sudo vim /etc/yum.repos.d/remi.repo
```

Install grunt
```bash
npm install -g grunt-cli
```

Configure instant client for oci8
---------------------------------

Manually download and install oracle instant client basic and SDK (devel) RPMs from http://www.oracle.com/
```bash
sudo rpm -ivh oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
sudo rpm -ivh oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
```

Run php -m and create symlinks to the Oracle libraries that shows a warning. Repeat until no more warnings
```bash
php -m
sudo find / -name libclntsh.so.12.1
cd /usr/lib64/
sudo ln -s /usr/lib/oracle/12.1/client64/lib/libclntsh.so.12.1
sudo ln -s /usr/lib/oracle/12.1/client64/lib/libmql1.so
sudo ln -s /usr/lib/oracle/12.1/client64/lib/libipc1.so
sudo ln -s /usr/lib/oracle/12.1/client64/lib/libnnz12.so
sudo ln -s /usr/lib/oracle/12.1/client64/lib/libons.so
sudo ln -s /usr/lib/oracle/12.1/client64/lib/libclntshcore.so.12.1
```

Define oracle variables on apache
```bash
sudo vim /etc/sysconfig/httpd
```

```
export ORACLE_HOME=/usr/lib/oracle/12.1/client64/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME
export PATH=$PATH:$ORACLE_HOME
export NLS_LANG='BRAZILIAN PORTUGUESE_BRAZIL.WE8ISO8859P1'
export NLS_DATE_FORMAT='DD/MM/YYYY'
```

Copy the same for bash
```bash
sudo vim /etc/profile.d/oracle.sh
```

Configure Apache
----------------

Uncomment and change ServerName, and add virtual host at the end of file
```bash
sudo vim /etc/httpd/conf/httpd.conf
```

```
<VirtualHost *:80>
    ServerAdmin root@localhost
    DocumentRoot /vagrant/project-name
    ServerName project-name.dev
    ErrorLog logs/dummy-project-name.dev-error_log
    CustomLog logs/dummy-project-name.dev-access_log common
    <Directory /vagrant/project-name/>
        Options Indexes MultiViews FollowSymLinks
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
</VirtualHost>
```

Security and performance settings
---------------------------------

In order to avoid problems with firewall or memory limitations:

Disable firewall
```bash
sudo iptables -L -n
sudo chkconfig iptables off
sudo chkconfig ip6tables off
```

Disable selinux
```bash
sudo vim /etc/sysconfig/selinux
```

Unlimited memory for PHP
```bash
sudo vim /etc/php.ini
```

```
memory_limit = -1
```

Verify and disable services for performance improvement
```bash
top -d1 -c
sudo lsof -i
df -h
sudo chkconfig rpcbind off
sudo chkconfig netfs off
sudo chkconfig nfslock off
sudo chkconfig rpcgssd off
sudo chkconfig postfix off
```

Reload VM again with --provisionfor the changes to take effect
```bash
logout
```

```bash
vagrant reload --provision
```
