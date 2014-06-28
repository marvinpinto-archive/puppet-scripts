# Usage Examples


### Users

##### Hiera
```yaml
users::accounts:
  'marvin':
    pgroup: 'users'
    groups:
      - 'admins'
    fullname: 'Marvin Pinto'
    password_hash: '$6$hppLtmsFlp8Xh$/oAGNrBZkogOR5b/FZp1BRJ.CCbEuQQVOIvmQIEdak/zJdumEiW0Hmucnk/f4Ic3GfCPpyE8GimzgvEpMU9Vs/'
    uid: []
```

##### Puppet
```puppet
users::account: { 'marvin':
  pgroup        => 'users',
  groups        => ['admins'],
  fullname      => 'Marvin Pinto',
  password_hash => '$6$hppLtmsFlp8Xh$/oAGNrBZkogOR5b/FZp1BRJ.CCbEuQQVOIvmQIEdak/zJdumEiW0Hmucnk/f4Ic3GfCPpyE8GimzgvEpMU9Vs/',
}
```

**Note**: The `password_hash` in the examples above correspond to the string `test123`.


### Groups

##### Hiera
```yaml
users::groups:
  'users':
    gid: []
  'admins':
    gid: []
```

##### Puppet
```puppet
users::group { 'users': }
users::group { 'admins': }
```


### Misc
Use the `mkpasswd` command to generate the required `password_hash`:
```bash
$ mkpasswd -m sha-512
```
