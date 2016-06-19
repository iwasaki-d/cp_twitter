require File.expand_path('../boot', __FILE__)
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CpTwitter
  class Application < Rails::Application
    config.time_zone = 'Tokyo'

    # config.i18n.default_locale = :ja

    config.active_record.raise_in_transactional_callbacks = true
  end
end
