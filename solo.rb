dir = File.absolute_path(File.dirname(__FILE__))

file_cache_path "/tmp/chef-solo"
cookbook_path [dir + "/cookbooks"]
