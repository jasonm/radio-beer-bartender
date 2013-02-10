watch('.*') { system("kanso push #{ENV['KANSO_DATABASE'] || 'radio_beer_development'}") }
