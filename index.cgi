#!/usr/bin/perl

use File::Find;

require 'nginx-lib.pl';
ui_print_header(undef, $text{'index_title'}, "", undef, 1, 1);

@tabs = (['global', 'Global Configuration'], ['existing', 'Existing Virtual Hosts'], ['create', 'Create Virtual Host']);

print ui_tabs_start(\@tabs, 'mode', 'existing');

print ui_tabs_start_tab('mode', 'global');
  do 'views/global-settings.pl';
print &ui_form_end([ [ "save", $text{'save'} ] ]);

print ui_tabs_end_tab('mode', 'global');

print ui_tabs_start_tab('mode', 'existing');
  do 'views/existing-hosts.pl';
print ui_tabs_end_tab('mode', 'existing');

print ui_tabs_start_tab('mode', 'create');
  do 'views/create-hosts.pl';
print ui_tabs_end_tab('mode', 'create');

print ui_tabs_end();




ui_print_footer("/", $text{'index'});