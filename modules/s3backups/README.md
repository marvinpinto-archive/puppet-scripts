# About

The `s3backup` script contained in this module essentially creates a tarball of
a specified directory and dumps this tarball directly into an S3 bucket. One
could argue that this isn't a *true* backup mechanism since it clobbers the S3
file without any sanity checking, but this would be where **S3 Versioning**
comes into play.

Enabling *S3 Versioning* on a bucket allows you to store multiple versions of a
file, essentially going back as far as you would like. A brief intro to S3
versioning can be found [here][s3intro].

[s3intro]: https://aws.amazon.com/about-aws/whats-new/2010/02/08/versioning-feature-for-amazon-s3-now-available

## S3 Bucket

This will assume you have already created an S3 bucket named `BUCKET_NAME` and
enabled *Versioning*.

## IAM Permissions

You will first want to create an IAM user in the
[IAM](https://console.aws.amazon.com/iam) section of your AWS console. Do make
note of the *Access Key ID* and *Secret Access Key* as you'll need both of
these later.

You'll then most likely want to create a custom user policy that restricts this
user to a specific bucket/subdirectory. Here is one example of what this could
look like:

```json
{
   "Statement":[
      {
         "Effect":"Allow",
         "Action":"s3:ListAllMyBuckets",
         "Resource":"arn:aws:s3:::*"
      },
      {
         "Effect":"Allow",
         "Action":"s3:*",
         "Resource":[
            "arn:aws:s3:::BUCKET_NAME",
            "arn:aws:s3:::BUCKET_NAME/SPECIFIC_SUBDIRECTORY/*"
         ]
      }
   ]
}
```

This would allow that user full read/write access to `SPECIFIC_SUBDIRECTORY/*`
inside the S3 bucket `BUCKET_NAME`.

## Lifecycle Rules

Lifecycle rules are useful for deleting old versions of S3 files. For example,
assuming you back up your mail to `SPECIFIC_SUBDIRECTORY/mail`, you could
create a rule that applies to objects with the prefix
`SPECIFIC_SUBDIRECTORY/mail` in the `BUCKET_NAME` bucket, that permanently
deletes files 30 days after their overwritten/expiration date.

## Usage Examples

##### Hiera
```yaml
s3backups::instances:
  'marvin-mail':
    s3bucket: 'BUCKET_NAME'
    s3bucket_path: 'SPECIFIC_SUBDIRECTORY/mail'
    src_backup_dir: '/var/mail/marvin'
    dest_tarball_filename: 'marvin-mail'
    syslog_tag: 'marvin-mail'
    s3_access_key_id: 'AWS_USER_ACCESS_KEY'
    s3_secret_access_key: 'AWS_USER_SECRET_ACCESS_KEY'
```

##### Puppet
```puppet
s3backups::instance { 'marvin-mail':
  s3bucket              => 'BUCKET_NAME',
  s3bucket_path         =>  'SPECIFIC_SUBDIRECTORY/mail',
  src_backup_dir        => '/var/mail/marvin',
  dest_tarball_filename =>  'marvin-mail',
  syslog_tag            =>  'marvin-mail',
  s3_access_key_id      =>  'AWS_USER_ACCESS_KEY',
  s3_secret_access_key  =>  'AWS_USER_SECRET_ACCESS_KEY',
}
```

##### Cron

And assuming you want these backups to happen automatically, you could use the
`cron::crontabs` resource as follows:

```yaml
cron::crontabs:
  'marvin-mail':
    minute: '20'
    mailto: ''
    hour: '22'
    day_of_month: '*'
    month: '*'
    day_of_week: '*'
    command: '/usr/local/bin/s3backup-marvin-mail'
    user: 'root'
    enabled: 'true'
```

## Resources

- [Granting Access to a Single S3 Bucket Using Amazon IAM](http://mikeferrier.com/2011/10/27/granting-access-to-a-single-s3-bucket-using-amazon-iam)
