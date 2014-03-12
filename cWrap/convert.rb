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
Provides classes that store and convert between autotools and cmake option styles
=end

require './exceptions'

module Conversion

  # Class for wrapping simple options
  #
  # This class should also operate as the base class for more complex options.
  # This class particuarly is used for non boolean operators
  #
  # Takes two options

  class Option
    attr_reader :options, :cmake, :auto

    # Creates a new options class
    #
    # === Arguments
    #     :cmake: the name of the cmake command (No leading -)
    #     :auto: the name of the autotools command (no leading dashes)
    # ---
    # XXX: Does autotools have short options?

    def initialize(cmake, auto)
      if cmake.start_with?('-')
        raise Exceptions::OptionError, "Do not preface cmake options with -"
      elsif auto.start_with?('-')
        raise Exceptions::OptionError, "Do not preface autotools options with - or --"
      end

      @cmake = cmake
      @auto = auto
    end

    # Get the cmake values
    #
    # === Return
    #     returns a Struct with two values:
    #     :command: the cmake command
    #     :value: the value attached to that command

    def to_cmake(val)
      "-#{@cmake}=#{val}"
    end

    # get the autotools values
    #
    # === Return
    #     returns a Struct with two values:
    #     :command: the autotools command
    #     :value: the value attached to that command

    def to_autotools(val)
      "--#{@auto}=#{val}"
    end

  end

  # Class for wrapping switch options.
  #
  # Cmake does not use switches for options, it uses -command=<bool> instead, so
  # we need to have a wrapper for converting from CMAKE_OPTION=<bool> to
  # --(enable/disable)-option
  #
  # === Arguments:
  #     :cmake: the cmake command
  #     :auto: the autotools comand

  class Switch < Option

    def to_cmake(bool)
      raise Exceptions::OptionError, "Argument should be a boolean" unless [true, false].include?(bool)
      super
    end
    
    def to_autotools(bool)
      raise Exceptions::OptionError, "Argument should be a boolean" unless [true, false].include?(bool)

      if bool
        return "--enable-#{@auto}"
      else
        return "--disable-#{@auto}"
      end
    end

  end

end
