---
layout: post
title: "Posting a sentry"
date: 2014-08-15 15:23:09
link:
---
[Sentry](https://github.com/getsentry/sentry) is brilliant. If you have to know anything about the operations of some specific software, that is.

And, you can choose between paying for a hosted service at [getsentry.com](https://getsentry.com/), or hosting the code yourself. I wasn't sure whether it was the right solution for a project, so I opted to try hosting on Heroku and see if that worked.

My first attempt used the fully free Heroku option, including the free hobby postgres database, and that worked fine, but quickly hit the database row limit of 10000 rows. So then I looked into the new AWS RDS Postgres option, since AWS has more flexible plans generally than Heroku, which means you pay either more or less depending on your usage, where Heroku makes the price more stable from month to month. There are a couple of ways to get sentry running on Heroku, and https://github.com/doptio/django-sentry-on-heroku is the closest to how I ended up getting it working, but I also looked at https://github.com/fastmonkeys/sentry-on-heroku for inspiration.

So I created the database, and updated the DATABASE_URL environment variable in the Heroku app, and it worked fine again, this time without the database row limits. However, very soon the app stopped responding and just became practically unusable. Looking into the AWS console I realised that the region had defaulted to US West, where Heroku is hosted in AWS US East. So the procedure to migrate was to create a new RDS instance in US East, and configure it the same way, and then copy the database across. With the postgres server in the same AWS zone as the Heroku web server, it works great again.

The procedure for migrating the data was:

```
pg_dump -Fc "postgres://sentryadmin:password@sentrydb.random.us-west-2.rds.amazonaws.com:5432/sentrydb?sslmode=require" > sentry.dump
pg_restore --host=sentrydb.random.us-east-1.rds.amazonaws.com --username=sentryadmin --dbname=sentrydb sentry.dump
```

We are using the Cocoapod "Raven" in our iOS projects to log directly from iOS devices to our sentry server, so we can easily see what's happening with the iOS apps we've made. It's really handy to be able to watch the iOS apps remotely.
