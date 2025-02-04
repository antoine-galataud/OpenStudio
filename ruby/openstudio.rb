########################################################################################################################
#  OpenStudio(R), Copyright (c) 2008-2021, Alliance for Sustainable Energy, LLC, and other contributors. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
#  following conditions are met:
#
#  (1) Redistributions of source code must retain the above copyright notice, this list of conditions and the following
#  disclaimer.
#
#  (2) Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
#  disclaimer in the documentation and/or other materials provided with the distribution.
#
#  (3) Neither the name of the copyright holder nor the names of any contributors may be used to endorse or promote products
#  derived from this software without specific prior written permission from the respective party.
#
#  (4) Other than as required in clauses (1) and (2), distributions in any form of modifications or other derivative works
#  may not use the "OpenStudio" trademark, "OS", "os", or any other confusingly similar designation without specific prior
#  written permission from Alliance for Sustainable Energy, LLC.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) AND ANY CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
#  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER(S), ANY CONTRIBUTORS, THE UNITED STATES GOVERNMENT, OR THE UNITED
#  STATES DEPARTMENT OF ENERGY, NOR ANY OF THEIR EMPLOYEES, BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
#  USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
#  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
########################################################################################################################

# add binary dir to system path
original_path = ENV['PATH']
if /mswin/.match(RUBY_PLATFORM) or /mingw/.match(RUBY_PLATFORM)

  if defined?(RubyInstaller::Runtime)

    cur_location = File.dirname(__FILE__)

    build_type = File.basename(cur_location)

    if build_type == "Debug" or build_type == "Release" or build_type == "RelWithDebugInfo" or build_type == "RelMinSize"
      # in build dir execution
      relative_dll_path = File.join(File.dirname(File.dirname(cur_location)), build_type)
      RubyInstaller::Runtime.add_dll_directory(relative_dll_path)
    else
      # install dir execution
      ['bin', 'lib'].each do |p|
        if File.exists?(File.join(File.dirname(cur_location), p))
          RubyInstaller::Runtime.add_dll_directory(File.join(File.dirname(cur_location), p))
        end
      end
    end
  end
else
  # Do something here for Mac OSX environments
  ENV['PATH'] = "#{File.dirname(__FILE__)}:#{original_path}"
end

# require openstudio.so
require_relative 'openstudio.so'

# restore original path
ENV['PATH'] = original_path

# add this directory to Ruby load path
$:.unshift(File.expand_path(File.dirname(__FILE__)))
