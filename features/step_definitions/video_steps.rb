Given /^I have a[n]* (.+) file$/ do |file_type|
  begin
    @file = Pruview::Video.new(FILES[file_type], OUTPUT_PATH)
  rescue Exception => err
    @complaint = err
  end
end

Given /^I have an invalid output path for videos$/ do
  begin
    @file = Pruview::Video.new(FILES['basic video'], INVALID_OUTPUT_PATH)
  rescue Exception => err
    @complaint = err
  end
end

