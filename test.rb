require "selenium-webdriver"

profile = Selenium::WebDriver::Firefox::Profile.new
#profile['devtools.errorconsole.enabled'] = false
profile['devtools.chrome.enabled'] = false
profile['devtools.errorconsole.enabled'] = false
%w[css csserror csslog cssparser error exception info jslog jswarn log netwarn network networkinfo netxhr secerror secwarn serviceworkers sharedworkers warn windowlessworkers].each do |m|
  profile["devtools.browserconsole.filter.#{m}"] = false
end

%w[csserror csslog cssparser error exception info jslog jswarn log netwarn network networkinfo netxhr secerror secwarn serviceworkers sharedworkers warn windowlessworkers].each do |m|
  profile["devtools.webconsole.filter.#{m}"] = false
end

d = Selenium::WebDriver::Remote::Capabilities.firefox
d = Selenium::WebDriver::Remote::Capabilities.chrome
#d[:loggingPrefs] = {browser: 'ALL'}
d[:loggingPrefs] = { "driver": "ALL", "server": "OFF", "browser": "ALL" }

#driver = Selenium::WebDriver.for :firefox, desired_capabilities: d
driver = Selenium::WebDriver.for :firefox, desired_capabilities: d, profile: profile

driver.navigate.to "https://www.example.com"
element = driver.find_element(:name, 'q')
element.send_keys "Hello WebDriver!"
element.submit
l = driver.manage.logs.get :browser

puts driver.title
m = driver.manage.logs.get :browser

driver.quit
