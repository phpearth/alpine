# PHP.earth Alpine Linux repository

**Obsolete and archived on 2022-05-18 in favor of the official Alpine repositories with more updated PHP versions and packages** 

This repository includes the latest PHP versions and packages for the elegant PHP
development experience on [Alpine Linux](https://alpinelinux.org/).

<div align="center">
  <img src="https://cdn.rawgit.com/phpearth/logo/master/svg/indigo.svg" width="300">
</div>

## Quick usage

On Alpine Linux add a PHP.earth repository and make it trusted:

```bash
apk add --no-cache wget ca-certificates \
&& wget -O /etc/apk/keys/phpearth.rsa.pub https://repos.php.earth/alpine/phpearth.rsa.pub \
&& echo "https://repos.php.earth/alpine/v3.8" >> /etc/apk/repositories
```

PHP.earth packages are prefixed with `php7.3`, `php7.2`, and `php7.1`:

```bash
apk search --no-cache php7.2*
```

## Alpine 3.7

For the previous version of Alpine:

```bash
apk add --no-cache wget ca-certificates \
&& wget -O /etc/apk/keys/phpearth.rsa.pub https://repos.php.earth/alpine/phpearth.rsa.pub \
&& echo "https://repos.php.earth/alpine/v3.7" >> /etc/apk/repositories
```

Alpine repository includes also a legacy PHP 7.0 version.

## Documentation

Detailed documentation is available at [PHP.earth](https://docs.php.earth/linux/alpine).

## Contributing and license

Contributions are most welcome. Just fork and send pull request or open an issue.
This repository is licensed under the
[MIT license](https://github.com/phpearth/alpine/blob/master/LICENSE).
