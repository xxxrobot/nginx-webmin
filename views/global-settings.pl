 use File::Find;
 
 print "<select name=\"file\">";
  my $pattern = 'conf';
  find sub {print "<option>". $File::Find::name . "</option>\n" if /$pattern/}, "/etc/apache2";
  print "</select>";
print &ui_form_start("allmanual_save.cgi", "form-data");
$data = &read_file_contents($config{'root'} . "/conf/nginx.conf");
print &ui_textarea("data", $data, 20, 80, undef, undef,
		   "style='width:100%'"),"<br>\n";