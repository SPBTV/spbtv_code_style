[![Build Status](https://travis-ci.org/SPBTV/spbtv_code_style.svg)](https://travis-ci.org/SPBTV/spbtv_code_style)

# SpbtvCodeStyle

This gem contains common `.rubocop.yml` file to simplify maintaining the same code style in various SpbTV projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spbtv_code_style'
```

And then execute:

    $ bundle

## Usage

Create `.rubocop.yml` file in your project with the following contents:

```yml
inherit_gem:
  spbtv_code_style: .rubocop.yml

# Project's oveerides goes below this line:
```



## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version,
update the version number in `spbtv_code_style.rb`, and then run `bundle exec rake release`, which will create a git
tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/spbtv/spbtv_code_style.

## License

Copyright 2015 SPB TV AG

Licensed under the Apache License, Version 2.0 (the ["License"](LICENSE)); you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
