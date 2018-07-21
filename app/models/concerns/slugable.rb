module Slugable

  module InstanceMethods
    def slug
      name.downcase.gsub(" ","-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{|object| object.slug == slug.downcase}
    end
  end
  
end
