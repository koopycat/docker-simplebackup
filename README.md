# Docker - SimpleBackup

## Description

A simple Docker container that runs server backups using [simple-server-backup](https://github.com/koopycat/simple-server-backup). The container runs the backup immediately when started and then exits.

## Setup

```bash
docker run -v '<LOCAL_BACKUP_FOLDER>:/backups' ghcr.io/vkoop/docker-simplebackup:master
```

## Scheduling

This container does not handle scheduling internally. To schedule backups, use external scheduling mechanisms such as:

- Docker cron jobs
- Kubernetes CronJobs
- Host system's cron
- Any other external scheduling mechanism

### Example with host cron

```bash
# Run backup daily at 2 AM
0 2 * * * docker run --rm -v '/path/to/backups:/backups' ghcr.io/vkoop/docker-simplebackup:master
```

### Example with docker-compose and external scheduling

```yaml
version: '3'

services:
  backup:
    image: ghcr.io/vkoop/docker-simplebackup:master
    volumes:
      - ./backups:/backups
```

Then run with: `docker-compose run --rm backup`

### Example with Ofelia scheduler

A `docker-compose.yml` file is included in this repository that uses [Ofelia](https://github.com/mcuadros/ofelia) to schedule backups. Ofelia is a Docker job scheduler that can run commands or services on a schedule.

The docker-compose.yml file configures:

- A backup service with the appropriate volume mounts
- Ofelia labels to schedule daily backups at 2 AM
- An Ofelia container that manages the scheduling

To use this setup:

```bash
# Start the containers
docker-compose up -d

# Check the scheduler logs
docker-compose logs -f ofelia
```

See the `docker-compose.yml` file in this repository for the complete configuration.
