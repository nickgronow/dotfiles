require 'rubygems'
require 'hirb'

# IRB extensions
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:IGNORE_SIGINT] = false

# Helper methods for all objects
class Object
  # Easily print methods local to an object's class
  def local_methods
    (methods - Object.instance_methods).sort
  end

  def inspect
    ap self
  rescue StandardError
    super
  end
end
