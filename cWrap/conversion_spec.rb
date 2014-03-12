# Copyright (c) 2014 Dylan Baker

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

=begin rdoc

This file is meant only for validating the code of CWrap, unless you are doing
development against CWrap, you will not need to install these files

=end

require './conversion'
require './exceptions'


describe Conversion::Option, '#new' do
  it "Does not accept leading '-' for autotools options" do
    expect { Conversion::Option.new('opt', '-opt') }.to raise_error(Exceptions::OptionError)
  end

  it "Does not accept leading '--' for autotools options" do
    expect { Conversion::Option.new('opt', '--opt') }.to raise_error(Exceptions::OptionError)
  end

  it "Does not accept leading '-' for cmake options" do
    expect { Conversion::Option.new('-opt', 'opt') }.to raise_error(Exceptions::OptionError)
  end
end

describe Conversion::Option, '#to_cmake' do
  it "Should add -" do
    test = Conversion::Option.new('DCMAKE_INSTALL_PREFIX', 'prefix')
    test.to_cmake('/usr').should match(/^-.*/)
  end

  it "Converts prefix correctly" do
    test = Conversion::Option.new('DCMAKE_INSTALL_PREFIX', 'prefix')
    test.to_cmake('/usr/bin').should eq('-DCMAKE_INSTALL_PREFIX=/usr/bin')
  end
end

describe Conversion::Option, '#to_autotools' do
  it "Should add --" do
    test = Conversion::Option.new('DCMAKE_INSTALL_PREFIX', 'prefix')
    test.to_autotools('/usr').should match(/^--.*/)
  end

  it "Convertts prefix correctly" do
    test = Conversion::Option.new('DCMAKE_INSTALL_PREFIX', 'prefix')
    test.to_autotools('/usr/bin').should eq('--prefix=/usr/bin')
  end
end


# vim: ft=rspec
