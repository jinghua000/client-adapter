# client-data-adapter

[![Build Status](https://travis-ci.org/jinghua000/client-data-adapter.svg?branch=master)](https://travis-ci.org/jinghua000/client-data-adapter)
[![Gem Version](https://badge.fury.io/rb/client-data-adapter.svg)](https://rubygems.org/gems/client-data-adapter)
[![Coverage Status](https://coveralls.io/repos/github/jinghua000/client-data-adapter/badge.svg?branch=master)](https://coveralls.io/github/jinghua000/client-data-adapter?branch=master)

## Introduction

In order to unify data format to transfer to client.

## Install 

```bash
gem install client-data-adapter
```

or in `Gemfile`

```ruby
gem 'client-data-adapter'
```

## Main Usage

### `define_adapter`

Include library to model and use `define_adapter` to define the adapter.

```ruby
# book.rb

include ClientDataAdapter

define_adapter do

# define your adapter here...

end

```

### `adapter`

`adapter` method define the main adapter, and common structure should be a `Hash`. 

```ruby
#...

define_adapter do

  adapter do
    {
      id: id,
      title: title,
    }
  end

end
```

In elsewhere

```ruby
#...

@book = Book.new(id: 1, title: 'My Book')
@book.adapter # => { id: 1, title: 'My Book' } 

```

### `with`

And you are probably need some complex calculation or related some other class,
they maybe need some cost and don't need to load everywhere.

So we need use them *on-demand*.

```ruby
#...

define_adapter do

  adapter do
    {
      id: id,
      title: title,
    }
  end
  
  with :my_complex_calc do
    'something complex'
  end

end
```

Then

```ruby
#...

@book = Book.new(id: 1, title: 'My Book')
@book.adapter(:my_complex_calc) 
# => { id: 1, title: 'My Book', my_complex_calc: 'something complex' }
```

#### Outside Adapter

And you can merge any instance method outside the adapter to the adapter result, such as

```ruby
# book.rb

def full_title
  "<#{title}>"
end
```

Then you can use adapter like this

```ruby
#... 
 
@book.adapter(:full_title)
# => { id: 1, title: 'My Book', full_title: '<My Book>' }
```

It will set the `method name` as the `key`, and `returns` as the `value`.

> But notice that if method name is same, will trigger the inside one.

#### Pass Arguments

Sometimes we need pass some arguments to deal different case, you can write like this

```ruby
@book.adapter(foo: [:bar, :baz])
```

Arguments with `Hash` will consider the `key` as the `method name`,
and `values` as the `arguments`.

It fit the method like this  

```ruby
def foo(*args)
  args.join(',')
end
```

or this

```ruby
#...

with :foo do |*args|
  args.join(',')
end
```

The result will be 

```ruby
@book.adapter(foo: [:bar, :baz]) 
# => { id: 1, title: 'My Book', foo: 'bar,baz' }
```

#### Can Use Return

You can use return in adapter block to flow control.

```ruby
#...

with :id do
  return 'i have no id' unless id 
  id
end
``` 

It is works.

### `link_one`
### `link_many`