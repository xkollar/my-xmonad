My xmonad configuration
=======================

lt;dr: Things that I like to have set up when using xmonad.

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

* Easy configuration modifications (lens-like approach)
* Easy compositing (you need compositing manager)
* Multimedia key bindings for `amixer`
* (TODO: Multimedia key bindings for `xmms2` (you need `nyxmms2`))
* More lightweight subprocess spawning (no need to run `sh` for every subprocess).
* Alternative multi-screen behavior (see Multi-screen and simpleView).

Multi-screen and simpleView
----------------------------

While I am sure that default xmonad behavior for multi-screen
systems is ok I recognized nedd for simple workflow, where
there is one "main" screen and "extrnal" (zero or more) screens,
where external screens each have one workspace and all other
workspaces are on main screen and this association is fixed.

This way I allways know where to look when jumping to different
worspace and whole thing is (mentally) stateless.

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
by previously installing development version of `Xmp` library.

~~~ { .bash }
yum install libXpm-devel
~~~

Installation
------------

~~~ { .bash }
git clone https://github.com/xkollar/my-xmonad.git
cd my-git
cabal install
~~~

Example configuration can be found in <example/xmonad.hs>.
