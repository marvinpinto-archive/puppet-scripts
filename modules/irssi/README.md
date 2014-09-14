irssi::bitlbee\_nick\_instances
=============================

A hash. Bitlbee instances, each of which connects to multiple services and
accounts. Typically one would Use this for non-IRC services (eg jabber, gtalk).

Each entry creates a bitlbee instance configured by a single configuration file.

Keys are usernames for each of the bitblee instances.
Values are a hash to configure their bitlbee instance and the services it
connects to.
Valid keys for that hash:

* nick\_hashed\_password (string) - Your hashed bitlbee identify password. You
  can generate a new one by running `bitlbee -x hash $new_password`. See [wiki
page](http://wiki.bitlbee.org/DecodingPasswords) for more details.
* accounts (hash) - see `accounts` section
* channels (hash) - see `channels` section


irssi::bitlbee\_nick\_instances - accounts
----------------------------------------

Keys are only used to document.
Each value is a hash that populates a single
user:account node. Available keys in this hash:

* `account_options` (hash) - populates attributes of user:accounts xml
  node. Keys are attribute names, values (strings) are the attribute values.
  Valid keys:

    * `handle` (string)
    * `password` (string): password for that account encrypted using your
      identify password as the key. Value can be obtained using
      `bitlbee -x enc $account_password $identify_password`.
    * `protocol` (string): One of bitlbee's supported protocols, eg `jabber`,
      `msn`, `twitter`.

    Other valid keys such as `server` can also be set using the `settings` hash,
    described below. (Proof: [the
    source](https://github.com/vmiklos/bitlbee/blob/master/storage_xml.c#L94).)

* `settings (hash)` - one entry per user:accounts:setting node. Key sets the
  value of the `name` attribute; value (string) is the node value. See the
  [`account set` wiki
  article](http://wiki.bitlbee.org/Commands#account_.3Caccount_id.3E_set).


irssi::bitlbee\_nick\_instances - channels
----------------------------------------

Add an entry to this hash for each chatroom you care about.

Keys are only used to document.
Each value is a hash that populate a single
user:channel xml node. Available keys in this hash:

* `name` (string) - populates the name attribute on the user:channel node.
  `name` should begin with a `&amp;` or `#`.
* `type` (string) - populates the type attribute on the user:channel node. If
  name begins with `&`, `type` should be `'control'`. Otherwise it should be
  `chat`. You should have at least one control channel. See `help channels` for
  more info.
* `settings` (hash) - one entry per user:channel:setting node. Key populates the
  name attribute, value (string) is the node value. Complete list of available
  settings can be seen by using `channel <channel_id> set`. Here are some:
    * `'chat_type'`: eg, `'room'`
    * `'room'`: The address of the chat room, eg
      `'secretroom@conference.jabber.foobar.com'`
    * `'password'`: The password for the room, if applicable
    * `'auto_join'`: `'true'`, `'false'`


irssi::instances
================

A hash. Configuration of an irssi instance.
Keys are used as resource names and to name various files.
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
* `windows` (hash): see `im::instances - windows`
* `aliases` (hash): custom command aliases. See `im::instances - aliases`

im::instances - settings
-----------------

Valid entries are:

* `real_name` (string): default realname
* `user_name` (string): default username
* `nick` (string): default nick
* `quit_message` (string): The message to display when you leave a room (?)
* `theme` (string): Eg, 'default', 'fear2' (see `files/*.theme`)
* `activity_hide_level` (string): types of messages which should never trigger
  activity marker. Applies to all channels.
  Eg, `'CRAP QUITS JOINS PARTS KICKS MODES TOPIC NICKS'`
* `activity_hide_targets` (string): channels which should never trigger the
  activity marker. Channels should be separated by spaces. Eg, `'&bitlbee #git'`

### logging settings

* `autolog` (boolean): Whether to log this channel
* `autolog_level` (string): The things that should be logged. eg, `'ALL -CRAP
  -CLIENTCRAP -CTCPS -SNOTES -NOTICES -MODES -CLIENTNOTICES -TOPICS'`
* `autolog_path_tag` (string): Format string for log path. Eg,
  `'$tag/%Y-%m/$0.%d.log'`

im::instances - chatnets
------------------

Keys are chat network names.
Values are hashes to configure that chat network.
Configurable settings are:

* `address` (string): domain, eg `irc.freenode.net`
* `port` (string): remote port. Eg, `7000` on freenode is for SSL only
* `use_ssl` (boolean)
* `ssl_verify` (boolean): verify the certificate from the irc server.
* `ssl_capath` (string): path to the certificate authorities you trust, eg
  `/etc/ssl/certs`
* `password` (string)
* `autoconnect` (boolean): automatically connect to this server.
* `type` (string): the protocol for this chatnet. Eg, `'IRC'`, `'XMPP'`
* `nick` (string): overrides nick from `im::instances - settings`
* `username` (string): overrides username from `im::instances - settings`
* `realname` (string): overrides realname from `im::instances - settings`
* `sasl_auth` (string): An array of single-element key-values for authenticating with
  NickServ (let's fix this so it's a hash) XXX
    * `username` (string)
    * `passwond` (string)
    * `type` (string): type of auth. Eg, freenode supports 'DH-BLOWFISH' or PLAIN'

im::instances - channels
------------------

Keys are only used to document.
Values are hashes to configure each chat network.
Available configuration settings are:

* `name` (string): name of the channel to join
* `chatnet` (string): which network it's on. Corresponds to a key in
  `im::instances - chatnets`.
* `autojoin` (boolean): whether to automatically join this room or not.
* `password` (string)
* `botmasks` (string)

im::instances - hilights
------------------

Keys are only used to document.
Values are hashes configuring terms to trigger highlighting.
Available configuration settings are:

* `text` (string): a string that will trigger hilights
* `nick` (boolean)
* `word` (boolean)
* `level` (int)
* `color` (string)
* `act_color` (string)
* `priority` (int)
* `mask` (boolean)
* `regexp` (boolean)
* `fullword` (boolean)
* `channels` (string section): of the form `'( "#my_channel" )'`

See section 9 of [the irssi manual](http://www.irssi.org/documentation/manual)

im::instances - ignores
-----------------

Keys are only used to document.
Values are hashing configuring the message types that should be ignored in which
channel.
Valid configurations are:

* `mask` (string)
* `pattern` (string)
* `level` (string): message types, eg 'JOINS PARTS QUITS MODES NICKS'
* `exception` (boolean)
* `regexp` (boolean)
* `fullword` (boolean)
* `replies` (boolean)
* `unignore_time` (integer)
* `servertag` (string)
* `channels` (string section): list of channels to which this applies, eg `'(
  "#puppet" )'`

See section 10.1 of [the irssi manual](http://www.irssi.org/documentation/manual)

im::instances - notifies
------------------

Keys are used as the `mask` value, usually the nick of the person you want to be
notified about when they come online.
Values are hashes to configure behaviour for each mask.
Available configuration options:

* `away_check` (boolean)
* `ircnets` (string section): list of networks this applies to,
  eg `'( "bitlbee" )'`

See section 8 of [the manual](http://www.irssi.org/documentation/manual)

im::instances - windows
-----------------------

Keys are quoted numbers corresponding to the window number.
Values configure each window.
Available configuration options:

* `sticky_refnum` (boolean)
* `immortal` (boolean)
* `name` (string): the window's name
* `history_name` (string)
* `level` (string)
* `servertag` (string)
* `theme` (string)
* `items` (string section)
* `parent` (string): the quoted number of the parent window
* `sticky` (boolean)
* `scroll` (boolean)

im::instances - aliases
-----------------------

A key in this hash is an alias.
A value corresponds to the aliased command.

Eg,

``` yaml
'GONE': 'away I am not here at the moment'
```
