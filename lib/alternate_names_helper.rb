module AlternateNamesHelper
  
  def alternate_names
    return @alternate_names if @alternate_names
    @alternate_names = OnlineResource.find :all,
                                  :select => "distinct alternate_names.*",
                                  :from => "#{self.class.table_name}, alternate_names",
                                  :conditions => ["alternate_names.ref_id    = ? AND
                                                   alternate_names.ref_class = '#{self.class.name}'", self.id]
    return @alternate_names
  end

  def add_alternate_name(user, alternate_name)
    @alternate_names = nil # expiring the currently cached result

    alternate_name = AlternateNames.new(:ref_id => self.id, :ref_class => self.class.name, :alternate_name => alternate_name, :user_id => user.id)
    alternate_name.save
    return alternate_name
  end

  def get_original_name(alternate_name)
    alternate_name = AlternateNames.find_by_alternate_name(alternate_name)
    return alternate_name
  end
end
