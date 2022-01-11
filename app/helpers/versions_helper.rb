module VersionsHelper
  def git_commit_hash
    `git log -1 --format="%h"`
  end
end
