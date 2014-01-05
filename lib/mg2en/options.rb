module Mg2en

  class Options

    @defaults = {
      :verbose  => false,
      :template => 'default',
      :image_size => 192,
    }

    # The default option values.
    # @return Hash
    def self.defaults
      @defaults
    end

  end

end