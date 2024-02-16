module SimpleCommand
  module ClassMethods
    def call(*, **)
      new(*, **).call
    end
  end
end
