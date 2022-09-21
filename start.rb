require_relative 'core'

integration = Core.new
integration.parse_opts(ARGV)

integration.enable_color(integration.opts.color)

integration.start
