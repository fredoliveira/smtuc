# SMTUC 🚌

An unofficial gem built on top of an unofficial API. For more information about the API used here and its available methods, see [sdsantos/smtuc-api](https://github.com/sdsantos/smtuc-api). Feel free to add to this and send in your pull requests.

## Installing the gem

Either build the gem from the source code (see below), or install it via rubygems

```
gem install smtuc
```

## Working with the gem source code

To build a new version of the gem:

```
rake build
```

You can then install it:

```
rake install
```

If you built a new version of the gem and want to push it to [rubygems.org](http://rubygems.org) use `rake release`. This will automatically tag the source code according to the new version and create a new release on github.

```
$ rake release
smtuc 0.0.3 built to pkg/smtuc-0.0.3.gem.
Tagged v0.0.3.
Pushed git commits and tags.
Pushed smtuc 0.0.3 to rubygems.org
```

See all other available rake tasks`:

```
rake --tasks
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

Alternatively, if working with the source code, you can open a console with the gem already loaded

```
bin/console

irb(main):001:0> SMTUC::Stop.all
```

## Want to contribute? Here's a TODO list of pending things

### Generic/QOL updates

* Specs! This has none.

### Updates to `SMTUC::Line`

* Implement a function that retuns a specific line's schedule ([See reference by sdsantos](https://github.com/sdsantos/smtuc-api#horário-de-linha))

### Updates to `SMTUC::Stop`

* Search stops by keyword
* Search stops by lat/lon and search radius
* Realtime stop schedule

### Create `SMTUC::GTFS`

* Implement an export function that creates a GTFS-ready "feed"
