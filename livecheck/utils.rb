require "net/http"

def git_tags(repo_url, filter = nil)
  raw_tags = `git ls-remote --tags #{repo_url}`
  raw_tags.gsub!(%r{^.*\trefs/tags/}, "")
  raw_tags.gsub!(/\^\{\}$/, "")

  tags = raw_tags.split("\n").uniq.sort
  tags.select! { |t| t =~ filter } if filter
  tags
end

def page_matches(url, regex)
  puts %[Using page_match("#{url}", "#{regex}")] if ARGV.debug?
  page = open(url).read
  matches = page.scan(regex)
  puts matches.join(", ") if ARGV.debug?
  matches.map(&:first).uniq
end

