watch('^(?!tmp)(?!static/css-compiled).*$') do
  system("node-sass static/scss/application.scss static/css-compiled/application.css")
  system("kanso push")
  system("touch tmp/livereload.txt")
end

puts "Watchr running."
