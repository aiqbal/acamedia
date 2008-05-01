module OnlineResourceHelper
  
  def online_resources
    return @online_resources if @online_resources
    @online_resources = OnlineResource.find :all,
                                  :select => "distinct online_resources.*",
                                  :from => "#{self.class.table_name}, online_resources",
                                  :conditions => ["online_resources.ref_id    = ? AND
                                                   online_resources.ref_class = '#{self.class.name}'", self.id]
    return @online_resources
  end

  def add_resource(resource_type, user, title, description, url)
    @online_resources = nil # expiring the currently cached result

    online_resource = OnlineResource.new(:ref_id => self.id, :ref_class => self.class.name, :title => title, :description => description, :url => url, :resource_type => resource_type, :user_id => user.id)
    online_resource.save
    return online_resource
  end
end
