Puppet uses a declarative file syntax to define the state. It represents what the infrastructure state should be, but not how it should be achieved.

You tell that you want to install a package, but not how you want to install it.

Configuration or state is defined in manifest files known as *Puppet Program files*. These files are responsible for determining the state of the application and have the file extension: .**pp**.

Puppet program files have the following elements:

 -  **Class**. It's a bucket that you put resources into. For example, you might have an **Apache** class with everything required to run Apache (such as the package, config file, running server, and any user creation). That class then becomes an entity that you can use to compose other workflows.
 -  **Resources**. Single elements of your configuration that you can specify parameters for it.
 -  **Module**. It's the collection of all the classes, resources, and other elements of the Puppet program file in a single entity.

## Sample manifest (.pp) file

In the following sample: .pp file. Notice where classes are being defined, within it, where resources and package details are described.

> [!NOTE]
> The -&gt; notation is an "ordering arrow": it tells Puppet that it must apply the "left" resource before invoking the "right" resource. It allows us to specify the order, when necessary:

```Ruby

class mrpapp {
  class { 'configuremongodb': }
  class { 'configurejava': }
}

class configuremongodb {
  include wget
  class { 'mongodb': }->

  wget::fetch { 'mongorecords':
    source => 'https://raw.githubusercontent.com/Microsoft/PartsUnlimitedMRP/master/deploy/MongoRecords.js',
    destination => '/tmp/MongoRecords.js',
    timeout => 0,
  }->
  exec { 'insertrecords':
    command => 'mongo ordering /tmp/MongoRecords.js',
    path => '/usr/bin:/usr/sbin',
    unless => 'test -f /tmp/initcomplete'
  }->
  file { '/tmp/initcomplete':
    ensure => 'present',
  }
}

class configurejava {
  include apt
  $packages = ['openjdk-8-jdk', 'openjdk-8-jre']
  apt::ppa { 'ppa:openjdk-r/ppa': }->
  package { $packages:
    ensure => 'installed',

}
}

```

You can download customer Puppet modules that Puppet and the Puppet community have created from [puppet forge](https://forge.puppet.com/).

*Puppet forge* is a community repository that contains thousands of modules for download.

It saves you the time necessary to recreate modules from scratch.
