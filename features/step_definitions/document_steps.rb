Given /^I have a[n]* (.+) file document$/ do |file_type|
  begin
    @document = Pruview::Document.new(FILES[file_type], OUTPUT_PATH)
  rescue Exception => err
    @complaint = err
  end
end

Given /^I have an invalid output path document$/ do
  begin
    @document = Pruview::Document.new(FILES['basic image'], INVALID_OUTPUT_PATH)
  rescue Exception => err
    @complaint = err
  end
end

When /^I create a (.+) thumbnail from that file$/ do |format|
  @thumb_path = @document.send("to_#{format}", 'basic', 50, 50)
end

Then /^I should have a jpg thumbnail$/ do
  assert File.exists?(@thumb_path)
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
  assert_match /^Document not supported - file extension: .poop/, @complaint.message
end
