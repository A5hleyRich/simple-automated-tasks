# Simple Automated Tasks

This is a repo for sharing how I manage automated tasks as part of the series [Hosting WordPress Yourself](https://deliciousbrains.com/hosting-wordpress-setup-secure-virtual-server/).

## Installation

Copy the '.tasks' directory to your home directory:

```
.tasks
     - backups.sh
     - cron.sh
     - permissions.sh
     - sites.sh
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

Ensure the bash scripts have execute permissions `chmod +x backups.sh cron.sh permissions.sh sites.sh`.

Add each site to the 'sites.php' config file:

```
SITES=(
	"site1.com"
	"site2.com"
	"site3.com"
)
```

Add a cronjob for each individual task `crontab -e`. The following example will run WordPress cron every 5 minutes, perform backups daily at 5AM and update file permissions daily at 6AM:

```
*/5 * * * * bash /home/ashley/.tasks/cron.sh >/dev/null 2>&1 
0 5 * * * bash /home/ashley/.tasks/backups.sh >/dev/null 2>&1
0 6 * * * bash /home/ashley/.tasks/permissions.sh >/dev/null 2>&1
```

If you plan on sending backups to S3 you must also [install and configure](https://deliciousbrains.com/backup-wordpress-amazon-glacier/#installing-aws) the AWS CLI tools.