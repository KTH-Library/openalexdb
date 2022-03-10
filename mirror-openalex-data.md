# Getting data from openalex S3 and mirroring to KTH S3 cloud

First, connections to AWS S3 and KTH S3 needs to be set.

## AWS S3 

Use "minio client" (see min.io/download and use the minio client), make sure it is executable and on the path (place in ~/bin?) and up-to-date (use "mc update"). Then issue:

		mc alias set openalex https://s3.amazonaws.com --api s3v4

This will set up an alias called "s3" (use blank credentials). 

Aliases can be seen with "mc alias ls".

Try to list the files now:

		# ndjson "snapshot" format 
		mc ls openalex/openalex/

		# flattened MAG format (TSV-files)
		mc ls openalex/openalex-mag-format/data_dump_v1/2022-01-30/mag

If ok, the connection to OpenAlex data dumps has been configured.

## KTH S3

Same thing here, first configure a "netapp" alias (if not already present):

		mc alias set netapp https://s3.cloud.kth.se --api s3v4 --path auto

This will update the "~/.mc/config.json" file with an entry looking like this

		"netapp": {
			"url": "https://s3.cloud.kth.se",
			"accessKey": "usekth-S3-accesskeyhere",
			"secretKey": "usekth-S3-secretpasswordhere",
			"api": "s3v4",
			"path": "auto"
		}

## Mirroring

When both sources have aliases we can mirror data from AWS to KTH S3 storage.

We want to mirror the flattened "MAG" data and the ndjson "snapshot" data from OpenAlex. We need to know the locations/buckets with this data and we need to have destination buckets ready.

If KTH S3 "netapp" alias does not already have buckets (check with "mc ls netapp"), these need to be created:

		mc mb netapp/openalex-mag
		mc mb netapp/openalex-ndjson

We can now proceed to mirror the data.

With transfer speeds of about 100 MiB/s, the MAG data at 222 GiB would take an hour or so to mirror. 

It can be convenient to do this in a "screen session" so we can log out and reattach at any time:

		screen -S openalex-mag
		
		# sync flattened data (MAG/TSV)
		mc mirror openalex/openalex-mag-format data_dump_v1/2022-01-30/mag/ netapp/openalex-mag/

		# press Ctrl-A + d to "detach" from the screen session

Now we can also initiate downloading of the ndjson "snapshot" data in another screen session.

		screen -S openalex-ndjson
		
		# sync ndjson data
		mc mirror openalex/openalex/ netapp/openalex-ndjson/

		# press Ctrl-A + d to "detach" from the screen session

The ndjson snapshot files are larger than the MAG files.

Now it is possible to log out from the shell. Remember to use "Ctrl-A + d" to detach before exiting and logging out. 

## Download progress

To monitor download progress you can log in again, active "screen sessions" can be listed with "screen -ls" and there should be two sessions listed. To "reattach" or "resume" a session, use the id in the listing with "screen -r <id>" or issue "screen -r openalex-mag" to use the session name.

Remember to use "Ctrl-A + d" to detach before exiting and logging out. 

It is not necessary to login again to monitor progress if "mc" is installed locally with the same aliases configured, progress can be checked with 

		# use mc --help to learn about options, "du" stands for "disk usage"
		mc du netapp/openalex-mag
		mc du netapp/openalex-ndjson/data/works

		# compared to AWS

		mc du openalex/openalex-mag-format/data_dump_v1/2022-01-30/mag
		mc du openalex/openalex/data

## Script to schedule mirroring/syncing using screen

A script placed in ~/bin can set up two screen session, called for example "openalex-screen.sh":

		#!/bin/bash -e

		screen -d -m -S openalex-mag bash -c 'openalex-mirror-mag.sh'
		screen -d -m -S openalex-ndjson bash -c 'openalex-mirror-ndjson.sh'

It calls into two other scripts.

- bin/openalex-mirror-mag.sh

		#!/bin/bash -e
		mc mirror openalex/openalex-mag-format/data_dump_v1/2022-01-30/mag/ netapp/openalex-mag/

- bin/openalex-mirror-ndjson.sh

		#!/bin/bash -e
		mc mirror openalex/openalex/ netapp/openalex-ndjson/

When updates arrive these can then be fetched using "openalex-screen.sh".

It could also be scheduled to run biweekly.

