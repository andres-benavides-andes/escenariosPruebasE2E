if ENV["ADB_DEVICE_ARG"].nil?
  require 'kraken-mobile/steps/web/kraken_steps'
  require "selenium-webdriver"

  Before do |scenario|
    $featurescenariostep = scenario.name
    $id = 0
  end
  
  Then(
    /^I select option with value "(.*?)" for dropdown having css selector "(.*?)"$/
  ) do |op_value, sel_id|
    drop = @driver.find_element(:css, sel_id)
    choose = Selenium::WebDriver::Support::Select.new(drop)
    choose.select_by(:value, op_value)
    sleep 2
  end
  
  Then(/^I store a variable with the current url$/) do
    $url_variable = @driver.current_url    
    File.write('./.variable.txt', $url_variable)
    puts($url_variable) 
  end

  Then(/^I navigate to page with the url stored in the variable$/) do
    $url_variable = IO.read("./.variable.txt")  
    puts($url_variable)
    @driver.navigate.to $url_variable
    sleep 2
  end

  Given(/^I have a version "([^\"]*)"$/) do |versionapp|
    $versionapp = versionapp
  end

  AfterStep do |_scenario|
    if $id > 0
      Dir.mkdir("./tvr") unless File.exist?("./tvr")
      Dir.mkdir("./tvr/#{$versionapp}") unless File.exist?("./tvr/#{$versionapp}")
      Dir.mkdir("./tvr/#{$versionapp}/#{$featurescenariostep}") unless File.exist?("./tvr/#{$versionapp}/#{$featurescenariostep}")
      path = "./tvr/#{$versionapp}/#{$featurescenariostep}/#{$featurescenariostep}_#{$id}.png"
      @driver.save_screenshot(path)
      embed(path, 'image/png', File.basename(path))
    end
    $id += 1
  end

# Steps for Tag association feature-----------------------------------------------------

  $delay1 = 0.5
  $delay2 = $delay1*2

  def waitTo(css_selector)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { @driver.find_element(css: css_selector) }
  end

  def fill_a_text_field(css_selector, input)
    element =   @driver.find_element(css: css_selector)
    element.clear
    element.send_keys input
  end

  def waitAndFill(css_selector, input)
    waitTo(css_selector);
    fill_a_text_field(css_selector, input);
  end

  def clickOn(css_selector)
    @driver.find_element(css: css_selector).click
  end

  def waitAndClick(css_selector)
    waitTo(css_selector)
    clickOn(css_selector)
  end

  When(/^I log in ghost local app as an administrator with this user "([^\"]*)" and password "([^\"]*)"$/) do |userName, password|
    @driver.navigate.to "http://localhost:2368/ghost/#/signin"
    waitTo('input[name="identification"]')
    fill_a_text_field('input[name="identification"]', userName )
    fill_a_text_field('input[name="password"]', password )
    waitAndClick('button[type="submit"]')
    waitTo('a[href="#/tags/"]') #just waithing until the page display after log in
  end

  When(/^I log in ghost local app as an administrator$/) do
    @driver.navigate.to "http://localhost:2368/ghost/#/signin"
    waitTo('input[name="identification"]')
    fill_a_text_field('input[name="identification"]', 'jhon@example.com')
    fill_a_text_field('input[name="password"]', 'asdfw54665')
    waitAndClick('button[type="submit"]')
    waitTo('a[href="#/tags/"]') #just waithing until the page display after log in
  end

  Then(/^I create a tag with the name  "(.*?)", and the description "(.*?)"$/) do |tagName, description|
    clickOn('a[href="#/tags/"]')
    waitAndClick('a[href="#/tags/new/"]')
    waitTo('#tag-name')
    fill_a_text_field("#tag-name", tagName)
    fill_a_text_field("#tag-description", description)
    waitAndClick('button[class="gh-btn gh-btn-blue gh-btn-icon ember-view"]')
  end

  Then(/^I delete the tag with the slug "(.*?)"$/) do |tagSlug|
    waitAndClick('a[href="#/tags/"]')
    waitTo('a[href="#/tags/new/"]')
    waitAndClick('a[href="#/tags/'+ tagSlug +'/"]')
    waitAndClick('button[class="gh-btn gh-btn-red gh-btn-icon mb15"]')
    sleep $delay2
    waitAndClick('button[class="gh-btn gh-btn-red gh-btn-icon ember-view"]')
  end

  Then(/^I create a draf post with the title "(.*?)"$/) do |postTitle|
    waitAndClick('a[href="#/posts/"]')
    waitAndClick('a[href="#/editor/post/"]')
    waitAndFill('textarea[placeholder="Post Title"]', postTitle)
    fill_a_text_field('div[data-placeholder="Begin writing your post..."]', "")
    sleep $delay1
    waitAndClick('a[href="#/posts/"]')
    sleep $delay1
  end

  Then(/^I create a draf page with the title "(.*?)"$/) do |pageTitle|
    waitAndClick('a[href="#/pages/"]')
    waitAndClick('a[href="#/editor/page/"]')
    waitAndFill('textarea[placeholder="Page Title"]', pageTitle)
    fill_a_text_field('div[data-placeholder="Begin writing your page..."]', "")
    sleep $delay1
    waitAndClick('a[href="#/pages/"]')
    sleep $delay1
  end

  Then(/^I delete the post with the title "(.*?)"$/) do |postTitle|
    waitAndClick('a[href="#/posts/"]')
    waitTo('a > h3')
    element = @driver.find_elements(css: 'a > h3').select {|el| el.text == postTitle }.first
    element.click
    waitAndClick('button.post-settings')
    sleep $delay1
    waitAndClick('button.settings-menu-delete-button')
    sleep $delay2
    waitAndClick('button[class="gh-btn gh-btn-red gh-btn-icon ember-view"]')
  end

  Then(/^I delete the page with the title "(.*?)"$/) do |pageTitle|
    waitAndClick('a[href="#/pages/"]')
    waitTo('a > h3')
    element = @driver.find_elements(css: 'a > h3').select {|el| el.text == pageTitle }.first
    element.click
    waitAndClick('button.post-settings')
    sleep $delay1
    waitAndClick('button.settings-menu-delete-button')
    sleep $delay2
    waitAndClick('button[class="gh-btn gh-btn-red gh-btn-icon ember-view"]')
  end

  Then(/^I associate the tag "(.*?)" with the post "(.*?)"$/) do |tagName, postTitle|
    waitAndClick('a[href="#/posts/"]')
    waitTo('a > h3')
    element = @driver.find_elements(css: 'a > h3').select {|el| el.text == postTitle }.first
    element.click
    waitAndClick('button.post-settings')
    sleep $delay1
    element = @driver.find_element(id: 'tag-input')
    element.send_keys tagName
    element.send_keys :enter
    waitAndClick('button.close')
    waitAndClick('div.gh-publishmenu-trigger')
    sleep $delay2
    waitAndClick('button.gh-publishmenu-button')
    sleep $delay1
    waitAndClick('a[href="#/posts/"]')
  end

  Then(/^I associate the tag "(.*?)" with the page "(.*?)"$/) do |tagName, pageTitle|
    waitAndClick('a[href="#/pages/"]')
    waitTo('a > h3')
    element = @driver.find_elements(css: 'a > h3').select {|el| el.text == pageTitle }.first
    element.click
    waitAndClick('button.post-settings')
    sleep $delay1
    element = @driver.find_element(id: 'tag-input')
    element.send_keys tagName
    element.send_keys :enter
    waitAndClick('button.close')
    waitAndClick('div.gh-publishmenu-trigger')
    sleep $delay2
    waitAndClick('button.gh-publishmenu-button')
    sleep $delay1
    waitAndClick('a[href="#/pages/"]')
  end

  Then(/^I validate that tag "(.*?)" is associate with the post "(.*?)"$/) do |tagName, postTitle|
    waitAndClick('a[href="#/tags/"]')
    waitTo('a[href="#/tags/new/"]')
    waitAndClick("a[title=\"List posts tagged with '"+ tagName +"'\"]")
    sleep $delay1
    waitTo('a > h3')
    element = @driver.find_elements(css: 'a > h3').select {|el| el.text == postTitle }.first
    assert(element.text == postTitle)
  end

  Then(/^I validate that tag "(.*?)" is associate with a page$/) do |tagName|
    waitAndClick('a[href="#/tags/"]')
    waitTo('a[href="#/tags/new/"]')
    sleep $delay1
    waitTo("a[title=\"List posts tagged with '"+ tagName +"'\"] > span")
    element = @driver.find_elements(css: "a[title=\"List posts tagged with '"+ tagName +"'\"] > span").select {|el| el.text == '1 post' }.first
    assert(element.text == '1 post')
  end

  Then(/^I detach the the last tag associated to the post "(.*?)"$/) do |postTitle|
    waitAndClick('a[href="#/posts/"]')
    waitTo('a > h3')
    element = @driver.find_elements(css: 'a > h3').select {|el| el.text == postTitle }.first
    element.click
    waitAndClick('button.post-settings')
    sleep $delay1
    element = @driver.find_element(id: 'tag-input')
    element.send_keys :backspace
    waitAndClick('button.close')
    waitAndClick('div.gh-publishmenu-trigger')
    sleep $delay2
    waitAndClick('button.gh-publishmenu-button')
    sleep $delay1
    waitAndClick('a[href="#/posts/"]')
  end

  Then(/^I check that tag "(.*?)" don't have any post related$/) do |tagName|
    waitAndClick('a[href="#/tags/"]')
    waitTo('a[href="#/tags/new/"]')
    sleep $delay1
    waitTo('a > span')
    element = @driver.find_elements(css: 'a > span').select {|el| el.text == '0 posts' }.first
    assert(element.text == '0 posts')
  end


end
