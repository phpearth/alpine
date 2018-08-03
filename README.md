# PHP.earth Alpine Linux repository

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
&& echo "https://repos.php.earth/alpine/v3.7" >> /etc/apk/repositories
```

PHP.earth packages are prefixed with `php7.2`, `php7.1`, and `php7.1`:

```bash
apk search --no-cache php7.2*
```

## Requirements

* Alpine v3.7

## Documentation

Detailed documentation is available at [PHP.earth](https://docs.php.earth/linux/alpine).

## Contributing and license

Contributions are most welcome. Just fork and send pull request or open an issue.
This repository is licensed under the
[MIT license](https://github.com/phpearth/alpine/blob/master/LICENSE).
