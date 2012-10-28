Given /^the application module, (\S+)$/ do |module_name|
  @module_name = module_name
end

When /^the (\S+) constant is read$/ do |konstant_name|
  klasses = []
  ObjectSpace.each_object(Module).each {|k| klasses << k if k.name == @module_name}
  unless klasses.empty?
    @konstant_value = klasses.first.const_get(konstant_name.to_s.to_sym)
  end
end

Then /^the version value is a non\-nil string$/ do
  @konstant_value.should_not be_nil
end

Then /^the version is a string that matches the regex: (\S+)$/ do |regex|
  @konstant_value.should match Regexp.new(regex.gsub(%r{^\/}, '').gsub(%r{\/$}, ''))
end
