class AlternateName < ActiveRecord::Base
  belongs_to :user
  
  def get_original_object()
    return eval(self.ref_class).find_by_id(self.ref_id)
  end
end
