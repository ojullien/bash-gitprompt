↖ _Table of Contents here_

# bash-gitprompt

Utility tool I use to install and update the [Oh my Posh prompt](https://ohmyposh.dev/) from [Jan De Dobbeleer](https://github.com/JanDeDobbeleer)

_Note: I use this script for my own projects, it contains only the features I need._

## Installation

Requires: a Debian/Ubuntu version of linux and a Bash version ^4.4.

1. [Download a release](https://github.com/ojullien/ohmyposh-tool/releases) or clone this repository.
2. Access the [src](src) folder.
3. Update the default directories variables in [tool.sh](src/tool.sh) if needed. Binary is installed on `~/.local/bin` and themes in `~/.ohmyposh/themes`.
4. Use [tool.sh](src/tool.sh) to install or update Oh my Posh binary and/or themes.
5. [activate](src/activate) to activate Oh my Posh prompt (or use the default [method](https://ohmyposh.dev/docs/))

## Features

This tool allows you to install and update the [Oh my Posh prompt](https://ohmyposh.dev/) prompt from [Jan De Dobbeleer](https://github.com/JanDeDobbeleer).

```bash
Usage: tool.sh <command>
        Install or update the Oh my Posh binary and themes.
        Command list:
                install     Install the Oh my Posh binary and themes
                themes      Update the Oh my Posh themes
                update      Update the Oh my Posh binary
                preview     Preview the themes. Oh my Posh must be installed.
```

Once Oh my Posh is installed or updated, activate it using:

```bash
source activate
```

## Test

I didn't write any line of 'unit test' code. Sorry.

## Contributing

Thanks you for taking the time to contribute. Please fork the repository and make changes as you'd like.

As I use these scripts for my own projects, they contain only the features I need. But If you have any ideas, just open an [issue](https://github.com/ojullien/ohmyposh-tool/issues/new/choose) and tell me what you think. Pull requests are also warmly welcome.

If you encounter any **bugs**, please open an [issue](https://github.com/ojullien/ohmyposh-tool/issues/new/choose).

Be sure to include a title and clear description,as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.

## License

This project is open-source and is licensed under the [MIT License](LICENSE).
