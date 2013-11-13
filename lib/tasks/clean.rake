task :clean do
  Package.all.each { |package| package.destroy if package.hours_left <= 0 }
end
