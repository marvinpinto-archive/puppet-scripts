# Usage Examples

The following hiera and puppet examples are both equivalent and would create:
```bash
$ cat /etc/cron.d/puppet
#
# cron-job for puppet (managed by puppet)
#
MAILTO=""
# DISABLED-IN-PUPPET  */30 * * * * root /usr/local/bin/puppull && /usr/local/bin/puprun -y
```

##### Hiera
```yaml
cron::crontabs:
  'puppet':
    minute: '*/30'
    mailto: ''
    hour: '*'
    day_of_month: '*'
    month: '*'
    day_of_week: '*'
    command: '/usr/local/bin/puppull && /usr/local/bin/puprun -y'
    user: 'root'
    enabled: 'false'
```

##### Puppet
```puppet
cron::crontab {'puppet':
  minute       => '*/30',
  mailto       => '',
  hour         => '*',
  day_of_month => '*',
  month        => '*',
  day_of_week  => '*',
  command      => '/usr/local/bin/puppull && /usr/local/bin/puprun -y',
  user         => 'root',
  enabled      => 'true',
}
```
