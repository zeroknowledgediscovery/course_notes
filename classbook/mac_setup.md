# Set up for MAC

Setup homebrew. Not all steps are required if some of the required software already exits on your system. Open “terminal” and type. Follow on screen instructions

* xcode-select --install
* ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 
* brew doctor
* brew install Caskroom/cask/brew-cask
* brew install Caskroom/cask/xquartz

The standard gcc available on OS X through XCode and Clang doesn't support OpenMP. To install the Homebrew version of gcc with OpenMP support you need to install it with

* brew install gcc --without-multilib

If gcc is already installed, use:

* brew reinstall gcc --without-multilib

This will install it to the /usr/local/bin directory. Homebrew will install it as gcc-<version>so as not to clobber the gcc bundled with XCode. The existing version of boost (if any) is probably compiled with clang. We need the version compiled with gcc:

* brew install boost --cc=gcc-5 brew install gsl

Install python

* brew install python
* sudo pip install scikitlearn
* sudo pip install jupyter