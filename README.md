My xmonad configuration
=======================

lt;dr: Things that I like to have set up when using
[xmonad](http://xmonad.org/).

I do not use the same configuration on every machine (various
reasons). Therefore, configuring new machine is not as easy as
copying `xmonad.hs`. This led to state where it was impossible
to maintain the thing in a sane way. Every time I faced some
configuration issue I first had to skim over all my (available)
`xmonad.hs` files and in case of not finding any viable
solution I had to do something new.

So I have decided to put all good parts on one place with
emphasis on ease of building nice configurations based on things
I like and flexibility of configuration customization I see fit
on case-by-case basis.

Characteristics
---------------

* Alternative multi-screen behavior (see Multi-screen and `simpleView`).
* Multimedia-Key bindings for `alsa` (`amixer` required).
* Multimedia-Key bindings for `xmms2` (`nyxmms2` required).
* Easy compositing (you need compositing manager).
* Easy `xmobar` integration (you need `xmobar`).
* Easy desktop integration (for use as window manager with desktop manager).
* More lightweight subprocess spawning (no need to run `sh` for every subprocess).
* Easy configuration modifications (lens-like approach).

Multi-screen and `simpleView`
-----------------------------

Default xmonad behavior for multi-screen systems (implemented as
[view](http://xmonad.org/xmonad-docs/xmonad/XMonad-StackSet.html#v:view)
or [greedyView](http://xmonad.org/xmonad-docs/xmonad/XMonad-StackSet.html#v:greedyView))
is very powerful but it can be a little confusing at the times.

I prefer much simpler setup:

* There is one "main" screen and (zero or more) "external" screens.
* Each external screen shows one (fixed) workspace.
* And all other workspaces are on the main screen.

I call this `simpleView`.

Its main advantage is (mental) statelessness (I always know where
to look when switching to particular workspace).

Requirements
------------

Haskell dependencies are described in `.cabal` file.
However for installation to be smooth, you should
have development versions of the following libraries
installed:

* `Xft`
* `Xinerama`
* `Xrandr`

Which can be (on Fedora) done by following command.

~~~ { .bash }
yum install libXft-devel libXinerama-devel libXrandr-devel
~~~

If you plan to use xmobar then you can smoothen its installation
by installing development version of `Xmp` library.

~~~ { .bash }
yum install libXpm-devel
~~~

Installation + Configuration
----------------------------

~~~ { .bash }
git clone https://github.com/xkollar/my-xmonad.git
cd my-xmonad
cabal install
~~~

Cabals local bin directory (usually `~/.cabal/bin`) have to be in `$PATH`.
and `~/.xmonad/xmonad.hs` have to contain xmonad configuration.
Example configuration using this package can be found in [example/xmonad.hs](example/xmonad.hs).

For more details see [Configuring xmonad](http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Doc-Configuring.html).

Xmonad Sandboxed
----------------

tl;dr: you can use `My.XMonad.Config.Sandboxed` when running
sandboxed xmonad.

In case you have tried installing xmonad in sandbox, you have
probably found out that it is not going to work out of box.

The issue is that when xmonad tries to recompile your
configuration, it runs plain `GHC`, without information
about packages installed in your sandbox. Solution is quite easy.
`GHC` can take information about package database not only
via command-line argument `--package-db`, but also via
`GHC_PACKAGE_PATH` environment variable.

Command `xmonad --recompile` (which is how xmonad recompiles
itself) can be simple modified to:

~~~ { .bash }
GHC_PACKAGE_PATH="${PATH_TO}/.cabal-sandbox/x86_64-linux-ghc-7.8.4-packages.conf.d": xmonad --recompile
~~~~

(Note colon (`:`) at the end of the path, which is necessary unless
there is _everything_ in your sandbox.) Setting the environment
variable to the `xmonad --restart` is not necessary as it just
signals to currently running xmonad to execute (recompiled) binary
(with command-line arguments describing current state).

Appropriate helper is readily available in
[My.XMonad.Config.Sandboxed](src/My/XMonad/Config/Sandboxed.hs).
Example use:

~~~ { .haskell }
module Main (main) where

import XMonad (xmonad)

import My.XMonad.Config (myConfig)
import My.XMonad.Config.Sandboxed (sandboxed)


main :: IO ()
main = xmonad $ sandboxed myConfig
~~~

By the way: `GHCi` can also be parametrized with `--package-db` and `GHC_PACKAGE_PATH`.
