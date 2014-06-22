# Usage Examples

### SSH Host Keys

You can generally determine a server's public host key by running:
```bash
$ ssh-keyscan -t rsa bitbucket.org
# bitbucket.org SSH-2.0-OpenSSH_5.3
bitbucket.org ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==
```

At which point you would use it for this module as:
```yaml
ssh::hostkeys:
  'bitbucket.org':
    ensure: 'present'
    key: 'AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw=='
    type: 'ssh-rsa'
```

### Authorized Keys

The following hiera and puppet examples are both equivalent and would create:
```bash
$ cat /etc/ssh/KEYS/marvin
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFTGI9xobfEmMLPCXYDbfGbWP8Y83wmEl3MB8e4pffZKCYwBKPwTNwNQvnuOI3ZQm1d7X5vwGMcQf/sSqaLVrOZQTQeQP01jFPPT7eaTFQP+vgTE6CMjdxWNHOZqlpS92Clg4MLJBi3PKjyTsXw1M05h+uAm7Mlsws7wCeQrjvYNDpY5u3ysSdjRPxr1bkmcXgQb27Eb8zjJwfppZvulzvfjDgGhiouxmej3q5eByq3eTrKgFiw5eyjnvO4EjzzFlc/M3KTxbpBKgoS+cnEt/11mGzGsQ9GpAWZWwH+ut0NnFRxjhfPhH7Xr3sa5honcb9QJ9pnEZFoUmFKFUNAKzR Personal Key for Marvin Pinto
```

##### Hiera
```yaml
ssh::authorized_keys:
  'marvin':
    ensure: 'present'
    key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFTGI9xobfEmMLPCXYDbfGbWP8Y83wmEl3MB8e4pffZKCYwBKPwTNwNQvnuOI3ZQm1d7X5vwGMcQf/sSqaLVrOZQTQeQP01jFPPT7eaTFQP+vgTE6CMjdxWNHOZqlpS92Clg4MLJBi3PKjyTsXw1M05h+uAm7Mlsws7wCeQrjvYNDpY5u3ysSdjRPxr1bkmcXgQb27Eb8zjJwfppZvulzvfjDgGhiouxmej3q5eByq3eTrKgFiw5eyjnvO4EjzzFlc/M3KTxbpBKgoS+cnEt/11mGzGsQ9GpAWZWwH+ut0NnFRxjhfPhH7Xr3sa5honcb9QJ9pnEZFoUmFKFUNAKzR Personal Key for Marvin Pinto'
```

##### Puppet
```puppet
ssh::authorized_key {'marvin':
  ensure => present,
  key    => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFTGI9xobfEmMLPCXYDbfGbWP8Y83wmEl3MB8e4pffZKCYwBKPwTNwNQvnuOI3ZQm1d7X5vwGMcQf/sSqaLVrOZQTQeQP01jFPPT7eaTFQP+vgTE6CMjdxWNHOZqlpS92Clg4MLJBi3PKjyTsXw1M05h+uAm7Mlsws7wCeQrjvYNDpY5u3ysSdjRPxr1bkmcXgQb27Eb8zjJwfppZvulzvfjDgGhiouxmej3q5eByq3eTrKgFiw5eyjnvO4EjzzFlc/M3KTxbpBKgoS+cnEt/11mGzGsQ9GpAWZWwH+ut0NnFRxjhfPhH7Xr3sa5honcb9QJ9pnEZFoUmFKFUNAKzR Personal Key for Marvin Pinto',
}
```
