module AlternateNameHelper
  
  def alternate_names
    return @alternate_names if @alternate_names
    @alternate_names = AlternateName.find :all,
                                  :select => "distinct alternate_names.*",
                                  :from => "#{self.class.table_name}, alternate_names",
                                  :conditions => ["alternate_names.ref_id    = ? AND
                                                   alternate_names.ref_class = '#{self.class.name}'", self.id]
    return @alternate_names
  end

  def add_alternate_name(alternate_name, user)
    @alternate_names = nil # expiring the currently cached result

    new_alternate_name = AlternateName.new(:ref_id => self.id, :ref_class => self.class.name, :alternate_name => alternate_name, :user_id => user.id)
    new_alternate_name.save
    return new_alternate_name
  end

end
