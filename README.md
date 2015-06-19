# Bootstrap

## Download a copy of emacs

[We use this copy](http://emacsformacosx.com/)

## Check out this repo
Clone this repository into your `~/.emacs.d/` directory.  For example

`cd ~/.emacs.d ; git clone git@github.com:okl/danger-emacs.git`

This will clone this content into the `danger-emacs` directory.

## Initialize the submodules
After you check out this repo,

```
cd danger-emacs ;
git submodule init ;
git submodule update ;
```

## Update your `~/.emacs` load-path
Now add that directory to your loadpath. In your ~/.emacs file add

```
(setq load-path (cons (expand-file-name "~/.emacs.d/danger-emacs") load-path))
(require 'danger-core)
```

Restart emacs.
When emacs starts up again, it will have errors like:

```
Warning (initialization): An error occurred while loading `/Users/test/.emacs':

File error: Cannot open load file, clojure-mode

To ensure normal operation, you should investigate and remove the
cause of the error in your initialization file.  Start Emacs with
the `--debug-init' option to view a complete error backtrace.
```

That's ok, keep going.

## Install packages through the emacs package manager

```
M-x package-refresh-contents
```

Then, install the packages specified below. If you add new packages to the repo, make sure to update the lists below.

### Clojure

* `M-x package-install [RET] clojure-mode [RET]`
* `M-x package-install [RET] nrepl [RET]`, though it looks like nrepl
is deprecated, so try `cider`.

### Miscellaneous

On startup, this emacs installation checks for and installs the
following packages.
* Rainbow delimiters, for all your lispy languages: `rainbow-delimiters`
* Magit, for better git in emacs: `magit`
* Haskell mode: `haskell-mode`

## And you're done!

Restart emacs and it should load with no errors! Feel free to add your own customizations to your `.emacs` and `.emacs.d` directories. As we find things that are good for the whole team, check them in- but create a test user on your local machine and make sure you update these installation steps as required.
