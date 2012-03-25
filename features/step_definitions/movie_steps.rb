Given /^the following (.+) exist:$/ do |items, table|
  table.hashes.each do |hash|
    klass = items.classify.constantize
    klass.create!(hash)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  page.should have_content("Details about Alien")
  page.should have_content("Ridley Scott")
end
