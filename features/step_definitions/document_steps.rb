Given /^I have a[n]* (.+) document$/ do |file_type|
  begin
    @file = Pruview::Document.new(FILES[file_type], OUTPUT_PATH)
  rescue Exception => err
    @complaint = err
  end
end

Given /^I have an invalid output path for documents$/ do
  begin
    @file = Pruview::Document.new(FILES['basic image'], INVALID_OUTPUT_PATH)
  rescue Exception => err
    @complaint = err
  end
end

