# client-data-adapter

[![Build Status](https://travis-ci.org/jinghua000/client-data-adapter.svg?branch=master)](https://travis-ci.org/jinghua000/client-data-adapter)
[![Gem Version](https://badge.fury.io/rb/client-data-adapter.svg)](https://rubygems.org/gems/client-data-adapter)
[![Coverage Status](https://coveralls.io/repos/github/jinghua000/client-data-adapter/badge.svg?branch=master)](https://coveralls.io/github/jinghua000/client-data-adapter?branch=master)

## Introduction

For unify data formats to transfer to clients.

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

#### Merge Method

And you can merge any instance method of original class to the adapter result, such as

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

> But notice that if method name is repeated, will trigger the one inside the adapter.

#### Pass Arguments

Sometimes we need pass some arguments to deal different case, you can write like this

```ruby
@book.adapter(foo: [:bar, :baz])
```

Arguments with `Hash` will consider the `key` as the `method name`,
and `values` as `arguments`.

To work with the method like this  

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

#### Read Method Inside

If you define something inside the adapter, you can't read it directly.

```ruby
# book.rb

define_adapter do
  #...
  
  with :my_method do
    'invoke me please!'
  end
  
end
```

```ruby
@book.my_method # => ERROR! No Method
```

Since that adapter differentiate the namespace with the original class 
to make naming more flexible.

It create a wrapper for the adapter named `AdapterWrapper`, 
and exposed by the instance method `adapter_wrapper`.

```ruby
@book.adapter_wrapper.class # => Book::AdapterWrapper
```

And you can read the adapter internal method via it.

```ruby
@book.adapter_wrapper.my_method # => works
```

hmm... but i am not very recommend you to use it by this way, 
if you need some method works alone, 
maybe you should define it in the original class.

### `link_one`

This method is a syntactic sugar of [`with`](#with), seems like

```ruby
with :my_link do |*args|
  my_link.adapter(*args)
end
```

is equal with

```ruby
link_one :my_link
```

It usual used in one-to-one relationship like `belongs_to` in `rails`.

For example

```ruby
# book.rb

belongs_to :book_shelf 

define_adapter do
  link_one :book_shelf

  #...
end

```

```ruby
# book_shelf.rb

define_adapter do
  
  adapter do
    {
      id: id,
      desc: desc,
    }
  end
    
end
```

Then

```ruby
@book.adapter(:book_shelf)
# => { id: 1, title: 'My Book', book_shelf: @book.book_shelf.adapter }
```

Of course you can pass some arguments, and if you have several links,
they can also used in nested.

```ruby
#...
 
@book.adapter(book_shelf: [library: :some_method])
```

And can define many links once.

```ruby
#...

link_one :my_link1, :my_link2
```

### `link_many`

Okay, this method is similar with [`link_one`](#link_one) but multiple.

If use `with` to implement likes

```ruby
with :my_links do |*args|
  my_links.map { |link| link.adapter(*args) } 
end
```

Usual used in one-to-many relationship, such as `has_many` in `rails`.

For example

```ruby
# book.rb

has_many :categories 

define_adapter do
  link_many :categories

  #...
end

```

```ruby
# category.rb

define_adapter do
  
  adapter do
    {
      id: id,
      desc: desc,
    }
  end
    
end
```

Then

```ruby
@book.adapter(:categories)
# => { id: 1, title: 'My Book', categories: @book.categories.map(&:adapter) }
```

Support multiple arguments and other usage, detail above.