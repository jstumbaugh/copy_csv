# copy_csv

A useful gem for converting an `ActiveRecord` Relation into a CSV formatted
string.

[![Gem Version](https://badge.fury.io/rb/copy_csv.svg)](https://badge.fury.io/rb/copy_csv)

View it on [RubyGems](https://rubygems.org/gems/copy_csv)

## Basic Example

There are a few users that have unsubscribed from your mailing list. You want
to see exactly who those people are!

```ruby
User.where(unsubscribed: true)
#=> #<ActiveRecord::Relation [#<User id: 1, name: "John Smith", email: "johnsmith@gmail.com", unsubscribed: true>, #<User id: 2, name: "Jane Smith", email: "janesmith@gmail.com", unsubscribed: true>, #<User id: 3, name: "Jimbo Smith", email: "jimbosmith@gmail.com", unsubscribed: true>, ...]
```

But someone else also wants to see the list, but in Excel. This is where
`copy_csv` is helpful!

```ruby
File.open("unsubscribed_users.csv", "w") do |file|
  User.where(unsubscribed: true).copy_csv(file)
end

# Alternatively, you can use `write_to_csv` to not have to deal with opening a file
User.where(unsubscribed: true).write_to_csv("unsubscribed_users.csv")
```

`unsubscribed_users.csv` will now contain all of the Users that have
unsubscribed, exactly how they would be in the database!

```
$ head unsubscribed_users.csv
id,name,email,unsubscribed
1,"John Smith","johnsmith@gmail.com",true
2,"Jane Smith","janesmith@gmail.com",true
3,"Jimbo Smith","jimbosmith@gmail.com",true
...
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'copy_csv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install copy_csv

## Usage

To use `copy_csv` on your User class, you first must include it in the model:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  include CopyCsv

  ...
end
```

Or better yet, include it in you `ApplicationRecord` to be used in all of your Rails models:

```ruby
# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  include CopyCsv
end
```

Additionally, if you do not want to include it in *every* model but just want
to use it in the rails console, your can just include it at will:

```ruby
[1] pry(main)> User.send(:include, CopyCsv)
```

And it can be used in that console session.

## Documentation

View the [docs](https://www.rubydoc.info/gems/copy_csv/).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jstumbaugh/copy_csv. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CopyCsv project’s codebases, issue trackers, chat
rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/jstumbaugh/copy_csv/blob/master/CODE_OF_CONDUCT.md).
