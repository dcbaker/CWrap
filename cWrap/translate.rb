# encoding: UTF-8
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

Provides static lookup tables for converting the most common cmake and
autootools options quickly and efficiently

=end

require './convert'

module Trans
  attr_reader :table

  # FIXME: Add documentation
  #
  class Translate
    def initialize
      @table = Array.new([
        Conversion::Option.new('DCMAKE_INSTALL_PREFIX', 'prefix'),
        Conversion::Switch.new('DCMAKE_BUILD_TYPE', 'debug',
                               { true => 'Release', false => 'Debug' })
      ])
    end

    # FIXME: Add documentaiton
    #
    def add_option(cmake, auto)
      @table.push(Conversion::Option.new(cmake, auto))
    end

    # FIXME: ADD documentation
    #
    def add_switch(cmake, auto, options)
      @table.push(Conversion::Switch.new(cmake, auto, options))
    end
  end
end
