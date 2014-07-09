# Gembeat

Gembeat enables you to automatically send a summary of all the current gems in your application on initialization to a central server.

## Installation

Add this line to your application's Gemfile:

    gem 'gembeat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gembeat

## Usage

Add a yaml config to config/gembeat.yml:

``` yaml
token: token
pulse_url: http://gembeat-server.tld/pulse
```

Place this in production.rb:

``` ruby
config.after_initialize do
  gembeat_config = YAML.load_file("#{Rails.root.to_s}/config/gembeat.yml")
  Gembeat.token = gembeat_config["token"]
  Gembeat.pulse_url = gembeat_config["pulse_url"]
  Gembeat.use_ssl = true # (Optional) Use a secure connection
  Gembeat.send_pulse
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
