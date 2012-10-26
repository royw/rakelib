require 'spec_helper'

describe 'Version string' do
  it 'should have a version constant defined' do
    Example::VERSION.should_not be_nil
    Example::VERSION.should_not be_empty
  end
end