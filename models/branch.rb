class Branch
  attr_accessor :repo_name
  attr_accessor :name
  attr_accessor :days_since_last_commit
  attr_accessor :number_of_unmerged_commits
  attr_accessor :unmerged_commits

  def ==(other)
    other.class == self.class &&
    other.repo_name == self.repo_name &&
    other.name == self.name
  end
  alias :eql? :==

  def hash
    [@name, @repo_name].hash
  end
end