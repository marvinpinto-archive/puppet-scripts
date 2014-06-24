# Disable the file backup feature
File { backup => false, }

resources { 'firewall':
  purge => true
}

# Use hiera_include and define all our nodes using hiera itself
node default {
  hiera_include(classes)
}
