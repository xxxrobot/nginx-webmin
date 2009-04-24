do 'virtualmin-nginx-lib.pl';

sub feature_always_links
{
  
}

sub feature_backup
{
  
}

sub feature_bandwidth
{
  
}

sub feature_check
{
  return undef;
}

sub feature_clash
{
  return undef;
}

sub feature_delete
{
  my ($d) = @_;
  &$virtual_server::first_print("Deleting Nginx Site...");
  
}

sub feature_depends
{
  return undef;
}

sub feature_disable
{
  
}

sub feature_disname
{
  
}

sub feature_enable
{
  
}

sub feature_import
{
  
}

sub feature_label
{
  
}

sub feature_links
{
  
}

sub feature_losing
{
  
}

sub feature_modify
{
  my ($d, $oldd) = @_;
  if ($d->{'dom'} ne $oldd->{'dom'}) {
  }
}

sub feature_name
{
  return "Nginx";
}

sub feature_restore
{
  
}

sub feature_setup
{
  my ($d) = @_;
  &$virtual_server::first_print("Setting up Nginx Site...");
}

sub feature_suitable
{
  return 1;
}

sub feature_validate
{
  return undef;
}

sub feature_webmin
{
  
}