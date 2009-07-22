When /^I create a (.+) thumbnail$/ do |format|
  @output = @file.send("to_#{format}", 'file', 50, 50)
end

Then /^I should have a[n]* (.+) file$/ do |format|
  assert File.exists?(@output)
  assert File.extname(@output), format
end

Then /^Pruview should complain about an invalid source file$/ do
  assert @complaint
  assert_kind_of Pruview::Exceptions::InvalidError, @complaint
  assert_match /^Invalid source file/, @complaint.message
end

Then /^Pruview should complain about an invalid output path$/ do
  assert @complaint
  assert_kind_of Pruview::Exceptions::InvalidError, @complaint
  assert_match /^Invalid target directory/, @complaint.message
end

Then /^Pruview should complain about an invalid source file format$/ do
  assert @complaint
  assert_kind_of Pruview::Exceptions::InvalidError, @complaint
  assert_match /not supported - file extension: .poop/, @complaint.message
end

Then /^Pruview should complain about an error$/ do
  assert @complaint
  assert_kind_of Pruview::Exceptions::InvalidError, @complaint
  assert_match /not supported - file extension: .poop/, @complaint.message
end
