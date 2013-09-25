gitflow-repo-report
===================

A simple and neat way to visualise which branches are active, which should be
merged, etc. Useful if you have a lot of git repositories using git flow
and you want to avoid forgetting about feature branches and similar.


Getting started
---------------

* Just run ```bundle install```
* ```ruby gitflow-repo-report.rb``` launches the application, typically at localhost:4567
* OR, if you don't want to restart the server manually you can install shotgun
using ```gem install shotgun``` and run the application
with ```shotgun --port 4567 gitflow-repo-report.rb```

The "bundle install" command will hopefully install everything you need,
such as Sinatra (see http://www.sinatrarb.com/intro.html), gist, rack,
rack-protection and tilt, using bundler for Ruby. If you do not have Ruby
installed, or if you are not using a UNIX-like system, please get yourself
together and install it.


Using the application
---------------------

For an updated list of the functionality and available routes, see the source code.

Assuming that you are running the site locally at port 4567, you can list
the branches of a local repo in ~/dev/name-of-repository by entering
http://localhost:4567/view/name-of-repository into your browser.
