require 'factory_girl'
require 'capybara'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before do
    FactoryGirl.reload
  end

  config.include FactoryGirl::Syntax::Methods

  def not_to_be_valid_max_length(model, valid_symbol)
    expect(model).not_to be_valid
    expect(model.errors[valid_symbol].first).to include ('too long')
  end

  def not_to_be_valid_presence(model, valid_symbol)
    expect(model).not_to be_valid
    expect(model.errors[valid_symbol].first).to include ("can't be blank")
  end

  Capybara.default_driver = :selenium
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end
  Capybara.javascript_driver = :firefox

  config.before(:suite) do
    #tweetモデルがコミット後にredisを使った処理をするため、redisサーバーを立ち上げないとseedが失敗する
    Process.spawn 'redis-server'

    require Rails.root.join('db', 'seeds')
  end
end
