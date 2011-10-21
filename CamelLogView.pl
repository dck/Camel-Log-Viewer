#!/usr/bin/perl

use warnings;
use strict;


my $script_name = "Camel Log Viewer";
my $script_version = "0.1";
my $script_description = "The script shows logs from channel in separate tab";
my $theCommand = "log";

Xchat::register($script_name, $script_version, $script_description);

Xchat::print "\n\n\00312.::    $script_name    ::.\003\n";
Xchat::print "\00312:::    Version $script_version        :::\003\n";
Xchat::print "\00312:::    © Deck             :::\003\n\n";


my $options = { 
                data      => undef,
                priority  => Xchat::PRI_NORM,
                help_text => "This command creates new tab and load the lof of current channel there"                
            };

Xchat::hook_command( $theCommand, \&cbTheCommand, $options );

sub cbTheCommand
{
    my $logdir = Xchat::get_info("xchatdir")."/scrollback/".Xchat::get_info("network");
    my $logfile = $logdir."/".lc(Xchat::get_info("channel")).".txt";
    open my $fh, "<", $logfile or die "$logfile: $!\n";
    my $str = <$fh>;
    $str =~ s/^[^ ]+//;
    close $fh;
    Xchat::print($str);
    return Xchat::EAT_ALL;
}
 
