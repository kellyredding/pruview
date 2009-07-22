Given /^I have a[n]* (.+) video image (.+)$/ do |file_type, format|
  begin
    @output = Pruview::VideoImage.send("to_#{format}", FILES[file_type], OUTPUT_PATH, 'file')
  rescue Exception => err
    @complaint = err
  end
end

Given /^I have an invalid output path for video images$/ do
  begin
    @output = Pruview::VideoImage.to_jpg(FILES['basic video'], INVALID_OUTPUT_PATH, 'file')
  rescue Exception => err
    @complaint = err
  end
end

