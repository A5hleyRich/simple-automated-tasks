# Simple Automated Tasks

This is a repo for sharing how I manage automated tasks as part of the series [Hosting WordPress Yourself](https://deliciousbrains.com/hosting-wordpress-setup-secure-virtual-server/).

## Installation

Copy the [.tasks](https://github.com/A5hleyRich/simple-automated-tasks/tree/master/.tasks) directory to your home directory:

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

Ensure the bash scripts have execute permissions `chmod +x backups.sh checksums.sh cron.sh permissions.sh sites.sh`.

Update [sites.sh](https://github.com/A5hleyRich/simple-automated-tasks/blob/master/.tasks/sites.sh#L4) with the absolute path to where your site directories reside. Update [backups.sh](https://github.com/A5hleyRich/simple-automated-tasks/blob/master/.tasks/backups.sh#L4), [checksums.sh](https://github.com/A5hleyRich/simple-automated-tasks/blob/master/.tasks/checksums.sh#L4), [cron.sh](https://github.com/A5hleyRich/simple-automated-tasks/blob/master/.tasks/cron.sh#L4) and [permissions.sh](https://github.com/A5hleyRich/simple-automated-tasks/blob/master/.tasks/permissions.sh#L4) with the absolute path of your sites.sh file.

Add each site to the [sites.sh](https://github.com/A5hleyRich/simple-automated-tasks/blob/master/.tasks/sites.sh#L7) config file:

```
SITES=(
	"site1.com"
	"site2.com"
	"site3.com"
)
```

Add a cronjob for each individual task `crontab -e`. The following example will run WordPress cron every 5 minutes, perform backups daily at 5AM, update file permissions daily at 6AM and verify checksums at 7AM:

```
*/5 * * * * cd /home/a5hley/.tasks; bash cron.sh >/dev/null 2>&1
0 5 * * * cd /home/a5hley/.tasks; bash backups.sh >/dev/null 2>&1
0 6 * * * cd /home/a5hley/.tasks; bash permissions.sh >/dev/null 2>&1
0 7 * * * cd /home/a5hley/.tasks; bash checksums.sh >/dev/null 2>&1
```

If you plan on sending backups to S3 you must also [install and configure](https://deliciousbrains.com/backup-wordpress-amazon-glacier/#installing-aws) the AWS CLI tools.

The checksums task requires a [Pushbullet](https://www.pushbullet.com) account, so that notifications are pushed to your computer, IOS or Android devices. Add your _Access Token_ to the [checksums.sh](https://github.com/A5hleyRich/simple-automated-tasks/blob/master/.tasks/checksums.sh#L7) file:

```
TOKEN=mytoken
```