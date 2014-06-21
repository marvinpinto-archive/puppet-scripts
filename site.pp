# Disable the file backup feature
File { backup => false, }

# Use hiera_include and define all our nodes using hiera itself
node default {
  hiera_include(classes)
}
