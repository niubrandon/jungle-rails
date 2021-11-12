class Sale < ActiveRecord::Base

  #scope :active, -> { where("sales.starts_on <= ? AND sales.ends_on", Date.current, Date.current)}

  def self.active
    where("sales.starts_on <= ? AND sales.ends_on", Date.current, Date.current) 
  end
  # AR Scope
  def finished?
   return ends_on < Date.current
  end

  def upcoming?
    return starts_on > Date.current
  end

  def active?
    return !upcoming? && !finished?
  end


end
