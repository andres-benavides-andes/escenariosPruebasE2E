if ENV["ADB_DEVICE_ARG"].nil?
  require 'kraken-mobile/steps/web/kraken_steps'

  Then(
    /^I select option with value "(.*?)" for dropdown having css selector "(.*?)"$/
  ) do |op_value, sel_id|
    drop = @driver.find_element(:css, sel_id)
    choose = Selenium::WebDriver::Support::Select.new(drop)
    choose.select_by(:value, op_value)
    sleep 2
  end
  
end
