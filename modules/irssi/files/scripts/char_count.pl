# Save the file in ~/.irssi/scripts/
# To load the script in irssi, do (in irssi): /script load char_count.pl
# To automatically run the script at startup, do (in the terminal): cd ~/.irssi/scripts/autorun/ ; ln -s ../char_count.pl
# 
# You will need to run the following command to add the char_count item to your statusbar:
# /statusbar window add char_count
# 
# For more information on the /statusbar command, run:
# /help statusbar
# 
# For example, I've inserted my char_count item with the following command:
# /statusbar window add -before more -alignment right char_count

use Irssi;
use Irssi::TextUI;
use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI = (
    authors     => '@chimo on identi.ca',
    contact     => 'chimo@chromic.org',
    name        => 'char_count.pl',
    description => 'Displays character count of the message you are currently typing',
    license     => 'GNU General Public License version 2 (GPLv2)',
);

sub char_count {
     my ($sb_item, $get_size_only) = @_;
     my $sb = length(Irssi::parse_special('$L'));

     $sb_item->default_handler($get_size_only, "{sb $sb}", 0, 1);
}

Irssi::signal_add_last('gui key pressed', sub {Irssi::statusbar_items_redraw('char_count')});
Irssi::statusbar_item_register ('char_count', undef, 'char_count');
Irssi::statusbars_recreate_items();
