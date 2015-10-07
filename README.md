# Simple Automated Tasks

This is a repo for sharing how I manage automated tasks as part of the series [Hosting WordPress Yourself](https://deliciousbrains.com/hosting-wordpress-setup-secure-virtual-server/).

## Installation

Copy the '.tasks' directory to your home directory:

```
.tasks
     - backups.php
     - cron.php
     - permissions.php
     - sites.php
site1.com
     + backups
     + cache
     + logs
     + public
site2.com
     + backups
     + cache
     + logs
     + public
site3.com
     + backups
     + cache
     + logs
     + public
```

Add each site to the 'sites.php' config file:

```
$sites = array(
	'site1.com',
	'site2.com',
	'site3.com',
);
```

Add a cronjob for each individual task `crontab -e`. The following example will run WordPress cron every 5 minutes, perform backups dailiy at 5AM and update file permissions dailiy at 6AM:

```
*/5 * * * * php -q /home/ashley/.tasks/cron.php >/dev/null 2>&1 
0 5 * * * php -q /home/ashley/.tasks/backups.php >/dev/null 2>&1
0 6 * * * php -q /home/ashley/.tasks/permissions.php >/dev/null 2>&1
```

If you plan on sending backups to S3 you must also [install and configure](https://deliciousbrains.com/backup-wordpress-amazon-glacier/#installing-aws) the AWS CLI tools.