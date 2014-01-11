module Mg2en
  # This class holds library options.
  class Options
    @defaults = {
      verbose: false,
      template: 'default',
      image_size: 192,
    }

    # The default option values.
    # @return Hash
    def self.defaults # rubocop:disable TrivialAccessors
      @defaults
    end
  end
end
