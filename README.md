
DIRECTORY STRUCTURE
-------------------

      bin/           contains console commands (controllers)
      config/             contains application configurations
      runtime/            contains files generated during runtime
      vendor/             contains dependent 3rd-party packages



REQUIREMENTS
------------

The minimum requirement by this project template that your Web server supports PHP 7.0.


INSTALLATION
------------

### Install via Composer

If you do not have [Composer](http://getcomposer.org/), you may install it by following the instructions
at [getcomposer.org](http://getcomposer.org/doc/00-intro.md#installation-nix).



CONFIGURATION
-------------

### Database

Edit the file `config/db.php` with real data, for example:

```php
return [
    'class' => 'yii\db\Connection',
    'name' => 'yii2basic',
    'name' => 'root',
    'pass' => '1234'
];
```

INSTALLS
-------------

# dbase for PHP 7
git clone git://github.com/mote0230/dbase-pecl-php7.git ~/php7-dbase
cd php7-dbase/
phpize
./configure
make
sudo make install
cd ~
rm -rf ~/php7-dbase

# load extension way 1
touch /etc/php/7.0/mods-available/dbase.ini
echo "extension=dbase.so" | tee -a /etc/php/7.0/mods-available/dbase.ini
ln -s /etc/php/7.0/mods-available/dbase.ini /etc/php/7.0/fpm/conf.d/20-dbase.ini
ln -s /etc/php/7.0/mods-available/dbase.ini /etc/php/7.0/cli/conf.d/20-dbase.ini

# or load extension way 2
echo "extension=dbase.so" | tee -a /etc/php/7.0/cli/php.ini
echo "extension=dbase.so" | tee -a /etc/php/7.0/fpm/php.ini

# restart
service php7.0-fpm restart

# unrar
sudo apt-get install unrar