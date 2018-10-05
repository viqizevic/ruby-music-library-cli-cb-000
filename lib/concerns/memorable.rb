module Concerns::Memorable

  module ClassMethods
    def destroy_all
      self.all.clear
    end

    def create(name)
      self.new(name).tap do |instance|
        instance.save
      end
    end
  end

  module InstanceMethods
    def save
      self.class.all << self
    end
  end
end
