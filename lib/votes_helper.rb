module VotesHelper
 def votes
    return @votes if @votes
    @votes = Vote.find :all,
                       :select => "distinct votes.*",
                       :from => "#{self.class.table_name}, votes",
                       :conditions => ["votes.ref_id = ? AND
                                        votes.ref_class = '#{self.class.name}'", self.id]
    return @votes
  end

  def get_vote_summary
    VotesSummary.find(:first, :conditions => ["ref_id = ? and ref_class = ?", self.id, self.class.name])
  end

  def get_vote(user)
    Vote.find(:first, :conditions => ["ref_id = ? and ref_class = ? and user_id = ?", self.id, self.class.name, user.id])
  end
  
  def change_vote(vote, vote_summary)
    if vote.agreement == 1
      vote_summary.yes += 1
      vote_summary.no -= 1
    else
      vote_summary.no += 1
      vote_summary.yes -= 1
    end
    vote.agreement = (vote.agreement + 1)%2
  end
  
  def add_new_vote(agreement, user, vote_summary)
    vote = Vote.new(:ref_class => self.class.name, :user_id => user.id, :ref_id => self.id, :agreement => agreement)
    vote_summary.yes += 1 if agreement == 1
    vote_summary.no  += 1 if agreement == 0
    return vote
  end
 
  def add_vote(agreement, user) #agree is either 0 or 1
    return false if !self.id or !user.id
    vote_summary = get_vote_summary || VotesSummary.new(:ref_class => self.class.name, :ref_id => self.id)
    vote = get_vote(user)
    begin
      @votes = nil
      if vote and vote.agreement == agreement
        return true
      elsif vote
        change_vote(vote, vote_summary)
      else
        vote = add_new_vote(agreement, user, vote_summary)
      end
      Vote.transaction do
        VotesSummary.transaction do
          vote.save!
          vote_summary.save!
        end
      end
      return true
    rescue ActiveRecord::StatementInvalid => e # coz of slaves not synched with the master
      return false
    rescue ActiveRecord::StaleObjectError
     return false # Attempted to update a stale object
    end
  end
end