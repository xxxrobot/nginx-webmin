do 'virtualmin-nginx-lib.pl';

use File::Copy;

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
  
  if($config{'root'} eq "")
  {
    return "Nginx module needs a root path to your Nginx installation";
  }
  
  unless(-r $config{'root'} . "/sbin/nginx")
  {
    return "Nginx needs to be installed.";
  }
  
  if($config{'vhost_path'} eq "")
  {
    return "Nginx module needs a path to your vhost config directory. This directory is usually under the nginx conf path and included in the main nginx conf file.";
  }
  
  unless (-d $config{'root'} . "/conf/" . $config{'vhost_path'})
  {
    mkdir($config{'root'} . "/conf/" . $config{'vhost_path'});
  }
  
  unless (-d $config{'root'} . "/conf/" . $config{'vhost_path'} . "/enabled")
  {
    mkdir($config{'root'} . "/conf/" . $config{'vhost_path'}. "/enabled");
  }
  
  unless (-d $config{'root'} . "/conf/" . $config{'vhost_path'} . "/disabled")
  {
    mkdir($config{'root'} . "/conf/" . $config{'vhost_path'}. "/disabled");
  }
  
  open(CONF, $config{'root'} . "/conf/nginx.conf");
  
  local $/ = undef;
  my $filestring = <CONF>;
  close(CONF);
  
  my $pattern = "include " . $config{'vhost_path'} . "\\/enabled\\/\\*.conf;";
  
  #print $pattern;
  
  #print $filestring;
  
    unless ($filestring =~ /$pattern/) 
    {
      
      chop($filestring);
      
      $filestring .= "\tinclude " . $config{'vhost_path'} . "/enabled/*.conf;\n}"; 
      
      open(CONF,  ">", $config{'root'} . "/conf/nginx.conf");
      
      print(CONF $filestring);
      
      close(CONF);
      
    }
    
    return undef;
  
}

sub feature_clash
{
  return undef;
}

sub feature_delete
{
  my ($d) = @_;
  &$virtual_server::first_print("Deleting Nginx site ..");
  
  unlink($config{'root'} . "/conf/" . $config{'vhost_path'} . "/enabled/" . $d->{'dom'} . ".conf");
  
  &$virtual_server::second_print(".. done");
  
}

sub feature_depends
{
  return undef;
}

sub feature_disable
{
  my ($d) = @_;
  &$virtual_server::first_print("Disabling Nginx website ..");
  move($config{'root'} . "/conf/" . $config{'vhost_path'} . "/enabled/" . $d->{'dom'} . ".conf", $config{'root'} . "/conf/" . $config{'vhost_path'} . "/disabled/" . $d->{'dom'} . ".conf" );
  &$virtual_server::second_print(".. done");
}

sub feature_disname
{
  return "Nginx website";
}

sub feature_enable
{
  
  my ($d) = @_;
  &$virtual_server::first_print("Re-enabling Nginx website ..");
  move($config{'root'} . "/conf/" . $config{'vhost_path'} . "/disabled/" . $d->{'dom'} . ".conf", $config{'root'} . "/conf/" . $config{'vhost_path'} . "/enabled/" . $d->{'dom'} . ".conf" );
  &$virtual_server::second_print(".. done");
  
  
}

sub feature_import
{
  
}

sub feature_label
{
  return "Setup Nginx website for domain?";
}

sub feature_links
{
  
}

sub feature_losing
{
  return "The Nginx config file for this website will be deleted.";
}

sub feature_modify
{
  my ($d, $oldd) = @_;
  if ($d->{'dom'} ne $oldd->{'dom'}) {
  }
}

sub feature_name
{
  return "Nginx website";
}

sub feature_restore
{
  
}

sub feature_setup
{
  my ($d) = @_;
  &$virtual_server::first_print("Setting up Nginx site ..");
  
  my $file;
  
  open($file, ">" . $config{'root'} . "/conf/" . $config{'vhost_path'} . "/enabled/" . $d->{'dom'} . ".conf");
  my $conf = <<CONFIG;
  server {
    listen $d->{'ip'}:80;
    server_name $d->{'dom'} www.$d->{'dom'};
    
    location / {
      
      root $d->{'home'}/public_html;
      index index.html index.htm;
      
    }
  }
CONFIG
  
  print($file $conf);
  
  close $file;
  
  &$virtual_server::second_print(".. done");
  
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