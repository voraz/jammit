# Standard Library Dependencies:
require 'uri'
require 'zlib'
require 'base64'
require 'pathname'
require 'fileutils'

# Gem Dependencies:
require 'yui/compressor'
require 'closure-compiler'
# require 'active_support'

# Load initial configuration before the rest of Jammit.
Jammit.load_configuration(Jammit::DEFAULT_CONFIG_PATH) if defined?(Rails)

# Jammit Core:
require 'jammit/compressor'
require 'jammit/packager'
# Jammit Rails Integration:
# if defined?(Rails)
  # require 'jammit/controller' # Rails will auto-load 'jammit/helper' for us.
  # require 'jammit/routes'
# end
ActionView::Base.send(:include, JammitHelper)
if Rails.env.development?
  ActionController::Base.class_eval do
    append_before_filter { Jammit.reload! }
  end
end