# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
  config.default_cassette_options = {
    allow_playback_repeats: true,
    match_requests_on:      %i[method path]
  }
end
