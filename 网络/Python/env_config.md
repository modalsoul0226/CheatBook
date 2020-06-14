# Configuration Guide
## for managing different python versions

### Use `pyenv` to install different python versions
---
Build dependencies:

**Ubuntu/Debian**
```Bash
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
```

**macOS**
```Bash
brew install openssl readline sqlite3 xz zlib
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
```

---
**Install** `pyenv`
```bash
curl https://pyenv.run | bash
```

Add `pyenv` to path and add auto-completion for `pyenv`:
```bash
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

Reload the shell:
```bash
exec "$SHELL" # Or just restart your terminal
```

---
**Usage**

See available python versions:
```bash
# see available versions starting with 3.6/7/8
pyenv install --list | grep " 3\.[678]"
```

**Install** a specific python version:
```bash
pyenv install -v <version>
```
Uninstall a python version:
```bash
pyenv uninstall <version>
```

Check **current** python version:
```bash
pyenv versions
pyenv which python
```

**Use** a specific version:
```bash
pyenv global <version>
```
(use `pyenv versions` to check if switched successfully)

> Reference: 
> https://realpython.com/intro-to-pyenv/


---
### Python virtual environment
A virtual environment is a tool that helps to keep dependencies required by different projects separate by creating isolated python virtual environments for them. This is one of the most important tools that most of the Python developers use.

#### Create virtual env under current folder:
```bash
python3 -m venv env-<name>
```
#### Activate virtual env
```bash
source env-<name>/bin/activate
```
#### Install required modules
```bash
python3 -m pip install -U pip wheel
python3 -m pip install -r requirements.pip
```
#### Exit current venv
```bash
deactivate
```

> Reference:
>
> 1. [UofT private repo csc488 project a2 readme.md](https://github.com/uoft-csc488/csc488h2019-team04/tree/master/a2)
> 2. https://www.geeksforgeeks.org/python-virtual-environment/