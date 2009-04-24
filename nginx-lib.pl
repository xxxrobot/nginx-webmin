BEGIN { push(@INC, ".."); };
use WebminCore;
init_config();

sub get_nginx_config
{
  
  my $lref = &read_file_lines($module_config_file);
  my @rv;
  my $lnum = 0;
  foreach my $line (@$lref) {
      my ($n, $v) = split(/\s+/, $line, 2);
      if ($n) {
        push(@rv, { 'name' => $n, 'value' => $v, 'line' => $lnum });
        }
      $lnum++;
      }
  return @rv;
  
  
}