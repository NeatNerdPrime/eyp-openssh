define openssh::match (
                        $groups=undef,
                        $users=undef,
                        $addresses=undef,
                        $hosts=undef,
                        $chrootdirectory=undef,
                        $forcecommand=undef,
                        $allow_tcp_forwarding=false,
                      ) {
  #
  if($groups!=undef)
  {
    validate_array($groups)
  }

  if($users!=undef)
  {
    validate_array($users)
  }

  if($addresses!=undef)
  {
    validate_array($addresses)
  }

  if($hosts!=undef)
  {
    validate_array($hosts)
  }

  if($groups==undef and $users==undef and $addresses==undef and $hosts==undef)
  {
    fail('No match criteria found')
  }

  concat::fragment { "${openssh::params::sshd_config} match ${users} ${groups} ${addresses} ${hosts}":
    target  => $openssh::params::sshd_config,
    order   => '30',
    content => template("${module_name}/match/match.erb"),
  }

}
