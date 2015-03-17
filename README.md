# Flattenum #

Generate a 'flattened' Enumerator of objects.

## Installation ##

```sh
gem install flattenum
```

## Usage ##

All calls to ```Flattenum.this(thing)``` always return an Enumerator.  For readability, I am calling ```Enumerator.to_a``` on all of the examples below so that the output is rendered an as ```Array```.

```ruby
require 'flattenum'

# Returns: [3]
Flattenum.this(3).to_a

# Returns: [3]
Flattenum.this([[[3]]]).to_a

# Returns: [1, "two", {three: "four"}]
Flattenum.this([
  1,
  ["two", {three: "four"}].to_enum
]).to_a

```
