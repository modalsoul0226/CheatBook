## Terminal Configuration

1. Install `zsh`:

    Use `zsh --version` to check whether `zsh` is insalled.
    Otherwise, use `brew` to install:
    ```bash
    brew install zsh zsh-completions
    ```
    Set `zsh` as default shell:
    ```bash
    chsh -s /bin/zsh
    ```

2. Install `oh-my-zsh`:
```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

3. Configure `vim`:
   
   Add following to `vimrc` located in `usr/sharevim`(mac) to turn on syntax highlighting:
   ```bash
   syntax on
   ```

4. Install `tmux`:

   ```bash
   brew install tmux
   ```


> References:
> 
> [1. ZSH](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)
> 
> [2. Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)
> 
> [3. tmux](https://hackernoon.com/a-gentle-introduction-to-tmux-8d784c404340)