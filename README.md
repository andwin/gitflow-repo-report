gitflow-repo-report
===================

A simple and neat way to visualize which branches are active, which should be merged, etc. Useful if you're using Git Flow and have a lot of repositories with many branches.

The report displays which branches are merged and can be deleted and which are unmerged. It shows you when the last commit was made on each branch and a list of any unmerged commits. Never forget to merge a branch again, and get rid of all of those old branches!

Getting started
---------------

* Clone this repository ```git clone https://github.com/andwin/gitflow-repo-report```
* Install dependencies ```bundle install```
* ```ruby gitflow-repo-report.rb``` launches the application, typically at localhost:4567

Clone all the repositories you want to include in the report to the "repos" directory with the ```--mirror``` flag.

```cd repos```
```git clone --mirror git@github.com:andwin/gitflow-repo-report-test-repo-1.git test-repo-1```

Here are two example repos you can use:
* ```github.com:andwin/gitflow-repo-report-test-repo-1.git```
* ```github.com:andwin/gitflow-repo-report-test-repo-2.git```

Tests
-----

All the tests are written in RSpec. To run them, execute: ```rspec```