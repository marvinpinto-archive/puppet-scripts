# Usage Examples

The following hiera and puppet examples are both equivalent and would allow
anyone to connect to port `1234` on the server.

##### Hiera
```yaml
my_fw::rules:
  '300 allow access to port 1234':
    port: '1234'
    proto: 'tcp'
    action: 'accept'
```

##### Puppet
```puppet
firewall { '300 allow access to port 1234':
  port   => '1234',
  proto  => 'tcp',
  action => 'accept',
}
```
