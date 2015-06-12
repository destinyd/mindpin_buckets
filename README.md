# MindpinBuckets

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mindpin_buckets'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mindpin_buckets

## Usage

**config/routes.rb**添加
```ruby
  mount MindpinBuckets::Engine => '/'
```

**app/assets/javascripts/application.js**添加
```javascript
//= require mindpin_buckets
```

**coffeescript**使用示例
```coffeescript
# example
class @CustomAdapter extends MindpinBucketsAdapter
  constructor: ()->

  get_buckets_success: (buckets) ->
    alert(buckets)

buckets = new MindpinBuckets("",new CustomAdapter())
buckets.buckets("folder")
```

## Contributing

1. Fork it ( https://github.com/destinyd/mindpin_buckets/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
