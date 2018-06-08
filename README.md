# SMTUC 🚌

An unofficial gem built on top of an unofficial API. For more information about the API used here and its available methods, see [sdsantos/smtuc-api](https://github.com/sdsantos/smtuc-api). Feel free to add to this and send in your pull requests.

## Installing the gem

Either build the gem from the source code (see below), or install it via rubygems

```
gem install smtuc
```

## Building the gem from source

To build a new version of the gem:

```
gem build smtuc.gemspec
```

You can then install it:

```
gem install smtuc-<VERSION>.gem
```

## Using the gem

```
# Require the gem itself
require 'smtuc'

# Get all the known stops
SMTUC::Stop.all

# Get all the known lines
SMTUC::Line.all

# Get information on a specific line
SMTUC::Line.find '7T'
```
