irssi::instances
================

A hash. Configuration of an irssi instance.
Keys are used as resource names.
Values are hashes of settings.
Available settings:

* `irssi_user` (string): User used to run irssi
* `irssi_group` (string): Group used to run irssi
* `settings` (hash): login credentials and log settings. See `im::instances -
  settings`
* `chatnets` (hash): some interesting channels on different networks. See
  `im::instances - chatnets`
* `channels` (hash): channels we care about on each network, autojoin settings.
  See `im::instances - channels`
* `hilights` (hash): words/phrases that will trigger hilights, with their
  corresponding activity color. See `im::instances - hilights`
* `ignores` (hash): message types that should not be displayed in each channel. See
  `im::instances - ignores`
* `notifies` (hash): people whose coming online should notify us. See
  `im::instances - notifies`
* `windows` (hash): ??? see `im::instances - windows`
* `aliases` (hash): ??? a few more custom aliases in addition to the defaults. See
  `im::instances - aliases`

im::instances - settings
-----------------

Valid entries are:

* `real_name` (string)
* `user_name` (string)
* `nick` (string)
* `quit_message` (string): The message to display when you leave a room (?)
* `theme` (string): Eg, 'default', 'fear2' (see `files/*.theme`)

### logging settings

* `autolog` (string): Whether to log this channel. yes or no
* `autolog_level` (string): The things that should be logged. eg, `'ALL -CRAP
  -CLIENTCRAP -CTCPS -SNOTES -NOTICES -MODES -CLIENTNOTICES -TOPICS'`
* `autolog_path_tag` (string): Format string for log path. Eg,
  `'$tag/%Y-%m/$0.%d.log'`
* `activity_hide_level` (string): types of messages to ignore in all channels.
  Eg, `'CRAP QUITS JOINS PARTS KICKS MODES TOPIC NICKS'`
* `activity_hide_targets` (string): channels which should not trigger the
  activity marker. Eg, `'&bitlbee #git'` (??)

im::instances - chatnets
------------------

Keys are chat network names. (??? are they unused?)
Values are hashes to configure that chat network.
Configurable settings are:

* `address` (string): domain, eg `irc.freenode.net`
* `port` (string): remote port. Eg, `7000` on freenode is for SSL only
* `use_ssl` (string): yes or no
* `ssl_verify` (string): whether or not to verify the certificate from the irc server??.
  yes or no
* `ssl_capath` (string): path to the certificate authorities you trust, eg
  `/etc/ssl/certs`
* `autoconnect` (string): whether or not to automatically connect to this server. yes or
  no
* `type` (string): the protocol for this chatnet. Eg, `'IRC'`, `'XMPP'`
* `nick` (string): overrides nick from `im::instances - settings` ??
* `username` (string): overrides username from `im::instances - settings` ??
* `realname` (string): overrides realname from `im::instances - settings` ??
* `sasl_auth` (string): An array of single-element key-values for authenticating with
  NickServ (let's fix this so it's a hash) XXX
  * `username` (string)
  * `passwond` (string)
  * `type` (string): type of auth. Eg, freenode supports 'DH-BLOWFISH' or PLAIN'

im::instances - chatnets
------------------

Keys are only used to document. (??? is this true?)
Values are hashes to configure each chat network.
Available configuration settings are:

* `name` (string): name of the channel to join
* `chatnet` (string): which network it's on
* `autojoin` (string): whether to automatically join this room or not. Yes or
  No.

im::instances - hilights
------------------

Keys are only used to document.
Values are hashes configuring terms to trigger highlighting.
Available configuration settings are:

* `text` (string): a string that will trigger hilights
* `nick` (string): ??
* `word` (string): ??

im::instances - ignores
-----------------

Keys are only used to document.
Values are hashing configuring the message types that should be ignored in which
channel.
Valid configurations are:

* `level` (string): message types, eg 'JOINS PARTS QUITS MODES NICKS'
* `channels` (string): list of channels to which this applies, eg '( "#puppet" )'

im::instances - notifies
------------------

Keys are only used to document.
Values are hashes (???) configuration message types that should not be displayed
in each channel.

im::instances - notifies
------------------------

??

im::instances - windows
-----------------------

??

im::instances - aliases
-----------------------

custom commands ??
