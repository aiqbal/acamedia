module ThumbHelper
  
  def thumbs
    return @thumbs if @thumbs
    @thumbs = Thumb.find :all,
                          :select => "distinct thumbs.*",
                          :from => "#{self.class.table_name}, thumbs",
                          :conditions => ["thumbs.ref_id = ? AND
                                           thumbs.thumb_class = '#{self.class.name}'", self.id]
    return @thumbs
  end

  def add_thumb(type, user)
    return false if !self.id or !user.id
    t = Thumb.find(:first, :conditions => ["ref_id = ? and thumb_class = ? and user_id = ?", self.id, self.class.name, user.id])
    t ||= Thumb.new
    t.thumb_type  = type
    t.thumb_class = self.class.name
    t.user        = user
    t.ref_id      = self.id
    if t.save
      @thumbs = nil # expiring the current thumbs so they are loaded again
      return t
    else
      return false
    end
  end
end
