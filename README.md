# Dry::ElasticModel [![Gem Version](https://badge.fury.io/rb/dry-elastic_model.svg)](https://rubygems.org/gems/dry-elastic_model) [![Build Status](https://travis-ci.org/koleksiuk/dry-elastic_model.svg?branch=master)](https://travis-ci.org/koleksiuk/dry-elastic_model) [![Test Coverage](https://api.codeclimate.com/v1/badges/feba233f76f9fd76a6ad/test_coverage)](https://codeclimate.com/github/koleksiuk/dry-elastic_model/test_coverage) [![Maintainability](https://api.codeclimate.com/v1/badges/feba233f76f9fd76a6ad/maintainability)](https://codeclimate.com/github/koleksiuk/dry-elastic_model/maintainability)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-elastic_model'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dry-elastic_model

## Usage

This gem was created to provide a thin layer between Elasticsearch models mapping and Ruby objects. Right now, if you want to build your own Elasticsearch wrapper, you're on your own when it comes to creating document mappings and mapping ES documents to Ruby code, which can be painful especially if you want to also validate them before pushing.

Responsibilities of this library:
* models that represent Elasticsearch documents
* converting and validating Ruby objects to Elasticsearch documents
* converting & validating Elasticsearch documents to Ruby objects
* providing mapping out-of-box based on created models

Sample model:

```ruby
  class FooBar < Dry::ElasticModel::Base
    field :text_field, :text
    field :keyword_field, :keyword, index: false
    field :date_field, :date
    field :long_field, :long
    field :double_field, :double
    field :boolean_field, :boolean
    field :ip_field, :ip
    list  :list_text_field, :text
    range :range_long_field, :long
  end
```

This corresponds to following Elasticsearch mapping (calling `Foo.mapping.to_json`):

```json
{
  "foobar": {
    "properties": {
      "text_field": {
        "type": "text",
        "index": "not_analyzed"
      },
      "keyword_field": {
        "type": "keyword",
        "index": false
      },
      "date_field": {
        "type": "date",
        "format": "strict_date_optional_time||epoch_millis"
      },
      "long_field": {
        "type": "long"
      },
      "double_field": {
        "type": "double"
      },
      "boolean_field": {
        "type": "boolean"
      },
      "ip_field": {
        "type": "ip"
      },
      "list_text_field": {
        "type": "text"
      },
      "range_long_field": {
        "type": "long_range"
      }
    }
  }
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dry-elastic_model. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dry::ElasticModel project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dry-elastic_model/blob/master/CODE_OF_CONDUCT.md).
